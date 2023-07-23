import 'package:flutter/material.dart';
import 'package:tennis_app/domain/game_rules.dart';

import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/domain/statistics.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class PlaceTable extends StatelessWidget {
  const PlaceTable({super.key, required this.match});

  final Match match;

  @override
  Widget build(BuildContext context) {
    StatisticsTracker tracker = match.tracker!;

    int myMeshPoints = tracker.me.meshPointsWon + tracker.me.meshPointsLost;
    int partnerMeshPoints = 1;

    int myBckgPoints = tracker.me.bckgPointsWon +
        tracker.me.bckgPointsLost +
        tracker.me.winners;

    int partnerBckgPoints = 1;

    bool double = match.mode == GameMode.double;

    if (double) {
      partnerMeshPoints =
          tracker.partner!.meshPointsWon + tracker.partner!.meshPointsLost;

      partnerBckgPoints = tracker.partner!.bckgPointsWon +
          tracker.partner!.bckgPointsLost +
          tracker.partner!.winners;
    }

    return Column(
      children: [
        const Text(
          "Pelota en juego",
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
            if (double)
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: const Text("Puntos ganados en la malla"),
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
            if (double)
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
                        "${tracker.me.bckgPointsWon + tracker.me.winners}/$myBckgPoints (${calculatePercent(tracker.me.bckgPointsWon + tracker.me.winners, myBckgPoints)}%)",
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
        const Padding(padding: EdgeInsets.only(bottom: 24))
      ],
    );
  }
}
