import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/providers/curr_tournament_provider.dart';
import 'package:tennis_app/screens/tournaments/tournament_page.dart';
import 'package:tennis_app/services/tournaments/match/update_match.dart';
import 'package:tennis_app/utils/format_player_name.dart';

import '../../components/full_stats_tracker/full_stats_tracker.dart';
import '../../components/game_score/score_board.dart';
import '../../components/shared/stats_table.dart';
import '../../domain/tournament/tournament_match.dart';
import '../../environment.dart';
import '../../providers/tournament_match_provider.dart';
import '../../utils/build_table_stats.dart';

class TournamentMatchTracker extends StatelessWidget {
  const TournamentMatchTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<TournamentMatchProvider>(context);
    final currentTournamentProvider =
        Provider.of<CurrentTournamentProvider>(context);

    print("${currentTournamentProvider.currT} current T");

    return TournamentMatchTrackerWrapper(
      gameProvider: gameProvider,
      currentTournamentProvider: currentTournamentProvider,
    );
  }
}

class TournamentMatchTrackerWrapper extends StatefulWidget {
  final TournamentMatchProvider gameProvider;
  final CurrentTournamentProvider currentTournamentProvider;

  const TournamentMatchTrackerWrapper({
    super.key,
    required this.gameProvider,
    required this.currentTournamentProvider,
  });

  @override
  State<TournamentMatchTrackerWrapper> createState() =>
      _TournamentMatchTrackerWrapperState();
}

class _TournamentMatchTrackerWrapperState
    extends State<TournamentMatchTrackerWrapper> {
  late IO.Socket socket;

  _connectToRoom() {
    Map messageMap = {'message': widget.gameProvider.match?.matchId};
    socket.emit("client:join_room", messageMap);
  }

  _updateMatch() {
    TournamentMatch match = widget.gameProvider.match!;
    final data = {
      'matchId': match.matchId,
      'matchStats': match.tracker?.toJson(),
      'sets': match.sets.map((e) => e.toJson()).toList(),
      'currentGame': match.currentGame.toJson(),
      'servingPlayer': match.servingPlayer,
      //'rivalBreakPts': match.tracker?.rivalBreakPoints(match.currentGame),
    };

    socket.emit("client:update_match", data);
  }

  _finishMatch() {
    socket.emit("client:match_finish", {
      'message': widget.gameProvider.match?.matchId,
    });
  }

  _finishMatchData() {
    TournamentMatch match = widget.gameProvider.match!;
    return {
      'tracker': match.tracker?.toJson(),
      'sets': match.sets.map((e) => e.toJson()).toList(),
      'superTieBreak': match.superTiebreak ?? false,
      "matchWon": match.matchWon,
    };
  }

  _initSocket() {
    socket = IO.io(Environment.webSockets, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });

    socket.connect();

    socket.on("server:join_room", (data) {
      _updateMatch();
    });

    socket.onConnect((_) {
      _connectToRoom();
    });
  }

  _handleCancelMatch(
    bool matchWon,
    TournamentMatch match,
    BuildContext context,
  ) async {
    EasyLoading.show(dismissOnTap: true);

    match.matchWon = matchWon;
    match.matchFinish = true;

    final result = await updateMatch(match, MatchStatuses.Canceled);

    if (result.isFailure) {
      EasyLoading.dismiss();
      // manage failure case
      showMessage(context, result.error!, ToastType.error);
      return;
    }

    //TODO: remove pending match
    EasyLoading.dismiss();
    showMessage(context, result.getValue(), ToastType.success);

    navigationKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => TournamentPage(
          tournament: widget.currentTournamentProvider.currT!,
        ),
      ),
    );
  }

  _handlePauseMatch(TournamentMatch match, BuildContext context) async {
    EasyLoading.show();
    final result = await updateMatch(match, MatchStatuses.Paused);

    if (result.isFailure) {
      // manage failure case
      EasyLoading.dismiss();
      showMessage(context, result.error!, ToastType.error);
      return;
    }

    EasyLoading.dismiss();
    showMessage(context, result.getValue(), ToastType.success);

    navigationKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => TournamentPage(
          tournament: widget.currentTournamentProvider.currT!,
        ),
      ),
    );
  }

  @override
  void initState() {
    _initSocket();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TournamentMatch match = widget.gameProvider.match!;

    cancelMatchModal() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            bool matchWon = true;
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
                              value: true,
                              child: Text(
                                "Team 1 gana por w/o (arriba)",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text(
                                "Team 2 gana port w/o (abajo)",
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
                      _handleCancelMatch(matchWon, match, context);
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

    pauseMatchModal() {
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
                    _handlePauseMatch(match, context);
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

    return DefaultTabController(
      length: 2,
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            pauseMatchModal();
            return;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            centerTitle: true,
            title: Text("Partido"),
            leading: CloseButton(
              onPressed: () => cancelMatchModal(),
            ),
            bottom: const TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.grey,
              tabs: [
                Tab(text: "Botones"),
                Tab(text: "Estadísticas"),
              ],
            ),
            actions: [
              ButtonBar(
                children: [
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () => pauseMatchModal(),
                  ),
                ],
              )
            ],
          ),
          body: TabBarView(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: CustomScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: ScoreBoard(
                        mode: match.mode,
                        singleServeFlow: match.singleServeFlow,
                        doubleServeFlow: match.doubleServeFlow,
                        servingTeam: match.servingTeam,
                        matchFinish: match.matchFinish,
                        points1: widget.gameProvider.getMyPoints,
                        points2: widget.gameProvider.getRivalPoints,
                        player1Name: shortNameFormat(
                            match.participant1.firstName,
                            match.participant1.lastName),
                        player2Name: shortNameFormat(
                            match.participant2.firstName,
                            match.participant2.lastName),
                        player3Name: GameMode.double == match.mode
                            ? shortNameFormat(
                                match.participant3!.firstName,
                                match.participant3!.lastName,
                              )
                            : "",
                        player4Name: GameMode.double == match.mode
                            ? shortNameFormat(
                                match.participant4!.firstName,
                                match.participant4!.lastName,
                              )
                            : "",
                        sets: match.sets,
                        currentSetIdx: match.currentSetIdx,
                      ),
                    ),
                    SliverFillRemaining(
                      child: FullStatsTracker(),
                    ),
                  ],
                ),
              ),
              ListView(
                children: [
                  Center(
                    child: StatsTable(
                      sections:
                          //TODO: add real names
                          buildTournamentTableStats(match.tracker!, "", ""),
                    ),
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
