import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/bar_chart.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class PartnerVsCharts extends StatelessWidget {
  const PartnerVsCharts({
    super.key,
    required this.match,
  });

  final MatchDto match;

  @override
  Widget build(BuildContext context) {
    TrackerDto tracker = match.tracker!;

    int myTotalServDone = tracker.me.firstServIn +
        tracker.me.secondServIn +
        tracker.me.dobleFaults;

    int partnerTotalServDone = tracker.partner!.firstServIn +
        tracker.partner!.secondServIn +
        tracker.partner!.dobleFaults;

    return Column(
      children: [
        BarChart(
          title: "1er Servicio In",
          percent: calculatePercent(tracker.me.firstServIn, myTotalServDone),
          rivalPercent: calculatePercent(
            tracker.partner!.firstServIn,
            partnerTotalServDone,
          ),
          division: "${tracker.me.firstServIn}/$myTotalServDone",
          rivalDivision:
              "${tracker.partner!.firstServIn}/$partnerTotalServDone",
          showPercent: true,
        ),
        BarChart(
          title: "Puntos ganados con el 1er servicio",
          percent: calculatePercent(
              tracker.me.pointsWinnedFirstServ, tracker.me.firstServIn),
          rivalPercent: calculatePercent(
            tracker.partner!.pointsWinnedFirstServ,
            tracker.partner!.firstServIn,
          ),
          division:
              "${tracker.me.pointsWinnedFirstServ}/${tracker.me.firstServIn}",
          rivalDivision:
              "${tracker.partner!.pointsWinnedFirstServ}/${tracker.partner!.firstServIn}",
          showPercent: true,
        ),
        BarChart(
          title: "Puntos ganados con el 2do servicio",
          percent: calculatePercent(
              tracker.me.pointsWinnedSecondServ, tracker.me.secondServIn),
          rivalPercent: calculatePercent(
            tracker.partner!.pointsWinnedSecondServ,
            tracker.partner!.secondServIn,
          ),
          division:
              "${tracker.me.pointsWinnedSecondServ}/${tracker.me.secondServIn}",
          rivalDivision:
              "${tracker.partner!.pointsWinnedSecondServ}/${tracker.partner!.secondServIn}",
          showPercent: true,
        ),
        BarChart(
          title: "Puntos en Malla",
          division:
              "${tracker.me.meshPointsWon}/${tracker.me.meshPointsWon + tracker.me.meshPointsLost}",
          rivalDivision:
              "${tracker.partner!.meshPointsWon}/${tracker.partner!.meshPointsWon + tracker.partner!.meshPointsLost}",
          percent: calculatePercent(tracker.me.meshPointsWon,
              tracker.me.meshPointsWon + tracker.me.meshPointsLost),
          rivalPercent: calculatePercent(
            tracker.partner!.meshPointsWon,
            tracker.partner!.meshPointsWon + tracker.partner!.meshPointsLost,
          ),
          showPercent: true,
        ),
        BarChart(
          title: "Puntos en fondo/approach",
          division:
              "${tracker.me.bckgPointsWon}/${tracker.me.bckgPointsWon + tracker.me.bckgPointsLost + tracker.me.winners}",
          rivalDivision:
              "${tracker.partner!.bckgPointsWon}/${tracker.partner!.bckgPointsWon + tracker.partner!.bckgPointsLost + tracker.partner!.winners}",
          percent: calculatePercent(
              tracker.me.bckgPointsWon,
              tracker.me.bckgPointsWon +
                  tracker.me.bckgPointsLost +
                  tracker.me.winners),
          rivalPercent: calculatePercent(
            tracker.partner!.bckgPointsWon,
            tracker.partner!.bckgPointsWon +
                tracker.partner!.bckgPointsLost +
                tracker.partner!.winners,
          ),
          showPercent: true,
        ),
        /*BarChart(
          title: "Aces",
          division: "${tracker.me.aces}",
          rivalDivision: "${tracker.partner!.aces}",
          barPercent: 50,
          rivalBarPercent: 23,
        ),
        BarChart(
          title: "Doble falta",
          division: "${tracker.me.dobleFaults}",
          rivalDivision: "${tracker.partner!.dobleFaults}",
          barPercent: 50,
          rivalBarPercent: 23,
        ),*/
      ],
    );
  }
}
