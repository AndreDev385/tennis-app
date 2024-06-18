import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/shared/tables_name_row.dart';

import '../../components/full_stats_tracker/full_stats_tracker.dart';
import '../../components/game_score/score_board.dart';
import '../../components/shared/stats_table.dart';
import '../../components/shared/toast.dart';
import '../../domain/shared/utils.dart';
import '../../domain/tournament/tournament_match.dart';
import '../../dtos/match_dtos.dart';
import '../../environment.dart';
import '../../main.dart';
import '../../providers/curr_tournament_provider.dart';
import '../../providers/tournament_match_provider.dart';
import '../../services/tournaments/match/update_match.dart';
import '../../utils/build_table_stats.dart';
import '../../utils/format_player_name.dart';
import 'tournament_page.dart';

class TournamentMatchTracker extends StatelessWidget {
  const TournamentMatchTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<TournamentMatchProvider>(context);
    final currentTournamentProvider = Provider.of<CurrentTournamentProvider>(
      context,
    );

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
  List<bool> _selectedTable = [true, false, false];

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

  /*
    Create room for share match stats
  */
  _connectToRoom() {
    String id = widget.gameProvider.match!.matchId;
    Map messageMap = {'message': id};
    socket.emit("client:join_tournament_room", messageMap);
  }

  _updateMatchForTransmition() {
    TournamentMatch match = widget.gameProvider.match!;
    final data = match.toJson();

    socket.emit("client:update_tournament_match", data);
  }

  _finishMatchTransmition() {
    print("emit finish");
    socket.emit("client:tournament_match_finish", {
      'message': widget.gameProvider.match?.matchId,
    });
  }

  _initSocket() {
    socket = IO.io(Environment.webSockets, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });

    socket.connect();

    socket.on("server:join_tournament_room", (_) {
      _updateMatchForTransmition();
    });

    socket.onConnect((_) {
      _connectToRoom();
    });

    socket.onError((e) {
      print(e);
    });

    socket.onConnectError((err) {
      print("onConnectError: $err");
    });

    socket.onDisconnect((data) => {print("disconnect: $data")});
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

    widget.gameProvider.finishMatch();
    EasyLoading.dismiss();
    showMessage(context, result.getValue(), ToastType.success);

    _finishMatchTransmition();

    navigationKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => TournamentPage(
          tournamentProvider: widget.currentTournamentProvider,
          updateContest: false,
        ),
      ),
    );
  }

  _handlePauseMatch(TournamentMatch match, BuildContext context) async {
    EasyLoading.show();
    final result = await updateMatch(match, MatchStatuses.Paused);

    if (result.isFailure) {
      EasyLoading.dismiss();
      showMessage(context, result.error!, ToastType.error);
      return;
    }

    widget.gameProvider.finishMatch();
    EasyLoading.dismiss();
    showMessage(context, result.getValue(), ToastType.success);

    _finishMatchTransmition();

    navigationKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => TournamentPage(
          tournamentProvider: widget.currentTournamentProvider,
          updateContest: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late TournamentMatch match = widget.gameProvider.match!;

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
                          match.participant1.lastName,
                        ),
                        player2Name: shortNameFormat(
                          match.participant2.firstName,
                          match.participant2.lastName,
                        ),
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
                      child: FullStatsTracker(
                        finishTransmition: _finishMatchTransmition,
                        updateTransmition: _updateMatchForTransmition,
                      ),
                    ),
                  ],
                ),
              ),
              ListView(
                children: [
                  if (match.mode == GameMode.double)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: ToggleButtons(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            constraints: const BoxConstraints(
                              minHeight: 40,
                              minWidth: 100,
                              maxWidth: 200,
                            ),
                            onPressed: (index) => changeTable(index),
                            selectedColor:
                                Theme.of(context).colorScheme.primary,
                            isSelected: _selectedTable,
                            children: [
                              Text(
                                "Parejas",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "J1 vs J2",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "J3 vs J4",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  tableRowNames(match),
                  Center(
                    child: StatsTable(sections: renderTables(match)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  tableRowNames(TournamentMatch match) {
    if (_selectedTable[1]) {
      return TablesNameRow(
        namesFirstSide: shortNameFormat(
            match.participant1.firstName, match.participant1.lastName),
        namesSecondSide: shortNameFormat(
            match.participant3!.firstName, match.participant3!.lastName),
      );
    }
    if (_selectedTable[2]) {
      return TablesNameRow(
        namesFirstSide: shortNameFormat(
            match.participant2.firstName, match.participant2.lastName),
        namesSecondSide: shortNameFormat(
            match.participant4!.firstName, match.participant4!.lastName),
      );
    }
    if (match.mode == GameMode.single) {
      return TablesNameRow(
        namesFirstSide: shortNameFormat(
            match.participant1.firstName, match.participant1.lastName),
        namesSecondSide: shortNameFormat(
            match.participant2.firstName, match.participant2.lastName),
      );
    }
    return TablesNameRow(
        namesFirstSide: "${shortNameFormat(
          widget.gameProvider.match!.participant1.firstName,
          widget.gameProvider.match!.participant1.lastName,
        )} / ${shortNameFormat(
          widget.gameProvider.match!.participant3!.firstName,
          widget.gameProvider.match!.participant3!.lastName,
        )}",
        namesSecondSide: "${shortNameFormat(
          widget.gameProvider.match!.participant2.firstName,
          widget.gameProvider.match!.participant2.lastName,
        )} / ${shortNameFormat(
          widget.gameProvider.match!.participant4!.firstName,
          widget.gameProvider.match!.participant4!.lastName,
        )}");
  }

  renderTables(TournamentMatch match) {
    if (_selectedTable[1]) {
      return buildTournamentPartnersTableStats(
        match.tracker!.player1,
        match.tracker!.player3!,
      );
    }
    if (_selectedTable[2]) {
      return buildTournamentPartnersTableStats(
        match.tracker!.player2,
        match.tracker!.player4!,
      );
    }
    if (match.mode == GameMode.single) {
      return buildTournamentTableStats(
        match.tracker!,
      );
    }
    return buildTournamentTableStats(match.tracker!);
  }

  void changeTable(int index) {
    setState(() {
      for (int i = 0; i < _selectedTable.length; i++) {
        _selectedTable[i] = i == index;
      }
    });
  }
}
