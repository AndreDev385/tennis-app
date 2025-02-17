import 'package:flutter/material.dart';

import '../../../domain/league/match.dart';
import '../../../domain/league/statistics.dart';
import '../../../utils/calculate_percent.dart';
import '../title_row.dart';

// for basic result
class BasicTablePoints extends StatelessWidget {
  const BasicTablePoints({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    StatisticsTracker tracker = match.tracker!;

    int totalPtsServ = tracker.totalPtsServ + tracker.totalPtsServLost;
    int totalPtsRet = tracker.totalPtsRet + tracker.totalPtsRetLost;
    int totalPts = tracker.totalPts + tracker.totalPtsLost;

    return Column(
      children: [
        const TitleRow(title: "Puntos"),
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
            children: <TableRow>[
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: const Text(
                        "Puntos ganados con el servicio",
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
                      child: Text(
                        "${tracker.totalPtsServ}/$totalPtsServ (${calculatePercent(tracker.totalPtsServ, totalPtsServ).round()}%)",
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
                      child: Text(
                        "${tracker.totalPtsRetLost}/$totalPtsRet (${calculatePercent(tracker.totalPtsRetLost, totalPtsRet).round()}%)",
                        style: TextStyle(
                          fontSize: 13,
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
                        "Puntos ganados con la devolución",
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
                      child: Text(
                        "${tracker.totalPtsRet}/$totalPtsRet (${calculatePercent(tracker.totalPtsRet, totalPtsRet)}%)",
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
                      child: Text(
                        "${tracker.totalPtsServLost}/$totalPtsServ (${calculatePercent(tracker.totalPtsServLost, totalPtsServ)}%)",
                        style: TextStyle(
                          fontSize: 13,
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
                        "Puntos ganados en total",
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
                      child: Text(
                        "${tracker.totalPts}/$totalPts (${calculatePercent(tracker.totalPts, totalPts)}%)",
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
                      child: Text(
                        "${tracker.totalPtsLost}/$totalPts (${calculatePercent(tracker.totalPtsLost, totalPts)}%)",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}

class BasicTableGames extends StatelessWidget {
  const BasicTableGames({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    StatisticsTracker tracker = match.tracker!;

    int totalGamesServ = tracker.gamesWonServing + tracker.gamesLostServing;
    int totalGamesRet = tracker.gamesWonReturning + tracker.gamesLostReturning;

    int totalGames = totalGamesServ + totalGamesRet;

    return Column(
      children: [
        TitleRow(title: "Games"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
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
                        "Games ganados con el servicio",
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
                      child: Text(
                        "${tracker.gamesWonServing}/$totalGamesServ",
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
                      child: Text(
                        "${tracker.gamesLostReturning}/$totalGamesRet",
                        style: TextStyle(
                          fontSize: 13,
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
                        "Games ganados con la devolución",
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
                      child: Text(
                        "${tracker.gamesWonReturning}/$totalGamesRet",
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
                      child: Text(
                        "${tracker.gamesLostServing}/$totalGamesServ",
                        style: TextStyle(
                          fontSize: 13,
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
                        "Games ganados en total",
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
                      child: Text(
                        "${tracker.totalGamesWon}/$totalGames",
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
                      child: Text(
                        "${tracker.totalGamesLost}/$totalGames",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}
