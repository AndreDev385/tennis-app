import 'package:flutter/material.dart';

import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/domain/statistics.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class ResumePointsTable extends StatelessWidget {
  const ResumePointsTable({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    StatisticsTracker tracker = match.tracker!;

    int totalServDone =
        tracker.firstServIn + tracker.secondServIn + tracker.dobleFault;

    int rivalTotalServDone = tracker.rivalFirstServIn +
        tracker.rivalSecondServIn +
        tracker.rivalDobleFault;
    // pts serv
    int totalPtsWonServ = tracker.pointsWon1Serv + tracker.pointsWon2Serv;
    // rival pts serv
    int rivalTotalPtsWonServ = tracker.rivalPointsWinnedFirstServ +
        tracker.rivalPointsWinnedSecondServ;
    // pts ret
    int totalPtsWonRet =
        tracker.pointsWon1Ret + tracker.pointsWon2Ret + tracker.rivalDobleFault;
    // rival pts ret
    int rivalTotalPtsWonRet = tracker.rivalPointsWinnedFirstReturn +
        tracker.rivalPointsWinnedSecondReturn +
        tracker.dobleFault as int;
    // total pts
    int totalPtsWon = totalPtsWonServ + totalPtsWonRet;
    // rival total pts
    int rivalTotalPtsWin = rivalTotalPtsWonServ + rivalTotalPtsWonRet;

    return Column(
      children: [
        const Text(
          "Puntos",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Table(
          border: const TableBorder(
            horizontalInside: BorderSide(width: .5, color: Colors.grey),
            bottom: BorderSide(width: .5, color: Colors.grey),
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FixedColumnWidth(88),
            2: FixedColumnWidth(88),
          },
          children: <TableRow>[
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: const Text("Puntos ganados con el servicio"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Text(
                      "$totalPtsWonServ/$totalServDone(${calculatePercent(totalPtsWonServ, totalServDone)}%)",
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Text(
                      "$rivalTotalPtsWonServ/$rivalTotalServDone(${calculatePercent(rivalTotalPtsWonServ, rivalTotalServDone)}%)",
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: const Text("Puntos ganados con la devolución"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Text(
                      "$totalPtsWonRet/$rivalTotalServDone(${calculatePercent(totalPtsWonRet, rivalTotalServDone)}%)",
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Text(
                      "$rivalTotalPtsWonRet/$totalServDone(${calculatePercent(rivalTotalPtsWonRet, totalServDone)}%)",
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: const Text("Puntos ganados en total"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Text(
                      "$totalPtsWon/${totalServDone + rivalTotalServDone}(${calculatePercent(totalPtsWon, totalServDone + rivalTotalServDone)}%)",
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Text(
                      "$rivalTotalPtsWin/${totalServDone + rivalTotalServDone}(${calculatePercent(rivalTotalPtsWin, totalServDone + rivalTotalServDone)}%)",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}
