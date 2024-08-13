import 'package:flutter/material.dart';

import '../../domain/league/match.dart';
import 'players_row.dart';
import 'result_table/basic_table.dart';
import 'result_table/intermediate/place_table.dart';
import 'result_table/intermediate/return_table.dart';
import 'result_table/intermediate/service_table.dart';
import 'result_table/resume_points_table.dart';

class IntermediateResult extends StatelessWidget {
  final Match match;

  const IntermediateResult({super.key, required this.match});

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
        ResumePointsTable(match: match),
        PlaceTable(match: match),
      ],
    );
  }
}
