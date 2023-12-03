import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/bar_chart.dart';
import 'package:tennis_app/components/cta/match/number_square.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class CoupleVsCharts extends StatelessWidget {
  const CoupleVsCharts({
    super.key,
    required this.tracker,
    required this.names,
    required this.rivalNames,
    this.rivalBreakPts,
  });

  final String names;
  final String rivalNames;
  final TrackerDto tracker;
  final String? rivalBreakPts;

  @override
  Widget build(BuildContext context) {
    int totalServDone =
        tracker.firstServIn + tracker.secondServIn + tracker.dobleFault;

    int rivalTotalServDone = tracker.rivalFirstServIn +
        tracker.rivalSecondServIn +
        tracker.rivalDobleFault;

    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            children: <TableRow>[
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        names,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        rivalNames,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
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
              type: 0,
            ),
            BarChart(
              title: "Puntos ganados con el 1er Servicio",
              percent: calculatePercent(
                tracker.pointsWon1Serv,
                tracker.firstServIn,
              ),
              rivalPercent: calculatePercent(
                tracker.rivalPointsWinnedFirstServ,
                tracker.rivalFirstServIn,
              ),
              division: "${tracker.pointsWon1Serv}/${tracker.firstServIn}",
              rivalDivision:
                  "${tracker.rivalPointsWinnedFirstServ}/${tracker.rivalFirstServIn}",
              showPercent: true,
              type: 1,
            ),
            BarChart(
              title: "Puntos ganados con el 2do servicio",
              percent: calculatePercent(
                tracker.pointsWon2Serv,
                tracker.secondServIn,
              ),
              rivalPercent: calculatePercent(
                tracker.rivalPointsWinnedSecondServ,
                tracker.rivalSecondServIn,
              ),
              division: "${tracker.pointsWon2Serv}/${tracker.secondServIn}",
              rivalDivision:
                  "${tracker.rivalPointsWinnedSecondServ}/${tracker.rivalSecondServIn}",
              showPercent: true,
              type: 2,
            ),
            NumberSquare(
              title: "Break points",
              value: "${tracker.breakPtsWinned}/${tracker.winBreakPtsChances}",
              rivalValue: rivalBreakPts ?? "0/0",
            ),
            NumberSquare(
              title: "Aces",
              value: "${tracker.aces}",
              rivalValue: "${tracker.rivalAces}",
            ),
            NumberSquare(
              title: "Doble falta",
              value: "${tracker.dobleFault}",
              rivalValue: "${tracker.rivalDobleFault}",
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 72))
      ],
    );
  }
}
