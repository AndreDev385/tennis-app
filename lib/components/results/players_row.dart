import 'package:flutter/material.dart';

class PlayersRow extends StatelessWidget {
  const PlayersRow({
    super.key,
    required this.player1,
    required this.player2,
    this.player3,
    this.player4,
  });

  final String player1;
  final String player2;
  final String? player3;
  final String? player4;

  @override
  Widget build(BuildContext context) {
    return Table(
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
                  "${player1} ${player3 != null ? "/ ${player3!}" : ""}",
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
                  "$player2 ${player4 != null ? "/ ${player4!}" : ""}",
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
    );
  }
}
