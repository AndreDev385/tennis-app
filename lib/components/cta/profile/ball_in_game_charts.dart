import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/profile/number_stat.dart';
import 'package:tennis_app/components/shared/vertical_barchart.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class ProfileBallInGameCharts extends StatelessWidget {
  const ProfileBallInGameCharts({
    super.key,
    required this.stats,
  });

  final PlayerTrackerDto stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
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
                            stats.meshPointsWon,
                            stats.meshPointsWon + stats.meshPointsLost,
                          ),
                          title: "Pts en malla",
                          fraction:
                              "${stats.meshPointsWon}/${stats.meshPointsWon + stats.meshPointsLost}",
                          type: 1,
                        ),
                        VerticalBarChart(
                          percent: calculatePercent(stats.bckgPointsWon,
                              stats.bckgPointsWon + stats.bckgPointsLost),
                          title: "Pts en fondo/approach",
                          fraction:
                              "${stats.bckgPointsWon}/${stats.bckgPointsWon + stats.bckgPointsLost}",
                          type: 2,
                        ),
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
              borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
            ),
            elevation: 5,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: NumberStat(
                            title: "Winners",
                            value: "${stats.winners}",
                          ),
                        ),
                        Expanded(
                          child: NumberStat(
                            title: "Errores no forzados",
                            value: "${stats.noForcedErrors}",
                          ),
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
