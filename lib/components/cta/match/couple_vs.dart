import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/couple_vs_charts.dart';
import 'package:tennis_app/components/cta/match/couple_vs_table.dart';
import 'package:tennis_app/components/cta/match/match_header.dart';

import 'package:tennis_app/components/cta/match/partner_vs_charts.dart';
import 'package:tennis_app/components/cta/match/partner_vs_table.dart';
import 'package:tennis_app/components/cta/match/stats_by_set.dart';
import 'package:tennis_app/dtos/game_dto.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/utils/calculate_stats_by_set.dart';
import 'package:tennis_app/utils/format_player_name.dart';

List<bool> generateSetOptions(int length) {
  List<bool> options = List<bool>.filled(
    length + 1,
    false,
    growable: false,
  );
  options[options.length - 1] = true;
  return options;
}

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

  List<bool> _setSelected = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
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
        if (widget.match.status == MatchStatuses.Finished.index ||
            widget.match.status == MatchStatuses.Canceled.index)
          SliverToBoxAdapter(
            child: StatsBySet(
              sets: widget.match.sets,
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
                        names:
                            "${formatPlayerName(widget.match.player1.name)} ${widget.match.player3 != null ? "/" : ""} ${formatPlayerName(widget.match.player3!.name)}",
                        rivalNames:
                            "${formatPlayerName(widget.match.player2)} ${widget.match.player3 != null ? "/" : ""} ${formatPlayerName(widget.match.player4!)}",
                      )
                    : CoupleVsTable(
                        names:
                            "${formatPlayerName(widget.match.player1.name)} ${widget.match.player3 != null ? "/" : ""} ${formatPlayerName(widget.match.player3!.name)}",
                        rivalNames:
                            "${formatPlayerName(widget.match.player2)} ${widget.match.player3 != null ? "/" : ""} ${formatPlayerName(widget.match.player4!)}",
                        tracker: calculateStatsBySet(
                          sets: widget.match.sets,
                          total: widget.match.tracker!,
                          options: _setSelected,
                        ),
                        mode: widget.match.mode,
                        rivalBreakPts: widget.rivalBreakPts,
                      ),
                Container(
                  child: !widget.showMore
                      ? PartnerVsCharts(
                          tracker: calculateStatsBySet(
                            sets: widget.match.sets,
                            total: widget.match.tracker!,
                            options: _setSelected,
                          ),
                          name: formatPlayerName(widget.match.player1.name),
                          partnerName: formatPlayerName(
                            "${widget.match.player3?.name}",
                          ),
                        )
                      : PartnerVsTable(
                          name: formatPlayerName(widget.match.player1.name),
                          partnerName: formatPlayerName(
                            "${widget.match.player3?.name}",
                          ),
                          tracker: calculateStatsBySet(
                            sets: widget.match.sets,
                            total: widget.match.tracker!,
                            options: _setSelected,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
