import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class ProfileTable extends StatelessWidget {
  const ProfileTable({
    super.key,
    required this.stats,
  });

  final PlayerTrackerDto stats;

  @override
  Widget build(BuildContext context) {
    int totalServDone =
        stats.firstServIn + stats.secondServIn + stats.dobleFaults;

    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: 40,
              child: const Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Servicio",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FixedColumnWidth(88),
                },
                children: <TableRow>[
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: const Text(
                            "Aces",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.aces}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                            "Doble falta",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.dobleFaults}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                            "1er servicio in",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.firstServIn}/$totalServDone (${calculatePercent(stats.firstServIn, totalServDone)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: const Text(
                            "1er saque ganador",
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
                            "${stats.firstServWon}",
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
                            "Puntos ganados con el 1er servicio",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.pointsWinnedFirstServ}/${stats.firstServIn} (${calculatePercent(stats.pointsWinnedFirstServ, stats.firstServIn)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                            "2do Servicio In",
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
                            "${stats.secondServIn}/${stats.secondServIn + stats.dobleFaults} (${calculatePercent(stats.secondServIn, stats.secondServIn + stats.dobleFaults)}%)",
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
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: const Text(
                            "2do saque ganador",
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
                            "${stats.secondServWon}",
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
                            "Puntos ganados con el 2do servicio",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.pointsWinnedSecondServ}/${stats.secondServIn} (${calculatePercent(stats.pointsWinnedSecondServ, stats.secondServIn)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                            "Break points salvados",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.breakPtsSaved}/${stats.saveBreakPtsChances} (${calculatePercent(stats.breakPtsSaved, stats.saveBreakPtsChances)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                            "Games ganados con el servicio",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.gamesWonServing}/${stats.gamesWonServing + stats.gamesLostServing} (${calculatePercent(stats.gamesWonServing, stats.gamesWonServing + stats.gamesLostServing)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: 40,
              child: const Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Devolución",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FixedColumnWidth(88),
                },
                children: <TableRow>[
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: const Text(
                            "1era devolución in",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.firstReturnIn}/${stats.firstReturnIn + stats.firstReturnOut} (${calculatePercent(stats.firstReturnIn, stats.firstReturnIn + stats.firstReturnOut)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                              "${stats.firstReturnWon}",
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
                            "Winner con 1era devolución",
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
                              "${stats.firstReturnWinner}",
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
                              "${stats.pointsWinnedFirstReturn}/${stats.firstReturnIn + stats.firstReturnOut} (${calculatePercent(stats.pointsWinnedFirstReturn, stats.firstReturnIn + stats.firstReturnOut)}%)",
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
                            "2da devolución in",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.secondReturnIn}/${stats.secondReturnIn + stats.secondReturnOut} (${calculatePercent(stats.secondReturnIn, stats.secondReturnIn + stats.secondReturnOut)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                              "${stats.secondReturnWon}",
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
                              "${stats.secondReturnWinner}",
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
                            "Puntos ganados con la 2da devolución",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.pointsWinnedSecondReturn}/${stats.secondReturnIn + stats.secondReturnOut} (${calculatePercent(stats.pointsWinnedSecondReturn, stats.secondReturnIn + stats.secondReturnOut)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: 40,
              child: const Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pelota en juego",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FixedColumnWidth(88),
                },
                children: <TableRow>[
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: const Text(
                            "Puntos ganados en malla",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.meshPointsWon}/${stats.meshPointsWon + stats.meshPointsLost} (${calculatePercent(stats.meshPointsWon, stats.meshPointsWon + stats.meshPointsLost)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                            "Winners en la malla",
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
                            "${stats.meshWinner}",
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
                            "Errores en la malla",
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
                            "${stats.meshError}",
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
                            "Puntos ganados en fondo/approach",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.bckgPointsWon}/${stats.bckgPointsWon + stats.bckgPointsLost} (${calculatePercent(stats.bckgPointsWon, stats.bckgPointsWon + stats.bckgPointsLost)}%)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
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
                            "Winners en fondo/approach",
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
                            "${stats.bckgWinner}",
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
                            "Errores en fondo/approach",
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
                            "${stats.bckgError}",
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
                            "Total winners",
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
                            "${stats.winners}",
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
                            "Total errores no forzados",
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
                            "${stats.noForcedErrors}",
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
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 40)),
      ],
    );
  }
}
