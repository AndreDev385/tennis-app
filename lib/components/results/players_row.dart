import 'package:flutter/material.dart';
import 'package:tennis_app/utils/format_player_name.dart';

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
    renderPlayersName(bool rivals) {
      if (rivals) {
        return player4 != null && player4!.isNotEmpty
            ? '${formatPlayerName(player2)} / ${formatPlayerName(player4)}'
            : formatPlayerName(player2);
      }
      return player3 != null && player3!.isNotEmpty
          ? '${formatPlayerName(player1)} / ${formatPlayerName(player3)}'
          : formatPlayerName(player1);
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: <TableRow>[
          TableRow(
            children: [
              TableCell(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Text(
                    "${player3 != null && player3!.isNotEmpty ? "Parejas" : "Jugadores"}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  margin: EdgeInsets.all(4),
                  alignment: Alignment.centerRight,
                  height: 50,
                  child: Text(
                    renderPlayersName(false),
                    textAlign: TextAlign.center,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  margin: EdgeInsets.all(4),
                  alignment: Alignment.centerRight,
                  height: 50,
                  child: Text(
                    renderPlayersName(true),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
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
    );
  }
}
