import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/cople_vs_charts.dart';
import 'package:tennis_app/components/cta/match/single_vs_table.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/components/cta/match/advanced_table.dart';
import 'package:tennis_app/styles.dart';

class SingleVs extends StatefulWidget {
  const SingleVs({
    super.key,
    required this.match,
    required this.showMore,
    required this.rivalBreakPts,
  });

  final bool showMore;
  final String? rivalBreakPts;
  final MatchDto match;

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
                      : SingleVsTable(
                          match: widget.match,
                          rivalBreakPts: widget.rivalBreakPts,
                        )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
