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
              percent1: calculatePercent(tracker.firstServIn, totalServDone),
              percent2: calculatePercent(
                tracker.rivalFirstServIn,
                rivalTotalServDone,
              ),
              division1: "${tracker.firstServIn}/$totalServDone",
              division2: "${tracker.rivalFirstServIn}/$rivalTotalServDone",
              showPercent: true,
              type: 0,
            ),
            BarChart(
              title: "Puntos ganados con el 1er Servicio",
              percent1: calculatePercent(
                tracker.pointsWon1Serv,
                tracker.firstServIn,
              ),
              percent2: calculatePercent(
                tracker.rivalPointsWinnedFirstServ,
                tracker.rivalFirstServIn,
              ),
              division1: "${tracker.pointsWon1Serv}/${tracker.firstServIn}",
              division2:
                  "${tracker.rivalPointsWinnedFirstServ}/${tracker.rivalFirstServIn}",
              showPercent: true,
              type: 1,
            ),
            BarChart(
              title: "Puntos ganados con el 2do servicio",
              percent1: calculatePercent(
                tracker.pointsWon2Serv,
                tracker.secondServIn,
              ),
              percent2: calculatePercent(
                tracker.rivalPointsWinnedSecondServ,
                tracker.rivalSecondServIn,
              ),
              division1: "${tracker.pointsWon2Serv}/${tracker.secondServIn}",
              division2:
                  "${tracker.rivalPointsWinnedSecondServ}/${tracker.rivalSecondServIn}",
              showPercent: true,
              type: 2,
            ),
            NumberSquare(
              title: "Break points",
              value1: "${tracker.breakPtsWinned}/${tracker.winBreakPtsChances}",
              value2: rivalBreakPts ?? "0/0",
            ),
            NumberSquare(
              title: "Aces",
              value1: "${tracker.aces}",
              value2: "${tracker.rivalAces}",
            ),
            NumberSquare(
              title: "Doble falta",
              value1: "${tracker.dobleFault}",
              value2: "${tracker.rivalDobleFault}",
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 72))
      ],
    );
  }
}
