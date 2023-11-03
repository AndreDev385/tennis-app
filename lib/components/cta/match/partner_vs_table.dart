import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class PartnerVsTable extends StatelessWidget {
  const PartnerVsTable({
    super.key,
    required this.match,
  });

  final MatchDto match;

  @override
  Widget build(BuildContext context) {
    final TrackerDto tracker = match.tracker!;

    // serv in
    int myTotalServDone = tracker.me.firstServIn +
        tracker.me.secondServIn +
        tracker.me.dobleFaults;
    int partnerTotalServDone = tracker.partner!.firstServIn +
        tracker.partner!.secondServIn +
        tracker.partner!.dobleFaults;

    // serv son
    int myPointsServing =
        tracker.me.pointsWonServing + tracker.me.pointsLostServing;
    int partnerPointsServing =
        tracker.partner!.pointsWonServing + tracker.partner!.pointsLostServing;

    // return won
    int myPointsReturning =
        tracker.me.pointsWonReturning + tracker.me.pointsLostReturning;

    int partnerPointsReturning = tracker.partner!.pointsWonReturning +
        tracker.partner!.pointsLostReturning;

    // totals
    int myPoints = tracker.me.pointsWon + tracker.me.pointsLost;
    int partnerPoints =
        tracker.partner!.pointsWon + tracker.partner!.pointsLost;

    // place points
    int myMeshPoints = tracker.me.meshPointsWon + tracker.me.meshPointsLost;
    int partnerMeshPoints =
        tracker.partner!.meshPointsWon + tracker.partner!.meshPointsLost;

    int myBckgPoints = tracker.me.bckgPointsWon +
        tracker.me.bckgPointsLost +
        tracker.me.winners;

    int partnerBckgPoints = tracker.partner!.bckgPointsWon +
        tracker.partner!.bckgPointsLost +
        tracker.partner!.winners;

    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Table(
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
                        "Jugadores",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        match.player1.firstName.split(" ")[0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${match.player3?.firstName.split(" ")[0]}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
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
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: const Text(
                            "Aces",
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
                            "${tracker.me.aces}",
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
                            "${tracker.partner?.aces}",
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
                            "Doble faltas",
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
                            "${tracker.me.dobleFaults}",
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
                            "${tracker.partner?.dobleFaults}",
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
                            "1er Servicio In",
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
                            "${tracker.me.firstServIn}/$myTotalServDone (${calculatePercent(tracker.me.firstServIn, myTotalServDone)}%)",
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
                            "${tracker.partner!.firstServIn}/$partnerTotalServDone (${calculatePercent(tracker.partner!.firstServIn, partnerTotalServDone)}%)",
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
                            "${tracker.me.pointsWinnedFirstServ}/${tracker.me.firstServIn} (${calculatePercent(tracker.me.pointsWinnedFirstServ, tracker.me.firstServIn)}%)",
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
                            "${tracker.partner!.pointsWinnedFirstServ}/${tracker.partner!.firstServIn} (${calculatePercent(tracker.partner!.pointsWinnedFirstServ, tracker.partner!.firstServIn)}%)",
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
                            "${tracker.me.pointsWinnedSecondServ}/${tracker.me.secondServIn} (${calculatePercent(tracker.me.pointsWinnedSecondServ, tracker.me.secondServIn)}%)",
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
                            "${tracker.partner!.pointsWinnedSecondServ}/${tracker.partner!.secondServIn} (${calculatePercent(tracker.partner!.pointsWinnedSecondServ, tracker.partner!.secondServIn)}%)",
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
                            "Break points salvados",
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
                            "${tracker.me.breakPtsSaved}/${tracker.me.saveBreakPtsChances}",
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
                            "${tracker.partner!.breakPtsSaved}/${tracker.partner!.saveBreakPtsChances}",
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
                            "${tracker.me.gamesWonServing}/${tracker.me.gamesWonServing + tracker.me.gamesLostServing}",
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
                            "${tracker.partner!.gamesWonServing}/${tracker.partner!.gamesWonServing + tracker.partner!.gamesLostServing}",
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
                              "${tracker.me.firstReturnIn}/${tracker.me.firstReturnIn + tracker.me.firstReturnOut} (${calculatePercent(tracker.me.firstReturnIn, tracker.me.firstReturnIn + tracker.me.firstReturnOut)}%)",
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
                              "${tracker.partner!.firstReturnIn}/${tracker.partner!.firstReturnIn + tracker.partner!.firstReturnOut} (${calculatePercent(tracker.partner!.firstReturnIn, tracker.partner!.firstReturnIn + tracker.partner!.firstReturnOut)}%)",
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
                              "${tracker.me.secondReturnIn}/${tracker.me.secondReturnIn + tracker.me.secondReturnOut} (${calculatePercent(tracker.me.secondReturnIn, tracker.me.secondReturnIn + tracker.me.secondReturnOut)}%)",
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
                              "${tracker.partner!.secondReturnIn}/${tracker.partner!.secondReturnIn + tracker.partner!.secondReturnOut} (${calculatePercent(tracker.partner!.secondReturnIn, tracker.partner!.secondReturnIn + tracker.partner!.secondReturnOut)}%)",
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
                              "${tracker.me.pointsWinnedFirstReturn}/${tracker.me.firstReturnIn + tracker.me.firstReturnOut} (${calculatePercent(tracker.me.pointsWinnedFirstReturn, tracker.me.firstReturnIn + tracker.me.firstReturnOut)}%)",
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
                              "${tracker.partner!.pointsWinnedFirstReturn}/${tracker.partner!.firstReturnIn + tracker.partner!.firstReturnOut} (${calculatePercent(tracker.partner!.pointsWinnedFirstReturn, tracker.partner!.firstReturnIn + tracker.partner!.firstReturnOut)}%)",
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
                              "${tracker.me.pointsWinnedSecondReturn}/${tracker.me.secondReturnIn + tracker.me.secondReturnOut} (${calculatePercent(tracker.me.pointsWinnedSecondReturn, tracker.me.secondReturnIn + tracker.me.secondReturnOut)}%)",
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
                              "${tracker.partner!.pointsWinnedSecondReturn}/${tracker.partner!.secondReturnIn + tracker.partner!.secondReturnOut} (${calculatePercent(tracker.partner!.pointsWinnedSecondReturn, tracker.partner!.secondReturnIn + tracker.partner!.secondReturnOut)}%)",
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
                            "${tracker.me.pointsWonServing}/$myPointsServing (${calculatePercent(tracker.me.pointsWonServing, myPointsServing)}%)",
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
                            "${tracker.partner!.pointsWonServing}/$partnerPointsServing (${calculatePercent(tracker.partner!.pointsWonServing, partnerPointsServing)}%)",
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
                            "${tracker.me.pointsWonReturning}/$myPointsReturning (${calculatePercent(tracker.me.pointsWonReturning, myPointsReturning)}%)",
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
                            "${tracker.partner!.pointsWonReturning}/$partnerPointsReturning (${calculatePercent(tracker.partner!.pointsWonReturning, partnerPointsReturning)}%)",
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
                            "${tracker.me.pointsWon}/$myPoints (${calculatePercent(tracker.me.pointsWon, myPoints)}%)",
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
                            "${tracker.partner!.pointsWon}/$partnerPoints (${calculatePercent(tracker.partner!.pointsWon, partnerPoints)}%)",
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
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
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
                            "Puntos ganados en malla",
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
                            "${tracker.me.meshPointsWon}/$myMeshPoints (${calculatePercent(tracker.me.meshPointsWon, myMeshPoints)}%)",
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
                            "${tracker.partner!.meshPointsWon}/$partnerMeshPoints (${calculatePercent(tracker.partner!.meshPointsWon, partnerMeshPoints)}%)",
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
                            "Puntos ganados de fondo/approach",
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
                            "${tracker.me.bckgPointsWon}/$myBckgPoints (${calculatePercent(tracker.me.bckgPointsWon, myBckgPoints)}%)",
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
                            "${tracker.partner!.bckgPointsWon}/$partnerBckgPoints (${calculatePercent(tracker.partner!.bckgPointsWon, partnerBckgPoints)}%)",
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
                            "Winners",
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
                            "${tracker.me.winners}",
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
                            "${tracker.partner!.winners}",
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
                            "Errores no forzados",
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
                            "${tracker.me.noForcedErrors}",
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
                            "${tracker.partner!.noForcedErrors}",
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
        )
      ],
    );
  }
}
