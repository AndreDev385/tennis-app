import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/couple_vs_charts.dart';
import 'package:tennis_app/components/cta/match/couple_vs_table.dart';
import 'package:tennis_app/components/cta/match/match_header.dart';

import 'package:tennis_app/components/cta/match/partner_vs_charts.dart';
import 'package:tennis_app/components/cta/match/partner_vs_table.dart';
import 'package:tennis_app/dtos/match_dtos.dart';

class CoupleVs extends StatefulWidget {
  const CoupleVs({
    super.key,
    required this.match,
    required this.showMore,
    this.rivalBreakPts,
    this.servingPlayer,
    this.currentGame,
  });

  final String? rivalBreakPts;
  final bool showMore;
  final MatchDto match;
  final int? servingPlayer;
  final GameDto? currentGame;

  @override
  State<CoupleVs> createState() => _CoupleVsState();
}

class _CoupleVsState extends State<CoupleVs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
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
                Tab(
                  text: "Pareja vs Pareja",
                ),
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
                    ? CoupleVsCharts(match: widget.match)
                    : CoupleVsTable(
                        match: widget.match,
                        rivalBreakPts: widget.rivalBreakPts,
                      ),
                Container(
                  child: !widget.showMore
                      ? PartnerVsCharts(match: widget.match)
                      : PartnerVsTable(match: widget.match),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
