import 'package:flutter/material.dart';

import '../../domain/league/match.dart';
import 'players_row.dart';
import 'result_table/basic_table.dart';


class BasicResult extends StatelessWidget {
  const BasicResult({super.key, required this.match});

  final Match match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlayersRow(
          player1: match.player1,
          player2: match.player2,
          player3: match.player3,
          player4: match.player4,
        ),
        BasicTablePoints(match: match),
        BasicTableGames(match: match),
      ],
    );
  }
}
