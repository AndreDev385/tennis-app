import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/bar_chart.dart';
import 'package:tennis_app/components/cta/match/number_square.dart';
import 'package:tennis_app/domain/tournament/participant_tracker.dart';
import 'package:tennis_app/domain/tournament/tournament_match_stats.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

List<Widget> buildTournamentGraphs(
  TournamentMatchStats stats,
  String firstName,
  String secondName,
) {
  int t1ServicesDone =
      stats.t1FirstServIn + stats.t1SecondServIn + stats.t1DoubleFaults;
  int t2ServicesDone =
      stats.t2FirstServIn + stats.t2SecondServIn + stats.t2DoubleFaults;

  return [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        border: const TableBorder(
          horizontalInside: BorderSide(width: .5, color: Colors.grey),
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
        columnWidths: const <int, TableColumnWidth>{
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    firstName,
                    style: TextStyle(
                      fontSize: MyTheme.smallTextSize,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    secondName,
                    style: TextStyle(
                      fontSize: MyTheme.smallTextSize,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
    BarChart(
      title: "1er Servicio In",
      percent1: calculatePercent(stats.t1FirstServIn, t1ServicesDone),
      percent2: calculatePercent(
        stats.t2FirstServIn,
        t2ServicesDone,
      ),
      division1: "${stats.t1FirstServIn}/$t1ServicesDone",
      division2: "${stats.t2FirstServIn}/$t2ServicesDone",
      showPercent: true,
      type: 0,
    ),
    BarChart(
      title: "Puntos ganados con el 1er Servicio",
      percent1: calculatePercent(
        stats.t1PointsWinnedFirstServ,
        stats.t2PointsWinnedFirstServ,
      ),
      percent2: calculatePercent(
        stats.t1PointsWinnedFirstServ,
        stats.t2FirstServIn,
      ),
      division1: "${stats.t1PointsWinnedFirstServ}/${stats.t1FirstServIn}",
      division2: "${stats.t2PointsWinnedFirstServ}/${stats.t2FirstServIn}",
      showPercent: true,
      type: 1,
    ),
    BarChart(
      title: "Puntos ganados con el 2do servicio",
      percent1: calculatePercent(
        stats.t1PointsWinnedSecondServ,
        stats.t1SecondServIn,
      ),
      percent2: calculatePercent(
        stats.t2PointsWinnedSecondServ,
        stats.t2SecondServIn,
      ),
      division1: "${stats.t1PointsWinnedSecondServ}/${stats.t1SecondServIn}",
      division2: "${stats.t2PointsWinnedSecondServ}/${stats.t2SecondServIn}",
      showPercent: true,
      type: 2,
    ),
    NumberSquare(
      title: "Break points",
      value1: "${stats.t1BreakPts}/${stats.t1BreakPtsChances}",
      value2: "${stats.t2BreakPts}/${stats.t2BreakPtsChances}",
    ),
    NumberSquare(
      title: "Aces",
      value1: "${stats.t1Aces}",
      value2: "${stats.t2Aces}",
    ),
    NumberSquare(
      title: "Doble falta",
      value1: "${stats.t1DoubleFaults}",
      value2: "${stats.t2DoubleFaults}",
    ),
    Padding(padding: EdgeInsets.only(bottom: 64))
  ];
}

List<Widget> buildTournamentPartnersGraphs(
  ParticipantStats p1,
  ParticipantStats p2,
  String p1Name,
  String p2Name,
) {
  int p1ServicesDone = p1.firstServIn + p1.secondServIn + p1.dobleFaults;
  int p2ServicesDone = p2.firstServIn + p2.secondServIn + p2.dobleFaults;

  return [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        border: const TableBorder(
          horizontalInside: BorderSide(width: .5, color: Colors.grey),
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
        columnWidths: const <int, TableColumnWidth>{
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    p1Name,
                    style: TextStyle(
                      fontSize: MyTheme.smallTextSize,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                    p2Name,
                    style: TextStyle(
                      fontSize: MyTheme.smallTextSize,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
    BarChart(
      title: "1er Servicio In",
      percent1: calculatePercent(p1.firstServIn, p1ServicesDone),
      percent2: calculatePercent(p2.firstServIn, p2ServicesDone),
      division1: "${p1.firstServIn}/$p1ServicesDone",
      division2: "${p2.firstServIn}/$p2ServicesDone",
      showPercent: true,
      type: 0,
    ),
    BarChart(
      title: "Puntos ganados con el 1er Servicio",
      percent1: calculatePercent(
        p1.pointsWinnedFirstServ,
        p1.firstServIn,
      ),
      percent2: calculatePercent(
        p2.pointsWinnedFirstServ,
        p2.firstServIn,
      ),
      division1: "${p1.pointsWinnedFirstServ}/${p1.firstServIn}",
      division2: "${p2.pointsWinnedFirstServ}/${p2.firstServIn}",
      showPercent: true,
      type: 1,
    ),
    BarChart(
      title: "Puntos ganados con el 2do servicio",
      percent1: calculatePercent(
        p1.pointsWinnedSecondServ,
        p1.secondServIn,
      ),
      percent2: calculatePercent(
        p2.pointsWinnedSecondServ,
        p2.secondServIn,
      ),
      division1: "${p1.pointsWinnedSecondServ}/${p1.secondServIn}",
      division2: "${p2.pointsWinnedSecondServ}/${p2.secondServIn}",
      showPercent: true,
      type: 2,
    ),
    NumberSquare(
      title: "Break points salvados",
      value1: "${p1.breakPtsSaved}/${p1.saveBreakPtsChances}",
      value2: "${p2.breakPtsSaved}/${p2.saveBreakPtsChances}",
    ),
    NumberSquare(
      title: "Aces",
      value1: "${p1.aces}",
      value2: "${p2.aces}",
    ),
    NumberSquare(
      title: "Doble falta",
      value1: "${p1.dobleFaults}",
      value2: "${p2.dobleFaults}",
    ),
    Padding(padding: EdgeInsets.only(bottom: 64))
  ];
}
