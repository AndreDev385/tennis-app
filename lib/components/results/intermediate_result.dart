import 'package:flutter/material.dart';
import 'package:tennis_app/components/results/players_row.dart';
import 'package:tennis_app/components/results/result_table/basic_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/place_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/return_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/service_table.dart';

import 'package:tennis_app/domain/match.dart';

class IntermediateResult extends StatelessWidget {
  const IntermediateResult({super.key, required this.match});

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
        ServiceTable(match: match),
        ReturnTable(match: match),
        BasicTableGames(match: match),
        BasicTablePoints(match: match),
        PlaceTable(match: match),
      ],
    );
  }
}
