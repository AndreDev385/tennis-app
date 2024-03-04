import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/advanced_table.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/utils/format_player_name.dart';

class SingleVsTable extends StatelessWidget {
  const SingleVsTable({
    super.key,
    required this.mode,
    required this.tracker,
    required this.name,
    required this.rivalName,
    this.rivalBreakPts,
  });

  final String mode;
  final TrackerDto tracker;
  final String name;
  final String rivalName;
  final String? rivalBreakPts;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                        formatPlayerName(name),
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
                        formatPlayerName(rivalName),
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
        AdvancedTable(
          mode: mode,
          tracker: tracker,
          rivalBreakPts: rivalBreakPts,
        ),
      ],
    );
  }
}
