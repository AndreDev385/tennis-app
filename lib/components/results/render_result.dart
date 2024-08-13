import "package:flutter/material.dart";

import "../../domain/league/match.dart";
import "../../domain/shared/utils.dart";
import "advanced_results.dart";
import "basic_result.dart";


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
