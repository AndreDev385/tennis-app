import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/couple_vs.dart';
import 'package:tennis_app/components/cta/match/couple_vs_charts.dart';
import 'package:tennis_app/components/cta/match/match_header.dart';
import 'package:tennis_app/components/cta/match/single_vs_table.dart';
import 'package:tennis_app/components/cta/match/stats_by_set.dart';
import 'package:tennis_app/dtos/game_dto.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/calculate_stats_by_set.dart';
import 'package:tennis_app/utils/format_player_name.dart';

class SingleVs extends StatefulWidget {
  const SingleVs({
    super.key,
    required this.match,
    required this.showMore,
    required this.rivalBreakPts,
    this.servingPlayer,
    this.currentGame,
  });

  final bool showMore;
  final String? rivalBreakPts;
  final MatchDto match;
  final int? servingPlayer;
  final GameDto? currentGame;

  @override
  State<SingleVs> createState() => _SingleVsState();
}

class _SingleVsState extends State<SingleVs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<bool> _setSelected = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
    setState(() {
      _setSelected = generateSetOptions(widget.match.setsQuantity);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleSelectSet(int index) {
    setState(() {
      if (index < _setSelected.length - 1 &&
          widget.match.sets.list[index].stats == null) {
        return;
      }
      for (int i = 0; i < _setSelected.length; i++) {
        _setSelected[i] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: MatchHeader(
            matchState: widget.match,
            currentGame: widget.currentGame,
            servingPlayer: widget.servingPlayer,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(MyTheme.regularBorderRadius),
                topRight: Radius.circular(MyTheme.regularBorderRadius),
              ),
            ),
            child: TabBar(
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              tabs: const [
                Tab(text: "Jugador vs Jugador"),
              ],
            ),
          ),
        ),
        if (widget.match.status == MatchStatuses.Finished.index)
          SliverToBoxAdapter(
            child: StatsBySet(
              setsLength: widget.match.sets.list.length,
              setOptions: _setSelected,
              handleSelectSet: handleSelectSet,
            ),
          ),
        SliverFillRemaining(
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                !widget.showMore
                    ? CoupleVsCharts(
                        tracker: calculateStatsBySet(
                          sets: widget.match.sets,
                          total: widget.match.tracker!,
                          options: _setSelected,
                        ),
                        rivalBreakPts: widget.rivalBreakPts,
                        names: "${formatPlayerName(widget.match.player1.name)}",
                        rivalNames: formatPlayerName(widget.match.player2))
                    : SingleVsTable(
                        mode: widget.match.mode,
                        name: widget.match.player1.name,
                        rivalName: widget.match.player2,
                        tracker: calculateStatsBySet(
                          sets: widget.match.sets,
                          total: widget.match.tracker!,
                          options: _setSelected,
                        ),
                        rivalBreakPts: widget.rivalBreakPts,
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
