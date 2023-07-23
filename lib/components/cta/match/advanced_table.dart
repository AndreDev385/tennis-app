import 'package:flutter/material.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/styles.dart';
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

    //serv
    int totalServDone =
        tracker.firstServIn + tracker.secondServIn + tracker.dobleFault;

    int rivalTotalServDone = tracker.rivalFirstServIn +
        tracker.rivalSecondServIn +
        tracker.rivalDobleFault;

    // pts
    int totalGamesServ = tracker.gamesWonServing + tracker.gamesLostServing;
    int totalGamesRet = tracker.gamesWonReturning + tracker.gamesLostReturning;

    int totalPtsServ = tracker.totalPtsServ + tracker.totalPtsServLost;
    int totalPtsRet = tracker.totalPtsRet + tracker.totalPtsRetLost;
    int totalPts = tracker.totalPts + tracker.totalPtsLost;

    // games
    int totalGames = totalGamesServ + totalGamesRet;

    int myMeshPoints = tracker.me.meshPointsWon + tracker.me.meshPointsLost;
    int myBckgPoints = tracker.me.bckgPointsWon +
        tracker.me.bckgPointsLost +
        tracker.me.winners;

    // rally pts
    int totalShortRallys = tracker.shortRallyWon + tracker.shortRallyLost;
    int totalMediumRallys = tracker.mediumRallyWon + tracker.mediumRallyLost;
    int totalLongRallys = tracker.longRallyWon + tracker.longRallyLost;

    return Column(
      children: [
        Container(
          color: MyTheme.purple,
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
                      child: Text("${tracker.aces}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.rivalAces}"),
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
                      child: Text("${tracker.dobleFault}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.rivalDobleFault}"),
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
                        "${tracker.firstServIn}/$totalServDone (${calculatePercent(tracker.firstServIn, totalServDone)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalFirstServIn}/$rivalTotalServDone (${calculatePercent(tracker.rivalFirstServIn, rivalTotalServDone)}%)",
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
                        "${tracker.pointsWon1Serv}/${tracker.firstServIn} (${calculatePercent(tracker.pointsWon1Serv, tracker.firstServIn)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalPointsWinnedFirstServ}/${tracker.rivalFirstServIn} (${calculatePercent(tracker.rivalPointsWinnedFirstServ, tracker.rivalFirstServIn)}%)",
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
                        "${tracker.pointsWon2Serv}/${tracker.secondServIn} (${calculatePercent(tracker.pointsWon2Serv, tracker.secondServIn)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.rivalPointsWinnedSecondServ}/${tracker.rivalSecondServIn} (${calculatePercent(tracker.rivalPointsWinnedSecondServ!, tracker.rivalSecondServIn!)}%)",
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
                      child: Text("${tracker.gamesWonServing}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${(tracker.gamesWonServing + tracker.gamesLostServing) - tracker.gamesLostServing}",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: MyTheme.purple,
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
                          "${tracker.rivalFirstReturnIn}/${tracker.firstServIn!} (${calculatePercent(tracker.rivalFirstReturnIn!, tracker.firstServIn!)}%)",
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
                        child: Text(widget.rivalBreakPts ?? ""),
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
                        child: Text("${tracker.gamesLostReturning}"),
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
        ),
        Container(
          color: MyTheme.purple,
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
                        "${tracker.totalPtsServ}/$totalPtsServ (${calculatePercent(tracker.totalPtsServ, totalPtsServ)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.totalPtsRetLost}/$totalPtsRet (${calculatePercent(tracker.totalPtsRetLost, totalPtsRet)}%)",
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
                        "${tracker.totalPtsRet}/$totalPtsRet (${calculatePercent(tracker.totalPtsRet, totalPtsRet)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.totalPtsServLost}/$totalPtsServ (${calculatePercent(tracker.totalPtsServLost, totalPtsServ)}%)",
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
                        "${tracker.totalPts}/$totalPts (${calculatePercent(tracker.totalPts, totalPts)}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.totalPtsLost}/$totalPts (${calculatePercent(tracker.totalPtsLost, totalPts)}%)",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: MyTheme.purple,
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
                      child: const Text("Games ganados con el servicio"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.gamesWonServing}/$totalGamesServ"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child:
                          Text("${tracker.gamesLostReturning}/$totalGamesRet"),
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
                      child: const Text("Games ganados con la devolucion"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child:
                          Text("${tracker.gamesWonReturning}/$totalGamesRet"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child:
                          Text("${tracker.gamesLostServing}/$totalGamesServ"),
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
                      child: const Text("Games ganados en total"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.totalGamesWon}/$totalGames"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.totalGamesLost}/$totalGames"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: MyTheme.purple,
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
                      child: const Text("Winners"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.winners}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.rivalWinners}"),
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
                      child: Text("${tracker.noForcedErrors}"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${tracker.rivalNoForcedErrors}"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: MyTheme.purple,
          height: 40,
          child: const Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rallys",
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
                      child: const Text("Puntos ganados con rally corto"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.shortRallyWon}/$totalShortRallys (${calculatePercent(tracker.shortRallyWon, totalShortRallys).round()}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.shortRallyLost}/$totalShortRallys (${calculatePercent(tracker.shortRallyLost, totalShortRallys).round()}%)",
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
                      child: const Text("Puntos ganados con rally medio"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.mediumRallyWon}/$totalMediumRallys (${calculatePercent(tracker.mediumRallyWon, totalMediumRallys).round()}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.mediumRallyLost}/$totalMediumRallys (${calculatePercent(tracker.mediumRallyLost, totalMediumRallys).round()}%)",
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
                      child: const Text("Puntos ganados con rally largo"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.longRallyWon}/$totalLongRallys (${calculatePercent(tracker.longRallyWon, totalLongRallys).round()}%)",
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(
                        "${tracker.longRallyLost}/$totalLongRallys (${calculatePercent(tracker.longRallyLost, totalLongRallys).round()}%)",
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
