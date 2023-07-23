import 'package:flutter/material.dart';
import 'package:tennis_app/components/results/result_table/basic_table.dart';

import "package:tennis_app/domain/match.dart";

class BasicResult extends StatelessWidget {
  const BasicResult({super.key, required this.match});

  final Match match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BasicTablePoints(match: match),
        BasicTableGames(match: match),
      ],
    );
  }
}
