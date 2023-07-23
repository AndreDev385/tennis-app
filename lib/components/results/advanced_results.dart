import 'package:flutter/material.dart';
import 'package:tennis_app/components/results/result_table/advanced/rally_table.dart';
import 'package:tennis_app/components/results/result_table/basic_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/place_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/return_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/service_table.dart';

import 'package:tennis_app/domain/match.dart';

class AdvancedResult extends StatelessWidget {
  const AdvancedResult({super.key, required this.match});

  final Match match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ServiceTable(match: match),
        ReturnTable(match: match),
        BasicTableGames(match: match),
        BasicTablePoints(match: match),
        PlaceTable(match: match),
        RallyTable(match: match),
      ],
    );
  }
}
