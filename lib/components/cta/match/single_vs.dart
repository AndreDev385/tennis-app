import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/couple_vs_charts.dart';
import 'package:tennis_app/components/cta/match/match_header.dart';
import 'package:tennis_app/components/cta/match/single_vs_table.dart';
import 'package:tennis_app/dtos/match_dtos.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              indicatorWeight: 4,
              labelColor: Theme.of(context).colorScheme.onSurface,
              indicatorColor: Theme.of(context).colorScheme.tertiary,
              controller: _tabController,
              tabs: const [
                Tab(text: "Jugador vs Jugador"),
              ],
            ),
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
                        match: widget.match,
                        rivalBreakPts: widget.rivalBreakPts,
                      )
                    : SingleVsTable(
                        match: widget.match,
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
