import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/advanced_table.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';

class CoupleVsTable extends StatelessWidget {
  const CoupleVsTable({
    super.key,
    required this.tracker,
    required this.names,
    required this.rivalNames,
    required this.mode,
    this.rivalBreakPts,
  });

  final String mode;
  final String? rivalBreakPts;
  final String names;
  final String rivalNames;
  final TrackerDto tracker;

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
                        names,
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
                        rivalNames,
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
