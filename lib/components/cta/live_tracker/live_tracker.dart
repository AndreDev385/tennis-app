import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:tennis_app/components/game_buttons/advanced/advanced_buttons.dart';
import 'package:tennis_app/components/game_score/score_board.dart';
import 'package:tennis_app/components/results/render_result.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/environment.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/services/cancel_match.dart';
import 'package:tennis_app/services/get_match_by_id.dart';
import 'package:tennis_app/services/pause_match.dart';

class LiveTracker extends StatefulWidget {
  const LiveTracker({
    super.key,
    required this.matchId,
    required this.gameProvider,
  });

  final GameRules gameProvider;
  final String matchId;

  @override
  State<LiveTracker> createState() => _LiveTrackerState();
}

class _LiveTrackerState extends State<LiveTracker> {
  late IO.Socket socket;
  MatchDto? match;

  @override
  void initState() {
    initSocket();
    getData();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  getData() async {
    EasyLoading.show();
    await getMatch();
    EasyLoading.dismiss();
  }

  getMatch() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    final result = await getMatchById(widget.matchId).catchError((e) {
      throw e;
    });

    if (result.isFailure) {
      EasyLoading.showError("Error al cargar partido");
      return;
    }

    String? matchSaved = storage.getString("live");

    if (matchSaved == null) {
      await widget.gameProvider.createStorageMatch(result.getValue());
    }

    setState(() {
      match = result.getValue();
    });
  }

  initSocket() {
    socket = IO.io(Environment.webSockets, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });

    socket.connect();

    socket.on("server:join_room", (data) {
      updateMatch();
    });

    socket.onConnect((_) {
      connectToRoom();
    });

    socket.onError((err) {
      print("onError: $err");
    });

    socket.onConnectError((err) {
      print("onConnectError: $err");
    });

    socket.onDisconnect((data) => {print("disconnect: $data")});
  }

  connectToRoom() {
    Map messageMap = {'message': widget.matchId};
    socket.emit("client:join_room", messageMap);
  }

  updateMatch() {
    Match? match = widget.gameProvider.match;
    final data = {
      'matchId': widget.matchId,
      'matchStats': match?.tracker?.toJson(
        matchId: this.match?.matchId,
        trackerId: this.match?.tracker?.trackerId,
        player1TrackerId: this.match?.tracker?.me.playerTrackerId,
        player2TrackerId: this.match?.tracker?.partner?.playerTrackerId,
        player1Id: this.match?.tracker?.me.playerId,
        player2Id: this.match?.tracker?.partner?.playerId,
      ),
      'sets': match?.sets.map((e) => e.toJson()).toList(),
      'currentGame': match?.currentGame.toJson(),
      'servingPlayer': match?.servingPlayer,
      'rivalBreakPts': match?.tracker?.rivalBreakPoints(match.currentGame),
    };

    socket.emit("client:update_match", data);
  }

  finishMatch() {
    socket.emit("client:match_finish", {'message': widget.matchId});
  }

  finishMatchData() {
    Match? match = widget.gameProvider.match;
    return {
      'tracker': match?.tracker?.toJson(
        matchId: this.match?.matchId,
        trackerId: this.match?.tracker?.trackerId,
        player1TrackerId: this.match?.tracker?.me.playerTrackerId,
        player2TrackerId: this.match?.tracker?.partner?.playerTrackerId,
        player1Id: this.match?.tracker?.me.playerId,
        player2Id: this.match?.tracker?.partner?.playerId,
      ),
      'sets': match?.sets.map((e) => e.toJson()).toList(),
      'superTieBreak': match?.superTiebreak ?? false,
      "matchWon": match?.matchWon,
    };
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    pop() {
      Navigator.of(context).pushNamed(CtaHomePage.route);
    }

    handlePauseMatch() async {
      Match match = widget.gameProvider.match!;

      final result = await pauseMatch(match.toJson(
        matchId: this.match?.matchId,
        trackerId: this.match?.tracker?.trackerId,
        player1TrackerId: this.match?.tracker?.me.playerTrackerId,
        player2TrackerId: this.match?.tracker?.partner?.playerTrackerId,
        player1Id: this.match?.tracker?.me.playerId,
        player2Id: this.match?.tracker?.partner?.playerId,
      ));

      if (result.isFailure) {
        showMessage(
          context,
          result.error!,
          ToastType.error,
        );
        return;
      }

      gameProvider.finishMatch();

      showMessage(
        context,
        result.getValue(),
        ToastType.success,
      );

      await gameProvider.removePendingMatch();

      pop();
    }

    pauseMatchModal(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text(
                "Quieres pausar el partido?",
                textAlign: TextAlign.center,
              ),
              content: const Text(
                "Pausar el partido en el estado actual. Luego puedo ser reanudado",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Volver",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    handlePauseMatch();
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Aceptar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    handleCancelMatch(bool? matchWon) {
      EasyLoading.show();
      final data = finishMatchData();
      if (matchWon != null) {
        data['matchWon'] = matchWon;
      }
      print(data);
      cancelMatch(data).then((value) {
        EasyLoading.dismiss();
        if (value.isFailure) {
          showMessage(
            context,
            value.error ?? "Ha ocurrido un error",
            ToastType.error,
          );
          return;
        }
        Navigator.of(context).pushNamed(CtaHomePage.route);
        showMessage(
          context,
          value.getValue(),
          ToastType.success,
        );
      }).catchError((e) {
        showMessage(
          context,
          "Ha ocurrido un error",
          ToastType.error,
        );
        EasyLoading.dismiss();
      });

      gameProvider.removePendingMatch();
    }

    cancelMatchModal(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            bool? matchWon;
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: const Text(
                  "Quieres cancelar el partido?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: SizedBox(
                  height: 140,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Elige una opcion para terminar el partido",
                          textAlign: TextAlign.center,
                        ),
                        DropdownButton(
                          value: matchWon,
                          hint: Text("Partidos"),
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                              value: null,
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: true,
                              child: Text(
                                "Ganar por w/o",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text(
                                "Perder por w/o",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (dynamic value) {
                            setState(() {
                              matchWon = value;
                            });
                          },
                        )
                      ]),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text("Volver"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      handleCancelMatch(matchWon);
                    },
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text("Aceptar"),
                  ),
                ],
              ),
            );
          });
    }

    modalBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Estas seguro de salir del partido actual?"),
              content: const Text(
                  "Si continuas el partido sera pausado, podrás continuarlo mas adelante."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    handlePauseMatch();
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Aceptar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: () => modalBuilder(context) as Future<bool>,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Botones"),
              Tab(text: "Estadísticas"),
            ],
          ),
          centerTitle: true,
          title: const Text("Juego"),
          leading: CloseButton(onPressed: () => cancelMatchModal(context)),
          actions: [
            ButtonBar(
              children: [
                FilledButton(
                  child: const Icon(Icons.pause),
                  onPressed: () => pauseMatchModal(context),
                ),
              ],
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: TabBarView(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: const ScoreBoard(),
                  ),
                  SliverFillRemaining(
                    child: AdvancedButtons(
                      updateMatch: updateMatch,
                      finishMatchData: finishMatchData,
                      finishMatch: finishMatch,
                    ),
                  ),
                ],
              ),
              ListView(
                children: [
                  ResultTable(
                    match: widget.gameProvider.match!,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
