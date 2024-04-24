import 'package:flutter/material.dart';

import '../../../../domain/league/match.dart';
import '../../../../domain/league/statistics.dart';
import '../../../../utils/calculate_percent.dart';
import '../../title_row.dart';

class ReturnTable extends StatelessWidget {
  final Match match;

  const ReturnTable({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    StatisticsTracker tracker = match.tracker!;

    return Column(
      children: [
        const TitleRow(title: "Devolución"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Table(
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
                      child: const Text(
                        "1era devolución in",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.firstRetIn}/${tracker.rivalFirstServIn} (${calculatePercent(tracker.firstRetIn, tracker.rivalFirstServIn)}%)",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                      child: const Text(
                        "1era devolución ganadora",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.firstRetWon}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          "",
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
                      child: const Text(
                        "Winner con 1era devolución ganadora",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.firstRetWinner}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          "",
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
                      child: const Text(
                        "Puntos ganados con la 1era devolución",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.pointsWon1Ret}/${tracker.rivalFirstServIn} (${calculatePercent(tracker.pointsWon1Ret, tracker.rivalFirstServIn)}%)",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                      child: const Text(
                        "2do devolución in",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.secondRetIn}/${tracker.rivalSecondServIn} (${calculatePercent(tracker.secondRetIn, tracker.rivalSecondServIn)}%)",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                      child: const Text(
                        "2da devolución ganadora",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.secondRetWon}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          "",
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
                      child: const Text(
                        "Winner con 2da devolución ganadora",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.secondRetWinner}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          "",
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
                      child: const Text(
                        "Puntos ganados con la 2da devolución",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.pointsWon2Ret}/${tracker.rivalSecondServIn} (${calculatePercent(tracker.pointsWon2Ret, tracker.rivalSecondServIn)}%)",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                      child: const Text(
                        "Break points",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.breakPtsWinned}/${tracker.winBreakPtsChances}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                      child: const Text(
                        "Games ganados devolviendo",
                        style: TextStyle(
                          fontSize: 13,
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
                          "${tracker.gamesWonReturning}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
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
                          "${tracker.gamesLostServing}",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24))
      ],
    );
  }
}
