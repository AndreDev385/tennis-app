import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';

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

    int pointsWonServ =
        stats.pointsWinnedFirstServ + stats.pointsWinnedSecondServ;
    int pointsWonRet =
        stats.pointsWinnedFirstReturn + stats.pointsWinnedSecondReturn;

    int totalPointsWon = pointsWonServ + pointsWonRet;

    int totalPoints = totalPointsWon + stats.pointsLost;

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
                            fontSize: 18,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.firstServIn}/$totalServDone",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.pointsWinnedFirstServ}/${stats.firstServIn}",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.pointsWinnedSecondServ}/${stats.secondServIn}",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.breakPtsSaved}/${stats.saveBreakPtsChances}",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.gamesWonServing}/${stats.gamesWonServing + stats.gamesLostServing}",
                            textAlign: TextAlign.center,
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
                            fontSize: 18,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.firstReturnIn}/${stats.pointsWonReturning + stats.pointsLostReturning}",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.secondReturnIn}/${stats.pointsWonReturning + stats.pointsLostReturning}",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.pointsWinnedFirstReturn}/${stats.firstReturnIn}",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.pointsWinnedSecondReturn}/${stats.secondReturnIn}",
                            textAlign: TextAlign.center,
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
                            fontSize: 18,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.meshPointsWon}/${stats.meshPointsWon + stats.meshPointsLost}",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.bckgPointsWon}/${stats.bckgPointsWon + stats.bckgPointsLost}",
                            textAlign: TextAlign.center,
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
                            "winners",
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.winners}",
                            textAlign: TextAlign.center,
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
                            "Errores no forzados",
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "${stats.noForcedErrors}",
                            textAlign: TextAlign.center,
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
                          "Puntos",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                            "Puntos ganados con el servicio",
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "$pointsWonServ/$totalServDone",
                            textAlign: TextAlign.center,
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
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "$pointsWonRet/${stats.pointsWonReturning + stats.pointsLostReturning}",
                            textAlign: TextAlign.center,
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
                            "Total puntos ganados",
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          child: Text(
                            "$totalPointsWon/$totalPoints",
                            textAlign: TextAlign.center,
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
