import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/advanced_table.dart';
import 'package:tennis_app/dtos/match_dtos.dart';

class CoupleVsTable extends StatelessWidget {
  const CoupleVsTable({
    super.key,
    required this.match,
    this.rivalBreakPts,
  });

  final String? rivalBreakPts;
  final MatchDto match;

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
                      child: Text(
                          "${match.player1.firstName} ${match.player3?.firstName}",
                          textAlign: TextAlign.end),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.centerRight,
                      height: 50,
                      child: Text("${match.player2} ${match.player4}",
                          textAlign: TextAlign.end),
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
