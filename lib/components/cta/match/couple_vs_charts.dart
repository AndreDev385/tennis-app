import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/bar_chart.dart';
import 'package:tennis_app/components/cta/match/number_square.dart';
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
                        "${match.player1.firstName} ${match.player3 != null ? "/" : ""} ${match.player3?.firstName ?? ""}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        "${match.player2} ${match.player3 != null ? "/" : ""} ${match.player4 ?? ""}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
