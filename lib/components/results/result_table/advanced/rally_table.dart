import 'package:flutter/material.dart';
import 'package:tennis_app/components/results/title_row.dart';

import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/domain/statistics.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class RallyTable extends StatelessWidget {
  const RallyTable({super.key, required this.match});

  final Match? match;

  @override
  Widget build(BuildContext context) {
    StatisticsTracker tracker = match!.tracker!;

    int totalShortRallys = tracker.shortRallyWon + tracker.shortRallyLost;
    int totalMediumRallys = tracker.mediumRallyWon + tracker.mediumRallyLost;
    int totalLongRallys = tracker.longRallyWon + tracker.longRallyLost;

    return Column(
      children: [
        const TitleRow(title: "Rallys"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Table(
            border: const TableBorder(
              horizontalInside: BorderSide(width: .5, color: Colors.grey),
              bottom: BorderSide(width: .5, color: Colors.grey),
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FixedColumnWidth(104),
              2: FixedColumnWidth(104),
            },
            children: <TableRow>[
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      child: const Text(
                        "Puntos ganados en rally corto",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      child: Text(
                        "${tracker.shortRallyWon}/$totalShortRallys (${calculatePercent(tracker.shortRallyWon, totalShortRallys).round()}%)",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      child: Text(
                        "${tracker.shortRallyLost}/$totalShortRallys (${calculatePercent(tracker.shortRallyLost, totalShortRallys).round()}%)",
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
                      height: 40,
                      child: const Text(
                        "Puntos ganados en rally medio",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      child: Text(
                        "${tracker.mediumRallyWon}/$totalMediumRallys (${calculatePercent(tracker.mediumRallyWon, totalMediumRallys).round()}%)",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      child: Text(
                        "${tracker.mediumRallyLost}/$totalMediumRallys (${calculatePercent(tracker.mediumRallyLost, totalMediumRallys).round()}%)",
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
                      height: 40,
                      child: const Text(
                        "Puntos ganados en rally largo",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      child: Text(
                        "${tracker.longRallyWon}/$totalLongRallys (${calculatePercent(tracker.longRallyWon, totalLongRallys).round()}%)",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      child: Text(
                        "${tracker.longRallyLost}/$totalLongRallys (${calculatePercent(tracker.longRallyLost, totalLongRallys).round()}%)",
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
        const Padding(padding: EdgeInsets.only(bottom: 24))
      ],
    );
  }
}
