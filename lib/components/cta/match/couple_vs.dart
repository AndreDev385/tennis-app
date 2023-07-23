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

    print(widget.match.tracker?.me.toJson());
    print(widget.match.tracker?.partner?.toJson());

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: MyTheme.purple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: TabBar(
            indicatorWeight: 4,
            indicatorColor: Colors.yellow,
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
          height: 470,
          width: double.infinity,
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
