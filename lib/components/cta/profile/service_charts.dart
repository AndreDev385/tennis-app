import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/profile/number_stat.dart';
import 'package:tennis_app/components/shared/vertical_barchart.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class ServiceCharts extends StatelessWidget {
  const ServiceCharts({
    super.key,
    required this.stats,
  });

  final PlayerTrackerDto stats;

  @override
  Widget build(BuildContext context) {
    int totalServDone =
        stats.firstServIn + stats.secondServIn + stats.dobleFaults;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4, left: 16, right: 16),
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
            ),
            elevation: 5,
            child: Container(
              height: 220,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalBarChart(
                          title: "1er Serv. In",
                          percent: calculatePercent(
                            stats.firstServIn,
                            totalServDone
                          ),
                          fraction:
                            "${stats.firstServIn}/$totalServDone",
                          type: 1,
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.secondServIn,
                            stats.secondServIn + stats.dobleFaults,
                          ),
                          title: "2do Serv. In",
                          fraction:
                              "${stats.secondServIn}/${stats.secondServIn + stats.dobleFaults}",
                          type: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4, left: 16, right: 16),
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
            ),
            elevation: 5,
            child: Container(
              height: 260,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Text(
                    "Puntos ganados",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.pointsWinnedFirstServ,
                            stats.firstServIn,
                          ),
                          title: "1er Servicio",
                          fraction:
                              "${stats.pointsWinnedFirstServ}/${stats.firstServIn}",
                          type: 0,
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.pointsWinnedSecondServ,
                            stats.secondServIn,
                          ),
                          title: "2do Servicio",
                          fraction:
                              "${stats.pointsWinnedSecondServ}/${stats.secondServIn}",
                          type: 1,
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.pointsWinnedFirstServ +
                                stats.pointsWinnedSecondServ,
                            totalServDone,
                          ),
                          title: "Total",
                          fraction:
                              "${stats.pointsWinnedFirstServ + stats.pointsWinnedSecondServ}/$totalServDone",
                          type: 2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4, left: 16, right: 16),
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
            ),
            elevation: 5,
            child: Container(
              height: 175,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: NumberStat(
                            title: "Aces",
                            value: "${stats.aces}",
                          ),
                        ),
                        Expanded(
                          child: NumberStat(
                            title: "Doble falta",
                            value: "${stats.dobleFaults}",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: NumberStat(
                            title: "Break points salvados",
                            value:
                                "${stats.breakPtsSaved}/${stats.saveBreakPtsChances}",
                          ),
                        ),
                        Expanded(
                          child: NumberStat(
                            title: "Games ganados",
                            value:
                                "${stats.gamesWonServing}/${stats.gamesWonServing + stats.gamesLostServing}",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
