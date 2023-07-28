import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:tennis_app/components/game_buttons/advanced/advanced_buttons.dart';
import 'package:tennis_app/components/game_score/score_board.dart';
import 'package:tennis_app/components/results/render_result.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/services/cancel_match.dart';
import 'package:tennis_app/services/get_match_by_id.dart';

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
    EasyLoading.show(status: "Cargando...");
    await getMatch();
    EasyLoading.dismiss();
  }

  getMatch() async {
    final result = await getMatchById(widget.matchId);

    if (result.isFailure) {
      return;
    }
    setState(() {
      match = result.getValue();
    });
  }

  initSocket() {
    socket = IO.io("ws://localhost:3000", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print("connect");
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
    };
  }

  @override
  Widget build(BuildContext context) {
    pauseMatchModal(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
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
                  child: const Text("Volver"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text("Aceptar"),
                ),
              ],
            );
          });
    }

    handleCancelMatch() {
      EasyLoading.show(status: "Cargando...");
      final data = finishMatchData();
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
        print(e);
        showMessage(
          context,
          "Ha ocurrido un error",
          ToastType.error,
        );
        EasyLoading.dismiss();
      });
    }

    cancelMatchModal(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Quieres cancelar el partido?",
                textAlign: TextAlign.center,
              ),
              content: const Text(
                "El partido sera finalizado en el estado actual",
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
                    handleCancelMatch();
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text("Aceptar"),
                ),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        bottom: const TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Botones"),
            Tab(text: "Estadisticas"),
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
              )
            ],
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: TabBarView(
          children: [
            Column(
              children: [
                const ScoreBoard(),
                AdvancedButtons(
                  updateMatch: updateMatch,
                  finishMatchData: finishMatchData,
                  finishMatch: finishMatch,
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
    );
  }
}
