import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/stats_by_set.dart';
import 'package:tennis_app/components/shared/stats_table.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/build_table_stats.dart';
import 'package:tennis_app/utils/calculate_stats_by_set.dart';

import '../../../domain/shared/utils.dart';
import '../../../domain/tournament/tournament_match.dart';
import '../../../dtos/match_dtos.dart';
import '../../../utils/format_player_name.dart';
import '../../cta/match/couple_vs.dart';
import '../../game_score/score_board.dart';

class TournamentMatchResult extends StatefulWidget {
  final TournamentMatch match;

  const TournamentMatchResult({
    super.key,
    required this.match,
  });

  @override
  State<TournamentMatchResult> createState() => _TournamentMatchResultState();
}

class _TournamentMatchResultState extends State<TournamentMatchResult>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<bool> _setSelected = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.match.mode == GameMode.single ? 1 : 3,
    );
    setState(() {
      _setSelected = generateSetOptions(widget.match.sets.length);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleSelectSet(int index) {
    setState(() {
      bool NO_STATS = index < _setSelected.length - 1 &&
          widget.match.sets[index].stats == null;

      if (NO_STATS) {
        return;
      }
      for (int i = 0; i < _setSelected.length; i++) {
        _setSelected[i] = i == index;
      }
    });
  }

  tabs() {
    if (GameMode.single == widget.match.mode) {
      return [
        Tab(text: "Jugadores"),
      ];
    }
    return [
      Tab(text: "Pareja vs"),
      Tab(text: "J1 vs J2"),
      Tab(text: "J3 vs J4"),
    ];
  }

  tables() {
    if (GameMode.single == widget.match.mode) {
      return [
        ListView(
          children: [
            Center(
              child: StatsTable(
                sections: buildTournamentTableStats(
                  tournamentMatchStatsBySet(
                    sets: widget.match.sets,
                    options: _setSelected,
                    total: widget.match.tracker!,
                  ),
                  shortNameFormat(
                    widget.match.participant1.firstName,
                    widget.match.participant1.lastName,
                  ),
                  shortNameFormat(
                    widget.match.participant2.firstName,
                    widget.match.participant2.lastName,
                  ),
                ),
              ),
            ),
          ],
        ),
      ];
    }
    return [
      ListView(
        children: [
          Center(
            child: StatsTable(
              sections: buildTournamentTableStats(
                tournamentMatchStatsBySet(
                  sets: widget.match.sets,
                  options: _setSelected,
                  total: widget.match.tracker!,
                ),
                "${shortNameFormat(
                  widget.match.participant1.firstName,
                  widget.match.participant1.lastName,
                )} / ${shortNameFormat(
                  widget.match.participant3!.firstName,
                  widget.match.participant3!.lastName,
                )}",
                "${shortNameFormat(
                  widget.match.participant2.firstName,
                  widget.match.participant2.lastName,
                )} / ${shortNameFormat(
                  widget.match.participant4!.firstName,
                  widget.match.participant4!.lastName,
                )}",
              ),
            ),
          ),
        ],
      ),
      ListView(
        children: [
          Center(
            child: StatsTable(
              sections: buildTournamentPartnersTableStats(
                tournamentMatchStatsBySet(
                  sets: widget.match.sets,
                  options: _setSelected,
                  total: widget.match.tracker!,
                ).player1,
                tournamentMatchStatsBySet(
                  sets: widget.match.sets,
                  options: _setSelected,
                  total: widget.match.tracker!,
                ).player3!,
                shortNameFormat(
                  widget.match.participant1.firstName,
                  widget.match.participant1.lastName,
                ),
                shortNameFormat(
                  widget.match.participant3!.firstName,
                  widget.match.participant3!.lastName,
                ),
              ),
            ),
          ),
        ],
      ),
      ListView(
        children: [
          Center(
            child: StatsTable(
              sections: buildTournamentPartnersTableStats(
                tournamentMatchStatsBySet(
                  sets: widget.match.sets,
                  options: _setSelected,
                  total: widget.match.tracker!,
                ).player2,
                tournamentMatchStatsBySet(
                  sets: widget.match.sets,
                  options: _setSelected,
                  total: widget.match.tracker!,
                ).player4!,
                shortNameFormat(
                  widget.match.participant2.firstName,
                  widget.match.participant2.lastName,
                ),
                shortNameFormat(
                  widget.match.participant4!.firstName,
                  widget.match.participant4!.lastName,
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool MATCH_COULD_HAVE_STATS =
        widget.match.status == MatchStatuses.Finished.index ||
            widget.match.status == MatchStatuses.Canceled.index ||
            widget.match.status == MatchStatuses.Paused.index;

    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ScoreBoard(
              mode: widget.match.mode,
              singleServeFlow: widget.match.singleServeFlow,
              doubleServeFlow: widget.match.doubleServeFlow,
              servingTeam: widget.match.servingTeam,
              matchFinish: widget.match.matchFinish,
              points1: null,
              points2: null,
              player1Name: shortNameFormat(widget.match.participant1.firstName,
                  widget.match.participant1.lastName),
              player2Name: shortNameFormat(widget.match.participant2.firstName,
                  widget.match.participant2.lastName),
              player3Name: GameMode.double == widget.match.mode
                  ? shortNameFormat(
                      widget.match.participant3!.firstName,
                      widget.match.participant3!.lastName,
                    )
                  : "",
              player4Name: GameMode.double == widget.match.mode
                  ? shortNameFormat(
                      widget.match.participant4!.firstName,
                      widget.match.participant4!.lastName,
                    )
                  : "",
              sets: widget.match.sets,
              currentSetIdx: widget.match.currentSetIdx,
              darkBackground: true,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: TabBar(
            splashBorderRadius: BorderRadius.only(
              topLeft: Radius.circular(MyTheme.regularBorderRadius),
              topRight: Radius.circular(MyTheme.regularBorderRadius),
            ),
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(MyTheme.regularBorderRadius),
                topRight: Radius.circular(MyTheme.regularBorderRadius),
              ),
            ),
            indicatorWeight: 4,
            unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            tabs: tabs(),
          ),
        ),
        if (MATCH_COULD_HAVE_STATS && widget.match.sets.length > 1)
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              height: 60,
              child: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    StatsBySet(
                      setsLength: widget.match.sets.length,
                      setOptions: _setSelected,
                      handleSelectSet: handleSelectSet,
                    ),
                  ],
                ),
              ),
            ),
          ),
        SliverFillRemaining(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: TabBarView(
              controller: _tabController,
              children: tables(),
            ),
          ),
        )
      ],
    );
  }
}
