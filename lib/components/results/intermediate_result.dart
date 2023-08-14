import 'package:flutter/material.dart';
import 'package:tennis_app/components/results/result_table/basic_table.dart';
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
        ServiceTable(match: match),
        ReturnTable(match: match),
        BasicTableGames(match: match),
        BasicTablePoints(match: match),
        //PlaceTable(match: match),
      ],
    );
  }
}
