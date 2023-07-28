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

    //serv done
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
    int partnerBckgPoints = tracker.partner!.meshPointsWon +
        tracker.partner!.meshPointsLost +
        tracker.partner!.winners;

    return Column(
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
                        match.player1.firstName,
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
                        "${match.player3?.firstName}",
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
                        fontSize: 20,
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
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.me.aces}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.partner?.aces}"),
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
                      child: const Text("Doble faltas"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.me.dobleFaults}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.partner?.dobleFaults}"),
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
                      child: const Text("1er Servicio In"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.me.firstServIn}/$myTotalServDone (${calculatePercent(tracker.me.firstServIn, myTotalServDone)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.firstServIn}/$partnerTotalServDone (${calculatePercent(tracker.partner!.firstServIn, partnerTotalServDone)}%)",
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
                      child: const Text("Puntos ganados con el 1er servicio"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.me.pointsWinnedFirstServ}/${tracker.me.firstServIn} (${calculatePercent(tracker.me.pointsWinnedFirstServ, tracker.me.firstServIn)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.pointsWinnedFirstServ}/${tracker.partner!.firstServIn} (${calculatePercent(tracker.partner!.pointsWinnedFirstServ, tracker.partner!.firstServIn)}%)",
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
                      child: const Text("Puntos ganados con el 2do servicio"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.me.pointsWinnedSecondServ}/${tracker.me.secondServIn} (${calculatePercent(tracker.me.pointsWinnedSecondServ, tracker.me.secondServIn)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.pointsWinnedSecondServ}/${tracker.partner!.secondServIn} (${calculatePercent(tracker.partner!.pointsWinnedSecondServ, tracker.partner!.secondServIn)}%)",
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
                      child: const Text("Break points salvados"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.me.breakPtsSaved}/${tracker.me.saveBreakPtsChances}",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.breakPtsSaved}/${tracker.partner!.saveBreakPtsChances}",
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
                      child: const Text("Games ganados con el servicio"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "",
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
                      "Devolucion",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
                      child: const Text("1era devolucion in"),
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
                          "${tracker.me.firstReturnIn}",
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
                          "${tracker.partner!.firstReturnIn}",
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
                      child: const Text("2do devolucion in"),
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
                          "${tracker.me.secondReturnIn}",
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
                          "${tracker.partner!.secondReturnIn}",
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
                      child:
                          const Text("Puntos ganados con la 1era devolucion"),
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
                          "${tracker.me.pointsWinnedFirstReturn}/${tracker.me.firstReturnIn} (${calculatePercent(tracker.me.pointsWinnedFirstReturn, tracker.me.firstReturnIn)}%)",
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
                          "${tracker.partner!.pointsWinnedFirstReturn}/${tracker.partner!.firstReturnIn} (${calculatePercent(tracker.partner!.pointsWinnedFirstReturn, tracker.partner!.firstReturnIn)}%)",
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
                      child: const Text("Puntos ganados con la 2da devolucion"),
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
                          "${tracker.me.pointsWinnedSecondReturn}/${tracker.me.secondReturnIn} (${calculatePercent(tracker.me.pointsWinnedSecondReturn, tracker.me.secondReturnIn)}%)",
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
                          "${tracker.partner!.pointsWinnedSecondReturn}/${tracker.partner!.secondReturnIn} (${calculatePercent(tracker.partner!.pointsWinnedSecondReturn, tracker.partner!.secondReturnIn)}%)",
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
                        fontSize: 20,
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
                      child: const Text("Puntos ganados con el servicio"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.me.pointsWonServing}/$myPointsServing (${calculatePercent(tracker.me.pointsWonServing, myPointsServing)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.pointsWonServing}/$partnerPointsServing (${calculatePercent(tracker.partner!.pointsWonServing, partnerPointsServing)}%)",
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
                      child: const Text("Puntos ganados con la devolucion"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.me.pointsWonReturning}/$myPointsReturning (${calculatePercent(tracker.me.pointsWonReturning, myPointsReturning)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.pointsWonReturning}/$partnerPointsReturning (${calculatePercent(tracker.partner!.pointsWonReturning, partnerPointsReturning)}%)",
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
                        "${tracker.me.pointsWon}/$myPoints (${calculatePercent(tracker.me.pointsWon, myPoints)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.pointsWon}/$partnerPoints (${calculatePercent(tracker.partner!.pointsWon, partnerPoints)}%)",
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
                        fontSize: 20,
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
                      child: const Text("Puntos ganados en malla"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.me.meshPointsWon}/$myMeshPoints (${calculatePercent(tracker.me.meshPointsWon, myMeshPoints)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.meshPointsWon}/$partnerMeshPoints (${calculatePercent(tracker.partner!.meshPointsWon, partnerMeshPoints)}%)",
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
                      child: const Text("Puntos ganados de fondo/approach"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.me.bckgPointsWon}/$myBckgPoints (${calculatePercent(tracker.me.bckgPointsWon, myBckgPoints)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.partner!.bckgPointsWon}/$partnerBckgPoints (${calculatePercent(tracker.partner!.bckgPointsWon, partnerBckgPoints)}%)",
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
                      child: const Text("Winners"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.me.winners}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.partner!.winners}"),
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
                      child: const Text("Errores no forzados"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.me.noForcedErrors}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.partner!.noForcedErrors}"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
