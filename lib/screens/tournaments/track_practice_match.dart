import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/full_stats_tracker/full_stats_tracker.dart';
import 'package:tennis_app/components/game_score/score_board.dart';
import 'package:tennis_app/components/shared/stats_table.dart';
import 'package:tennis_app/components/shared/tables_name_row.dart';
import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/screens/home.dart';
import 'package:tennis_app/utils/build_table_stats.dart';
import 'package:tennis_app/utils/format_player_name.dart';

class TrackPracticeMatch extends StatefulWidget {
  const TrackPracticeMatch({super.key});

  static const route = "track-practice-match";

  @override
  State<TrackPracticeMatch> createState() => _TrackPracticeMatchState();
}

class _TrackPracticeMatchState extends State<TrackPracticeMatch> {
  List<bool> _selectedTable = [true, false, false];

  void changeTable(int index) {
    setState(() {
      for (int i = 0; i < _selectedTable.length; i++) {
        _selectedTable[i] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TournamentMatchProvider>(context);

    TournamentMatch match = provider.match!;

    modalBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Estas seguro de salir del partido actual?"),
              content: const Text("Todo el progreso actual se perderá"),
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
                    provider.finishMatch();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(MyHomePage.route);
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
            match.participant1.firstName,
            match.participant1.lastName,
          )} / ${shortNameFormat(
            match.participant3!.firstName,
            match.participant3!.lastName,
          )}",
          namesSecondSide: "${shortNameFormat(
            match.participant2.firstName,
            match.participant2.lastName,
          )} / ${shortNameFormat(
            match.participant4!.firstName,
            match.participant4!.lastName,
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

    return DefaultTabController(
      length: 2,
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool value) {
          modalBuilder(context);
          return;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            centerTitle: true,
            title: Text("Partido"),
            leading: BackButton(),
            bottom: const TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.grey,
              tabs: [
                Tab(text: "Botones"),
                Tab(text: "Estadísticas"),
              ],
            ),
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
                        points1: provider.getMyPoints,
                        points2: provider.getRivalPoints,
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
                        finishTransmition: null,
                        updateTransmition: () {},
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
}
