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
    int totalPointsReturning =
        stats.pointsWonReturning + stats.pointsLostReturning;

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
              height: 200,
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
                              stats.firstServIn, totalPointsReturning),
                          title: "1era Devol. In",
                          fraction:
                              "${stats.firstReturnIn}/$totalPointsReturning",
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.secondServIn,
                            totalPointsReturning,
                          ),
                          title: "2do Devol. In",
                          fraction:
                              "${stats.firstReturnIn}/$totalPointsReturning",
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.pointsWinnedFirstServ +
                                stats.pointsWinnedSecondServ,
                            totalPointsReturning,
                          ),
                          title: "Puntos ganados",
                          fraction:
                              "${stats.pointsWinnedFirstServ + stats.pointsWinnedSecondServ}/$totalPointsReturning",
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
              height: 200,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Text("Puntos ganados"),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.pointsWinnedFirstReturn,
                            totalPointsReturning,
                          ),
                          title: "1era Devolución",
                          fraction:
                              "${stats.pointsWinnedFirstReturn}/$totalPointsReturning",
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(
                            stats.pointsWinnedSecondReturn,
                            totalPointsReturning,
                          ),
                          title: "2da Devolución",
                          fraction:
                              "${stats.pointsWinnedSecondReturn}/$totalPointsReturning",
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
