import 'package:flutter/material.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class AdvancedTable extends StatefulWidget {
  const AdvancedTable({
    super.key,
    required this.match,
    required this.rivalBreakPts,
  });

  final String? rivalBreakPts;
  final MatchDto match;

  @override
  State<AdvancedTable> createState() => _AdvancedTableState();
}

class _AdvancedTableState extends State<AdvancedTable> {
  @override
  Widget build(BuildContext context) {
    TrackerDto tracker = widget.match.tracker!;

    // pts
    int totalGamesServ = tracker.gamesWonServing + tracker.gamesLostServing;
    int totalGamesRet = tracker.gamesWonReturning + tracker.gamesLostReturning;

    int totalPtsServ = tracker.totalPtsServ + tracker.totalPtsServLost;
    int totalPtsRet = tracker.totalPtsRet + tracker.totalPtsRetLost;
    int totalPts = tracker.totalPts + tracker.totalPtsLost;

    // games
    int totalGames = totalGamesServ + totalGamesRet;

    int myMeshPoints = tracker.me.meshPointsWon + tracker.me.meshPointsLost;
    int myBckgPoints = tracker.me.bckgPointsWon + tracker.me.bckgPointsLost;
    // rally pts
    int totalShortRallys = tracker.shortRallyWon + tracker.shortRallyLost;
    int totalMediumRallys = tracker.mediumRallyWon + tracker.mediumRallyLost;
    int totalLongRallys = tracker.longRallyWon + tracker.longRallyLost;

    return Column(
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
                        "${tracker.aces}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalAces}",
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
                      child: const Text("Doble faltas",
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
                        "${tracker.dobleFault}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalDobleFault}",
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
                      child: const Text("1er Servicio In",
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
                        "${tracker.firstServIn}/${tracker.firstServIn + tracker.secondServIn}(${calculatePercent(tracker.firstServIn, tracker.firstServIn + tracker.secondServIn)}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalFirstServIn}/${tracker.rivalFirstServIn + tracker.rivalSecondServIn}(${calculatePercent(tracker.rivalFirstServIn, tracker.rivalFirstServIn + tracker.rivalSecondServIn)}%)",
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
                      child: const Text("Puntos ganados con el 1er servicio",
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
                        "${tracker.pointsWon1Serv}/${tracker.firstServIn}(${calculatePercent(tracker.pointsWon1Serv, tracker.firstServIn)}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalPointsWinnedFirstServ}/${tracker.rivalFirstServIn}(${calculatePercent(tracker.rivalPointsWinnedFirstServ, tracker.rivalFirstServIn)}%)",
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
                      child: const Text("Puntos ganados con el 2do servicio",
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
                        "${tracker.pointsWon2Serv}/${tracker.secondServIn}(${calculatePercent(tracker.pointsWon2Serv, tracker.secondServIn)}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalPointsWinnedSecondServ}/${tracker.rivalSecondServIn}(${calculatePercent(tracker.rivalPointsWinnedSecondServ, tracker.rivalSecondServIn)}%)",
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
                      child: const Text("Games ganados con el servicio",
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
                        "${tracker.gamesWonServing}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.gamesLostReturning}",
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
                      child: const Text("1era devolución in",
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
                          "${tracker.firstRetIn}/${tracker.rivalFirstServIn}(${calculatePercent(tracker.firstRetIn, tracker.rivalFirstServIn)}%)",
                          style: TextStyle(fontSize: 13),
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
                          "${tracker.rivalFirstReturnIn}/${tracker.firstServIn}(${calculatePercent(tracker.rivalFirstReturnIn, tracker.firstServIn)}%)",
                          style: TextStyle(fontSize: 13),
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
                      child: const Text("2do devolución in",
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
                          "${tracker.secondRetIn}/${tracker.rivalSecondServIn}(${calculatePercent(tracker.secondRetIn, tracker.rivalSecondServIn)}%)",
                          style: TextStyle(fontSize: 13),
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
                          "${tracker.rivalSecondReturnIn}/${tracker.secondServIn}(${calculatePercent(tracker.rivalSecondReturnIn, tracker.secondServIn)}%)",
                          style: TextStyle(fontSize: 13),
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
                          const Text("Puntos ganados con la 1era devolución",
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
                          "${tracker.pointsWon1Ret}/${tracker.firstRetIn}(${calculatePercent(tracker.pointsWon1Ret, tracker.firstRetIn)}%)",
                          style: TextStyle(fontSize: 13),
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
                          "${tracker.rivalPointsWinnedFirstReturn}/${tracker.rivalFirstReturnIn}(${calculatePercent(tracker.rivalPointsWinnedFirstReturn, tracker.rivalFirstReturnIn)}%)",
                          style: TextStyle(fontSize: 13),
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
                      child: const Text("Puntos ganados con la 2da devolución",
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
                          "${tracker.pointsWon2Ret}/${tracker.secondRetIn}(${calculatePercent(tracker.pointsWon2Ret, tracker.secondRetIn)}%)",
                          style: TextStyle(fontSize: 13),
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
                          "${tracker.rivalPointsWinnedSecondReturn}/${tracker.rivalSecondReturnIn}(${calculatePercent(tracker.rivalPointsWinnedSecondReturn, tracker.rivalSecondReturnIn)}%)",
                          style: TextStyle(fontSize: 13),
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
                      child: const Text("Break points",
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
                          style: TextStyle(fontSize: 13),
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
                          widget.rivalBreakPts ?? "",
                          style: TextStyle(fontSize: 13),
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
                      child: const Text("Games ganados devolviendo",
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
                          style: TextStyle(fontSize: 13),
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
                          style: TextStyle(fontSize: 13),
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
                      child: const Text("Puntos ganados con el servicio",
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
                        "${tracker.totalPtsServ}/$totalPtsServ(${calculatePercent(tracker.totalPtsServ, totalPtsServ)}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.totalPtsRetLost}/$totalPtsRet(${calculatePercent(tracker.totalPtsRetLost, totalPtsRet)}%)",
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
                      child: const Text("Puntos ganados con la devolución",
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
                        "${tracker.totalPtsRet}/$totalPtsRet(${calculatePercent(tracker.totalPtsRet, totalPtsRet)}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.totalPtsServLost}/$totalPtsServ(${calculatePercent(tracker.totalPtsServLost, totalPtsServ)}%)",
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
                      child: const Text("Puntos ganados en total",
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
                        "${tracker.totalPts}/$totalPts(${calculatePercent(tracker.totalPts, totalPts)}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.totalPtsLost}/$totalPts(${calculatePercent(tracker.totalPtsLost, totalPts)}%)",
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
                      "Games",
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
                      child: const Text("Games ganados con el servicio",
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
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.gamesLostReturning}/$totalGamesRet",
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
                      child: const Text("Games ganados con la devolución",
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
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.gamesLostServing}/$totalGamesServ",
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
                      child: const Text("Games ganados en total",
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
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.totalGamesLost}/$totalGames",
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
              if (widget.match.mode == GameMode.single)
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: const Text("Puntos ganados en malla",
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
                          "${tracker.me.meshPointsWon}/$myMeshPoints(${calculatePercent(tracker.me.meshPointsWon, myMeshPoints)}%)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        child: const Text(""),
                      ),
                    ),
                  ],
                ),
              if (widget.match.mode == GameMode.single)
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: const Text("Puntos ganados de fondo/approach",
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
                          "${tracker.me.bckgPointsWon}/$myBckgPoints(${calculatePercent(tracker.me.bckgPointsWon, myBckgPoints)}%)",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        child: const Text(""),
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
                      child: const Text("Winners",
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
                        "${tracker.winners}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalWinners}",
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
                      child: const Text("Errores no forzados",
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
                        "${tracker.noForcedErrors}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalNoForcedErrors}",
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
                      "Rally",
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
            children: <TableRow>[
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: const Text(
                        "Puntos ganados con rally corto",
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
                        "${tracker.shortRallyWon}/$totalShortRallys(${calculatePercent(tracker.shortRallyWon, totalShortRallys).round()}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.shortRallyLost}/$totalShortRallys(${calculatePercent(tracker.shortRallyLost, totalShortRallys).round()}%)",
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
                      child: const Text("Puntos ganados con rally medio",
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
                        "${tracker.mediumRallyWon}/$totalMediumRallys(${calculatePercent(tracker.mediumRallyWon, totalMediumRallys).round()}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.mediumRallyLost}/$totalMediumRallys(${calculatePercent(tracker.mediumRallyLost, totalMediumRallys).round()}%)",
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
                      child: const Text("Puntos ganados con rally largo",
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
                        "${tracker.longRallyWon}/$totalLongRallys(${calculatePercent(tracker.longRallyWon, totalLongRallys).round()}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.longRallyLost}/$totalLongRallys(${calculatePercent(tracker.longRallyLost, totalLongRallys).round()}%)",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
