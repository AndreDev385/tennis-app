import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/bar_chart.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class CoupleVsCharts extends StatelessWidget {
  const CoupleVsCharts({
    super.key,
    required this.match,
    this.rivalBreakPts,
  });

  final MatchDto match;
  final String? rivalBreakPts;

  @override
  Widget build(BuildContext context) {
    TrackerDto tracker = match.tracker!;

    int totalServDone =
        tracker.firstServIn + tracker.secondServIn + tracker.dobleFault;

    int rivalTotalServDone = tracker.rivalFirstServIn +
        tracker.rivalSecondServIn +
        tracker.rivalDobleFault;

    print("total: ${totalServDone.toDouble()}");
    print("in: ${tracker.firstServIn.toDouble()}");
    print("percent: ${calculatePercent(tracker.firstServIn, totalServDone)}");

    return Column(
      children: [
        /*Container(
          margin: const EdgeInsets.all(8),
          height: 160,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                showTitle: true,
                                value: calculatePercent(
                                  tracker.firstServIn,
                                  totalServDone,
                                ).toDouble(),
                                color: MyTheme.cian,
                                radius: 35,
                                title:
                                    "${calculatePercent(tracker.firstServIn, totalServDone)}%",
                                titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              PieChartSectionData(
                                showTitle: false,
                                value: (100 -
                                        calculatePercent(
                                            tracker.firstServIn, totalServDone))
                                    .toDouble(),
                                color: MyTheme.purple,
                                radius: 30,
                              ),
                            ],
                            centerSpaceRadius: 20,
                            borderData: FlBorderData(show: true),
                          ),
                          swapAnimationDuration: const Duration(seconds: 2),
                        ),
                      ),
                      const Text(
                        "1er Serv. In",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                showTitle: true,
                                value: calculatePercent(
                                  tracker.pointsWon1Serv,
                                  tracker.firstServIn,
                                ).toDouble(),
                                color: MyTheme.cian,
                                radius: 35,
                                title:
                                    "${calculatePercent(tracker.pointsWon1Serv, tracker.firstServIn)}%",
                                titleStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              PieChartSectionData(
                                showTitle: false,
                                value: (100 -
                                        calculatePercent(tracker.pointsWon1Serv,
                                            tracker.firstServIn))
                                    .toDouble(),
                                color: MyTheme.purple,
                                radius: 30,
                              ),
                            ],
                            centerSpaceRadius: 20,
                            borderData: FlBorderData(show: true),
                          ),
                          swapAnimationDuration: const Duration(seconds: 2),
                        ),
                      ),
                      const Text(
                        "Pts con el 1er Serv.",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),*/
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BarChart(
              title: "1er Servicio In",
              percent: calculatePercent(tracker.firstServIn, totalServDone),
              rivalPercent: calculatePercent(
                tracker.rivalFirstServIn,
                rivalTotalServDone,
              ),
              division: "${tracker.firstServIn}/$totalServDone",
              rivalDivision: "${tracker.rivalFirstServIn}/$rivalTotalServDone",
              showPercent: true,
            ),
            BarChart(
              title: "Puntos ganados con el 1er Servicio",
              percent:
                  calculatePercent(tracker.pointsWon1Serv, tracker.firstServIn),
              rivalPercent: calculatePercent(
                tracker.rivalPointsWinnedFirstServ,
                tracker.rivalFirstServIn,
              ),
              division: "${tracker.pointsWon1Serv}/${tracker.firstServIn}",
              rivalDivision:
                  "${tracker.rivalPointsWinnedFirstServ}/${tracker.rivalFirstServIn}",
              showPercent: true,
            ),
            BarChart(
              title: "Puntos ganados con el segundo servicio",
              percent: calculatePercent(
                  tracker.pointsWon2Serv, tracker.secondServIn),
              rivalPercent: calculatePercent(
                  tracker.rivalPointsWinnedSecondServ,
                  tracker.rivalSecondServIn),
              division: "${tracker.pointsWon2Serv}/${tracker.secondServIn}",
              rivalDivision:
                  "${tracker.rivalPointsWinnedSecondServ}/${tracker.rivalSecondServIn}",
              showPercent: true,
            ),
            /*BarChart(
              title: "Break points",
              division:
                  "${tracker.breakPtsWinned}/${tracker.winBreakPtsChances}",
              rivalDivision: rivalBreakPts ?? "0/0",
              showPercent: false,
            ),
            BarChart(
              title: "Aces",
              division: "${tracker.aces}",
              rivalDivision: "${tracker.rivalAces}",
                show
            ),
            BarChart(
              title: "Doble falta",
              division: "${tracker.dobleFault}",
              rivalDivision: "${tracker.rivalDobleFault}",
              barPercent: 50,
              rivalBarPercent: 23,
            ),
            BarChart(
              title: "Winners",
              division: "${tracker.winners}",
              rivalDivision: "${tracker.rivalWinners}",
              barPercent: 50,
              rivalBarPercent: 23,
            ),
            BarChart(
              title: "Errores no forzados",
              division: "${tracker.noForcedErrors}",
              rivalDivision: "${tracker.rivalNoForcedErrors}",
              barPercent: 50,
              rivalBarPercent: 23,
            ),*/
          ],
        ),
      ],
    );
  }
}
