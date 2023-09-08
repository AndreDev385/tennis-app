import 'package:flutter/material.dart';
import 'package:tennis_app/domain/statistics.dart';

import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class ReturnTable extends StatelessWidget {
  const ReturnTable({super.key, required this.match});

  final Match match;

  @override
  Widget build(BuildContext context) {
    StatisticsTracker tracker = match.tracker!;

    return Column(
      children: [
        const Text(
          "Devolución",
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
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: const Text("1era devolución in"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.firstRetIn}/${tracker.rivalFirstServIn} (${calculatePercent(tracker.firstRetIn, tracker.rivalFirstServIn)}%)",
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalFirstReturnIn}/${tracker.firstServIn} (${calculatePercent(tracker.rivalFirstReturnIn, tracker.firstServIn)}%)",
                      ),
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
                    child: const Text("2do devolución in"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.secondRetIn}/${tracker.rivalSecondServIn} (${calculatePercent(tracker.secondRetIn, tracker.rivalSecondServIn)}%)",
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalSecondReturnIn}/${tracker.secondServIn} (${calculatePercent(tracker.rivalSecondReturnIn, tracker.secondServIn)}%)",
                      ),
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
                    child: const Text("Puntos ganados con la 1era devolución"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.pointsWon1Ret}/${tracker.rivalFirstServIn} (${calculatePercent(tracker.pointsWon1Ret, tracker.rivalFirstServIn)}%)",
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalPointsWinnedFirstReturn}/${tracker.firstServIn} (${calculatePercent(tracker.rivalPointsWinnedFirstReturn, tracker.firstServIn)}%)",
                      ),
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
                    child: const Text("Puntos ganados con la 2da devolución"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.pointsWon2Ret}/${tracker.rivalSecondServIn} (${calculatePercent(tracker.pointsWon2Ret, tracker.rivalSecondServIn)}%)",
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalPointsWinnedSecondReturn}/${tracker.secondServIn} (${calculatePercent(tracker.rivalPointsWinnedSecondReturn, tracker.secondServIn)}%)",
                      ),
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
                    child: const Text("Break points"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.breakPtsWinned}/${tracker.winBreakPtsChances}",
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        tracker.rivalBreakPoints(match.currentGame),
                      ),
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
                    child: const Text("Games ganados devolviendo"),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.gamesWonReturning}"),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.gamesLostServing}"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24))
      ],
    );
  }
}
