import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/vertical_barchart.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class ProfileReturnCharts extends StatelessWidget {
  const ProfileReturnCharts({
    super.key,
    required this.stats,
  });

  final PlayerTrackerDto stats;

  @override
  Widget build(BuildContext context) {
    int totalPointsReturning = stats.firstReturnIn +
        stats.secondReturnIn +
        stats.firstReturnOut +
        stats.secondReturnOut;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            child: Container(
              height: 220,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.firstReturnIn,
                            stats.firstReturnOut + stats.firstReturnIn,
                          ),
                          title: "1 Devol. In",
                          fraction:
                              "${stats.firstReturnIn}/${stats.firstReturnIn + stats.firstReturnOut}",
                          type: 0,
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.secondReturnIn,
                            stats.secondReturnIn + stats.secondReturnOut,
                          ),
                          title: "2 Devol. In",
                          fraction:
                              "${stats.secondReturnIn}/${stats.secondReturnIn + stats.secondReturnOut}",
                          type: 1,
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                              stats.firstReturnIn + stats.secondReturnIn,
                              totalPointsReturning),
                          title: "Total",
                          fraction:
                              "${stats.firstReturnIn + stats.secondReturnIn}/$totalPointsReturning",
                          type: 2,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 5,
            child: Container(
              height: 260,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Text(
                    "Puntos ganados",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.pointsWinnedFirstReturn,
                            stats.firstReturnIn,
                          ),
                          title: "1era Devolución",
                          fraction:
                              "${stats.pointsWinnedFirstReturn}/${stats.firstReturnIn}",
                          type: 0,
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.pointsWinnedSecondReturn,
                            stats.secondReturnIn,
                          ),
                          title: "2da Devolución",
                          fraction:
                              "${stats.pointsWinnedSecondReturn}/${stats.secondReturnIn}",
                          type: 1,
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                              stats.pointsWinnedFirstReturn +
                                  stats.pointsWinnedSecondReturn,
                              stats.firstReturnIn + stats.secondReturnIn),
                          title: "Total",
                          fraction:
                              "${stats.pointsWinnedFirstReturn + stats.pointsWinnedSecondReturn}/${stats.firstReturnIn + stats.secondReturnIn}",
                          type: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
