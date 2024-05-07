import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/stats_table.dart';
import 'package:tennis_app/utils/build_table_stats.dart';

import '../../../domain/shared/utils.dart';
import '../../../domain/tournament/tournament_match.dart';
import '../../../utils/format_player_name.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.match.mode == GameMode.single ? 1 : 3,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  widget.match.tracker!,
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
                widget.match.tracker!,
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
                widget.match.tracker!.player1,
                widget.match.tracker!.player3!,
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
                widget.match.tracker!.player2,
                widget.match.tracker!.player4!,
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
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.grey,
              tabs: tabs(),
            ),
          ),
        ),
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            children: tables(),
          ),
        )
      ],
    );
  }
}
