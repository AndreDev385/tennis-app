import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/stats_by_set.dart';
import 'package:tennis_app/components/shared/stats_table.dart';
import 'package:tennis_app/components/shared/tables_name_row.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/build_graphs.dart';
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
  final bool showMore;

  const TournamentMatchResult({
    super.key,
    required this.match,
    required this.showMore,
  });

  @override
  State<TournamentMatchResult> createState() => _TournamentMatchResultState();
}

class _TournamentMatchResultState extends State<TournamentMatchResult>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<bool> _setSelected = [];
  String firstSideName = "";
  String secondSideName = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.match.mode == GameMode.single ? 1 : 3,
    );
    setState(() {
      _setSelected = generateSetOptions(widget.match.sets.length);
      firstSideName = getNameFirstSide(_tabController.index);
      secondSideName = getNameSecondSide(_tabController.index);
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

  graphs() {
    if (GameMode.single == widget.match.mode) {
      return [
        ListView(
          children: buildTournamentGraphs(
            tournamentMatchStatsBySet(
              sets: widget.match.sets,
              options: _setSelected,
              total: widget.match.tracker!,
            ),
          ),
        ),
      ];
    }
    return [
      ListView(
        children: buildTournamentGraphs(
          tournamentMatchStatsBySet(
            sets: widget.match.sets,
            options: _setSelected,
            total: widget.match.tracker!,
          ),
        ),
      ),
      ListView(
        children: buildTournamentPartnersGraphs(
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
        ),
      ),
      ListView(
        children: buildTournamentPartnersGraphs(
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
        ),
      ),
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
              ),
            ),
          ),
        ],
      ),
    ];
  }

  getNameFirstSide(int idx) {
    setState(() {});
    if (idx == 1) {
      return shortNameFormat(widget.match.participant1.firstName,
          widget.match.participant1.lastName);
    }

    if (_tabController.index == 2) {
      return shortNameFormat(widget.match.participant2.firstName,
          widget.match.participant2.lastName);
    }
    return widget.match.mode == GameMode.double
        ? "${shortNameFormat(
            widget.match.participant1.firstName,
            widget.match.participant1.lastName,
          )} / ${shortNameFormat(
            widget.match.participant3!.firstName,
            widget.match.participant3!.lastName,
          )}"
        : shortNameFormat(
            widget.match.participant1.firstName,
            widget.match.participant1.lastName,
          );
  }

  getNameSecondSide(int idx) {
    setState(() {});
    if (_tabController.index == 1) {
      return shortNameFormat(widget.match.participant3!.firstName,
          widget.match.participant3!.lastName);
    }

    if (_tabController.index == 2) {
      return shortNameFormat(widget.match.participant4!.firstName,
          widget.match.participant4!.lastName);
    }
    return widget.match.mode == GameMode.double
        ? "${shortNameFormat(
            widget.match.participant2.firstName,
            widget.match.participant2.lastName,
          )} / ${shortNameFormat(
            widget.match.participant4!.firstName,
            widget.match.participant4!.lastName,
          )}"
        : shortNameFormat(
            widget.match.participant2.firstName,
            widget.match.participant2.lastName,
          );
  }

  @override
  Widget build(BuildContext context) {
    bool MATCH_COULD_HAVE_STATS =
        widget.match.status == MatchStatuses.Finished.index ||
            widget.match.status == MatchStatuses.Canceled.index ||
            widget.match.status == MatchStatuses.Paused.index;

    String? getMyPoints() {
      if (widget.match.status != MatchStatuses.Live.index &&
          widget.match.status != MatchStatuses.Paused.index) {
        return null;
      }
      if (!widget.match.currentGame.superTiebreak &&
          !widget.match.currentGame.tiebreak) {
        return normalPoints[widget.match.currentGame.myPoints];
      }
      return "${widget.match.currentGame.myPoints}";
    }

    String? getRivalPoints() {
      if (widget.match.status != MatchStatuses.Live.index &&
          widget.match.status != MatchStatuses.Paused.index) {
        return null;
      }
      if (!widget.match.currentGame.superTiebreak &&
          !widget.match.currentGame.tiebreak) {
        return normalPoints[widget.match.currentGame.rivalPoints];
      }

      return "${widget.match.currentGame.rivalPoints}";
    }

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
              points1: getMyPoints(),
              points2: getRivalPoints(),
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
              darkBackground: false, //true,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: TabBar(
            splashBorderRadius: BorderRadius.only(
              topLeft: Radius.circular(MyTheme.regularBorderRadius),
              topRight: Radius.circular(MyTheme.regularBorderRadius),
            ),
            indicatorWeight: 4,
            unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.tab,
            //unselectedLabelColor: Colors.grey,
            controller: _tabController,
            tabs: tabs(),
            onTap: (int idx) {
              setState(() {
                firstSideName = getNameFirstSide(idx);
                secondSideName = getNameSecondSide(idx);
              });
            },
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
        // names
        SliverToBoxAdapter(
          child: TablesNameRow(
            namesFirstSide: firstSideName,
            namesSecondSide: secondSideName,
          ),
        ),
        SliverFillRemaining(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: TabBarView(
              controller: _tabController,
              children: widget.showMore ? tables() : graphs(),
            ),
          ),
        )
      ],
    );
  }
}
