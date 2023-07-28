import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/cople_vs_charts.dart';
import 'package:tennis_app/components/cta/match/couple_vs_table.dart';

import 'package:tennis_app/components/cta/match/partner_vs_charts.dart';
import 'package:tennis_app/components/cta/match/partner_vs_table.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/styles.dart';

class CoupleVs extends StatefulWidget {
  const CoupleVs({
    super.key,
    required this.match,
    required this.showMore,
    this.rivalBreakPts,
  });

  final String? rivalBreakPts;
  final bool showMore;
  final MatchDto match;

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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: TabBar(
            indicatorWeight: 4,
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
        SizedBox(
          width: double.maxFinite,
          height: 700,
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  !widget.showMore
                      ? CoupleVsCharts(match: widget.match)
                      : CoupleVsTable(
                          match: widget.match,
                          rivalBreakPts: widget.rivalBreakPts,
                        ),
                ],
              ),
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  !widget.showMore
                      ? PartnerVsCharts(match: widget.match)
                      : PartnerVsTable(
                          match: widget.match,
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
