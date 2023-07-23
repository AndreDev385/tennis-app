import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/advanced_table.dart';
import 'package:tennis_app/dtos/match_dtos.dart';

class SingleVsTable extends StatelessWidget {
  const SingleVsTable({
    super.key,
    required this.match,
    this.rivalBreakPts,
  });

  final MatchDto match;
  final String? rivalBreakPts;

  @override
  Widget build(BuildContext context) {
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
                      child: const Text("Jugadores"),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(match.player1.firstName,
                          textAlign: TextAlign.end),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text(match.player2, textAlign: TextAlign.end),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AdvancedTable(
          match: match,
          rivalBreakPts: rivalBreakPts,
        )
      ],
    );
  }
}
