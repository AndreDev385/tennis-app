import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/bar_chart.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class PartnerVsCharts extends StatelessWidget {
  const PartnerVsCharts({
    super.key,
    required this.tracker,
    required this.name,
    required this.partnerName,
  });

  final TrackerDto tracker;
  final String name;
  final String partnerName;

  @override
  Widget build(BuildContext context) {
    // serv in
    int myTotalServDone = tracker.me.firstServIn +
        tracker.me.secondServIn +
        tracker.me.dobleFaults;
    int partnerTotalServDone = tracker.partner!.firstServIn +
        tracker.partner!.secondServIn +
        tracker.partner!.dobleFaults;

    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            children: <TableRow>[
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        partnerName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
          type: 0,
        ),
        BarChart(
          title: "Puntos ganados con el 1er servicio",
          percent: calculatePercent(
            tracker.me.pointsWinnedFirstServ,
            tracker.me.firstServIn,
          ),
          rivalPercent: calculatePercent(
            tracker.partner!.pointsWinnedFirstServ,
            tracker.partner!.firstServIn,
          ),
          division:
              "${tracker.me.pointsWinnedFirstServ}/${tracker.me.firstServIn}",
          rivalDivision:
              "${tracker.partner!.pointsWinnedFirstServ}/${tracker.partner!.firstServIn}",
          showPercent: true,
          type: 1,
        ),
        BarChart(
          title: "Puntos ganados con el 2do servicio",
          percent: calculatePercent(
            tracker.me.pointsWinnedSecondServ,
            tracker.me.secondServIn,
          ),
          rivalPercent: calculatePercent(
            tracker.partner!.pointsWinnedSecondServ,
            tracker.partner!.secondServIn,
          ),
          division:
              "${tracker.me.pointsWinnedSecondServ}/${tracker.me.secondServIn}",
          rivalDivision:
              "${tracker.partner!.pointsWinnedSecondServ}/${tracker.partner!.secondServIn}",
          showPercent: true,
          type: 2,
        ),
        BarChart(
          title: "Puntos en Malla",
          division:
              "${tracker.me.meshPointsWon}/${tracker.me.meshPointsWon + tracker.me.meshPointsLost}",
          rivalDivision:
              "${tracker.partner!.meshPointsWon}/${tracker.partner!.meshPointsWon + tracker.partner!.meshPointsLost}",
          percent: calculatePercent(
            tracker.me.meshPointsWon,
            tracker.me.meshPointsWon + tracker.me.meshPointsLost,
          ),
          rivalPercent: calculatePercent(
            tracker.partner!.meshPointsWon,
            tracker.partner!.meshPointsWon + tracker.partner!.meshPointsLost,
          ),
          showPercent: true,
          type: 0,
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
                tracker.me.winners,
          ),
          rivalPercent: calculatePercent(
            tracker.partner!.bckgPointsWon,
            tracker.partner!.bckgPointsWon +
                tracker.partner!.bckgPointsLost +
                tracker.partner!.winners,
          ),
          showPercent: true,
          type: 1,
        ),
        const Padding(padding: EdgeInsets.only(top: 72))
      ],
    );
  }
}
