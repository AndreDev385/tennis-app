import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/full_stats_tracker/full_stats_tracker.dart';
import 'package:tennis_app/components/game_score/score_board.dart';
import 'package:tennis_app/components/shared/stats_table.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/utils/build_table_stats.dart';

import '../../domain/tournament/tournament_match.dart';

class TournamentMatchTracker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TournamentMatchTracker();
}

class _TournamentMatchTracker extends State<TournamentMatchTracker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<TournamentMatchProvider>(context);

    TournamentMatch match = gameProvider.match!;

    return DefaultTabController(
      length: 2,
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            centerTitle: true,
            title: Text("Partido"),
            leading: CloseButton(
              onPressed: () {}, //=> cancelMatchModal(context),
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
                  TextButton(
                    child: const Icon(Icons.pause),
                    onPressed: () {}, //=> pauseMatchModal(context),
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
                  slivers: [
                    SliverToBoxAdapter(
                      child: ScoreBoard(
                        mode: match.mode,
                        singleServeFlow: match.singleServeFlow,
                        doubleServeFlow: match.doubleServeFlow,
                        servingTeam: match.servingTeam,
                        matchFinish: match.matchFinish,
                        points1: gameProvider.getMyPoints,
                        points2: gameProvider.getRivalPoints,
                        player1Name: "1",
                        player2Name: "2",
                        player3Name: "3",
                        player4Name: "4",
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
                      sections: buildTournamentTableStats(match.tracker),
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
