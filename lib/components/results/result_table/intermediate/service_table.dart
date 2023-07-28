import 'package:flutter/material.dart';
import 'package:tennis_app/domain/statistics.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class ServiceTable extends StatelessWidget {
  const ServiceTable({super.key, required this.match});

  final Match match;

  @override
  Widget build(BuildContext context) {
    StatisticsTracker tracker = match.tracker!;

    int totalServDone =
        tracker.firstServIn + tracker.secondServIn + tracker.dobleFault;

    int rivalTotalServDone = tracker.rivalFirstServIn +
        tracker.rivalSecondServIn +
        tracker.rivalDobleFault;

    return Column(
      children: [
        const Text(
          "Servicios",
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
                        "${tracker.rivalFirstServIn}/$rivalTotalServDone (${calculatePercent(tracker.rivalFirstServIn, rivalTotalServDone)}%)"),
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
                      "${tracker.rivalPointsWinnedSecondServ}/${tracker.rivalSecondServIn} (${calculatePercent(tracker.rivalPointsWinnedSecondServ, tracker.rivalSecondServIn)}%)",
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
                      "${tracker.gamesLostReturning}",
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
