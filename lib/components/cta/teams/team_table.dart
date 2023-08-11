import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/team_stats.dto.dart';

class TeamTable extends StatelessWidget {
  const TeamTable({
    super.key,
    required this.stats,
  });

  final TeamStatsDto stats;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: const TableBorder(
        horizontalInside: BorderSide(width: .5, color: Colors.grey),
        bottom: BorderSide(width: .5, color: Colors.grey),
      ),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FixedColumnWidth(88),
      },
      children: <TableRow>[
        TableRow(
          children: [
            TableCell(
              child: Container(
                alignment: Alignment.centerLeft,
                height: 50,
                child: Text(
                  "Games ganados de local",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.gamesWonAsLocal}/${stats.gamesPlayedAsLocal}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Games ganados de visitante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.gamesWonAsVisitor}/${stats.gamesPlayedAsVisitor}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Games ganados en total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.totalGamesWon}/${stats.totalGamesPlayed}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Sets ganados de local",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.setsWonAsLocal}/${stats.setsPlayedAsLocal}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Sets ganados de visitante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.setsWonAsVisitor}/${stats.setsPlayedAsVisitor}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Sets ganados en total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.totalSetsWon}/${stats.totalSetsPlayed}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Super Tie-Breaks ganados de local",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.superTieBreaksWonAsLocal}/${stats.superTieBreaksPlayedAsLocal}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Super Tie-Breaks ganados de visitante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.superTieBreaksWonAsVisitor}/${stats.superTieBreaksPlayedAsVisitor}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Super Tie-Breaks ganados en total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.totalSuperTieBreaksWon}/${stats.totalSuperTieBreaksPlayed}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Partidos ganados de local",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.matchWonAsLocal}/${stats.matchPlayedAsLocal}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Partidos ganados de visitante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.matchWonAsVisitor}/${stats.matchPlayedAsVisitor}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Partidos ganados en total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.totalMatchWon}/${stats.totalMatchPlayed}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Partidos ganados ganando el primer set de local",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.matchsWonWithFirstSetWonAsLocal}/${stats.matchsPlayedWithFirstSetWonAsLocal}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Partidos ganados ganando el primer set de visitante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.matchsWonWithFirstSetWonAsVisitor}/${stats.matchsPlayedWithFirstSetWonAsVisitor}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Total partidos ganados ganando el primer set",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.totalMatchsWonWithFirstSetWon}/${stats.totalMatchsPlayedWithFirstSetWon}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Encuentros ganados de local",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.clashWonAsLocal}/${stats.clashPlayedAsLocal}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Encuentros ganados de visitante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.clashWonAsVisitor}/${stats.clashPlayedAsVisitor}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: Text(
                  "Encuentros ganados en total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                child: Text(
                  "${stats.totalClashWon}/${stats.totalClashPlayed}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
