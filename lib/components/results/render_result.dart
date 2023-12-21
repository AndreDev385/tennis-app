import "package:flutter/material.dart";
import "package:tennis_app/domain/game_rules.dart";
import "package:tennis_app/domain/match.dart";
import 'advanced_results.dart';
import 'basic_result.dart';

class ResultTable extends StatelessWidget {
  const ResultTable({super.key, required this.match});

  final Match match;

  @override
  Widget build(BuildContext context) {
    Widget renderResults() {
      if (match.statistics == Statistics.basic) {
        return BasicResult(match: match);
      }
      if (match.statistics == Statistics.intermediate) {
        return AdvancedResult(
          match: match,
          showRally: false,
        );
      }
      if (match.statistics == Statistics.advanced) {
        return AdvancedResult(
          match: match,
          showRally: true,
        );
      }
      return BasicResult(match: match);
    }

    return renderResults();
  }
}
