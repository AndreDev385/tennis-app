import 'package:tennis_app/components/shared/stats_table.dart';
import 'package:tennis_app/domain/tournament/participant_tracker.dart';
import 'package:tennis_app/domain/tournament/tournament_match_stats.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

List<Section> buildTournamentTableStats(
  TournamentMatchStats stats,
) {
  int t1ServicesDone =
      stats.t1FirstServIn + stats.t1SecondServIn + stats.t1DoubleFaults;
  int t2ServicesDone =
      stats.t2FirstServIn + stats.t2SecondServIn + stats.t2DoubleFaults;

  return [
    Section(title: "Servicio", stats: [
      Stat(
        name: "Aces",
        firstValue: "${stats.t1Aces}",
        secondValue: "${stats.t2Aces}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Doble faltas",
        firstValue: "${stats.t1DoubleFaults}",
        secondValue: "${stats.t2DoubleFaults}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "1er servicio in",
        firstValue:
            "${stats.t1FirstServIn}/${t1ServicesDone} (${calculatePercent(stats.t1FirstServIn, t1ServicesDone)}%)",
        secondValue:
            "${stats.t2FirstServIn}/${t2ServicesDone} (${calculatePercent(stats.t2FirstServIn, t2ServicesDone)}%)",
        percentage1: calculatePercent(stats.t1FirstServIn, t1ServicesDone),
        percentage2: calculatePercent(stats.t2FirstServIn, t2ServicesDone),
      ),
      Stat(
        name: "1er saque ganador",
        firstValue: "${stats.t1FirstServWon}",
        secondValue: "${stats.t2FirstServWon}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados con el 1er servicio",
        firstValue:
            "${stats.t1PointsWinnedFirstServ}/${stats.t1FirstServIn} (${calculatePercent(stats.t1PointsWinnedFirstServ, stats.t1FirstServIn)}%)",
        secondValue:
            "${stats.t2PointsWinnedFirstServ}/${stats.t2FirstServIn} (${calculatePercent(stats.t2PointsWinnedFirstServ, stats.t2FirstServIn)}%)",
        percentage1: calculatePercent(
            stats.t1PointsWinnedFirstServ, stats.t1FirstServIn),
        percentage2: calculatePercent(
            stats.t2PointsWinnedFirstServ, stats.t2FirstServIn),
      ),
      Stat(
        name: "2do servicio in",
        firstValue:
            "${stats.t1SecondServIn}/${stats.t1SecondServIn + stats.t1DoubleFaults} (${calculatePercent(stats.t1SecondServIn, stats.t1SecondServIn + stats.t1DoubleFaults)}%)",
        secondValue:
            "${stats.t2SecondServIn}/${stats.t2SecondServIn + stats.t2DoubleFaults} (${calculatePercent(stats.t2SecondServIn, stats.t2SecondServIn + stats.t2DoubleFaults)}%)",
        percentage1: calculatePercent(
            stats.t1SecondServIn, stats.t1SecondServIn + stats.t1DoubleFaults),
        percentage2: calculatePercent(
            stats.t2SecondServIn, stats.t2SecondServIn + stats.t2DoubleFaults),
      ),
      Stat(
        name: "2do saque ganador",
        firstValue: "${stats.t1SecondServWon}",
        secondValue: "${stats.t2SecondServWon}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados con el 2do servicio",
        firstValue:
            "${stats.t1PointsWinnedSecondServ}/${stats.t1SecondServIn} (${calculatePercent(stats.t1PointsWinnedSecondServ, stats.t1SecondServIn)}%)",
        secondValue:
            "${stats.t2PointsWinnedSecondServ}/${stats.t2SecondServIn} (${calculatePercent(stats.t2PointsWinnedSecondServ, stats.t2SecondServIn)}%)",
        percentage1: calculatePercent(
            stats.t1PointsWinnedSecondServ, stats.t1SecondServIn),
        percentage2: calculatePercent(
            stats.t2PointsWinnedSecondServ, stats.t2SecondServIn),
      ),
      Stat(
        name: "Break points salvados",
        firstValue: "${stats.t1BreakPtsSaved}/${stats.t1SaveBreakPtsChances}",
        secondValue: "${stats.t2BreakPtsSaved}/${stats.t2SaveBreakPtsChances}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Games ganados con el servicio",
        firstValue:
            "${stats.t1GamesWonServing}/${stats.t1GamesWonServing + stats.t1GamesLostServing}",
        secondValue:
            "${stats.t2GamesWonServing}/${stats.t2GamesWonServing + stats.t2GamesLostServing}",
        percentage1: null,
        percentage2: null,
      ),
    ]),
    Section(title: "Devolución", stats: [
      Stat(
        name: "1era devolución in",
        firstValue:
            "${stats.t1FirstReturnIn}/${stats.t1FirstReturnIn + stats.t1FirstReturnOut} (${calculatePercent(stats.t1FirstReturnIn, stats.t1FirstReturnIn + stats.t1FirstReturnOut)}%)",
        secondValue:
            "${stats.t2FirstReturnIn}/${stats.t2FirstReturnIn + stats.t2FirstReturnOut} (${calculatePercent(stats.t2FirstReturnIn, stats.t2FirstReturnIn + stats.t2FirstReturnOut)}%)",
        percentage1: calculatePercent(stats.t1FirstReturnIn,
            stats.t1FirstReturnIn + stats.t1FirstReturnOut),
        percentage2: calculatePercent(stats.t2FirstReturnIn,
            stats.t2FirstReturnIn + stats.t2FirstReturnOut),
      ),
      Stat(
        name: "1era devolución ganadora",
        firstValue: "${stats.t1FirstReturnWon}",
        secondValue: "${stats.t2FirstReturnWon}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Winner con 1era devolución",
        firstValue: "${stats.t1FirstReturnWinner}",
        secondValue: "${stats.t2FirstReturnWinner}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados con la 1era devolución",
        firstValue:
            "${stats.t1PointsWinnedFirstReturn}/${stats.t1FirstReturnIn + stats.t1FirstReturnOut} (${calculatePercent(stats.t1PointsWinnedFirstReturn, stats.t1FirstReturnIn + stats.t1FirstReturnOut)}%)",
        secondValue:
            "${stats.t2PointsWinnedFirstReturn}/${stats.t2FirstReturnIn + stats.t2FirstReturnOut} (${calculatePercent(stats.t2PointsWinnedFirstReturn, stats.t2FirstReturnIn + stats.t2FirstReturnOut)}%)",
        percentage1: calculatePercent(stats.t1PointsWinnedFirstReturn,
            stats.t1FirstReturnIn + stats.t1FirstReturnOut),
        percentage2: calculatePercent(stats.t2PointsWinnedFirstReturn,
            stats.t2FirstReturnIn + stats.t2FirstReturnOut),
      ),
      Stat(
        name: "2da devolución in",
        firstValue:
            "${stats.t1SecondReturnIn}/${stats.t1SecondReturnIn + stats.t1SecondReturnOut} (${calculatePercent(stats.t1SecondReturnIn, stats.t1SecondReturnIn + stats.t1SecondReturnOut)}%)",
        secondValue:
            "${stats.t2SecondReturnIn}/${stats.t2SecondReturnIn + stats.t2SecondReturnOut} (${calculatePercent(stats.t2SecondReturnIn, stats.t2SecondReturnIn + stats.t2SecondReturnOut)}%)",
        percentage1: calculatePercent(stats.t1SecondReturnIn,
            stats.t1SecondReturnIn + stats.t1SecondReturnOut),
        percentage2: calculatePercent(stats.t2SecondReturnIn,
            stats.t2SecondReturnIn + stats.t2SecondReturnOut),
      ),
      Stat(
        name: "2da devolución ganadora",
        firstValue: "${stats.t1SecondReturnWon}",
        secondValue: "${stats.t2SecondReturnWon}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Winner con 2da devolución",
        firstValue: "${stats.t1SecondReturnWinner}",
        secondValue: "${stats.t2SecondReturnWinner}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados con la 2da devolución",
        firstValue:
            "${stats.t1PointsWinnedSecondReturn}/${stats.t1SecondReturnIn + stats.t1SecondReturnOut} (${calculatePercent(stats.t1PointsWinnedSecondReturn, stats.t1SecondReturnIn + stats.t1SecondReturnOut)}%)",
        secondValue:
            "${stats.t2PointsWinnedSecondReturn}/${stats.t2SecondReturnIn + stats.t2SecondReturnOut} (${calculatePercent(stats.t2PointsWinnedSecondReturn, stats.t2SecondReturnIn + stats.t2SecondReturnOut)}%)",
        percentage1: calculatePercent(stats.t1PointsWinnedSecondReturn,
            stats.t1SecondReturnIn + stats.t1SecondReturnOut),
        percentage2: calculatePercent(stats.t2PointsWinnedSecondReturn,
            stats.t2SecondReturnIn + stats.t2SecondReturnOut),
      ),
      Stat(
        name: "Break point",
        firstValue: "${stats.t1BreakPts}/${stats.t1BreakPtsChances}",
        secondValue: "${stats.t2BreakPts}/${stats.t2BreakPtsChances}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Games ganados devolviendo",
        firstValue:
            "${stats.t1GamesWonReturning}/${stats.t1GamesWonReturning + stats.t1GamesLostReturning}",
        secondValue:
            "${stats.t2GamesWonReturning}/${stats.t2GamesWonReturning + stats.t2GamesLostReturning}",
        percentage1: null,
        percentage2: null,
      ),
    ]),
    Section(title: "Pelota en Juego", stats: [
      Stat(
        name: "Puntos ganados en malla",
        firstValue:
            "${stats.t1MeshPointsWon}/${stats.t1MeshPointsWon + stats.t1MeshPointsLost} (${calculatePercent(stats.t1MeshPointsWon, stats.t1MeshPointsWon + stats.t1MeshPointsLost)}%)",
        secondValue:
            "${stats.t2MeshPointsWon}/${stats.t2MeshPointsWon + stats.t2MeshPointsLost} (${calculatePercent(stats.t2MeshPointsWon, stats.t2MeshPointsWon + stats.t2MeshPointsLost)}%)",
        percentage1: calculatePercent(stats.t1MeshPointsWon,
            stats.t1MeshPointsWon + stats.t1MeshPointsLost),
        percentage2: calculatePercent(stats.t2MeshPointsWon,
            stats.t2MeshPointsWon + stats.t2MeshPointsLost),
      ),
      Stat(
        name: "Winners en malla",
        firstValue: "${stats.t1MeshWinners}",
        secondValue: "${stats.t2MeshWinners}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Errores en malla",
        firstValue: "${stats.t1MeshError}",
        secondValue: "${stats.t2MeshError}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados en fondo/approach",
        firstValue:
            "${stats.t1BckgPointsWon}/${stats.t1BckgPointsWon + stats.t1BckgPointsLost} (${calculatePercent(stats.t1BckgPointsWon, stats.t1BckgPointsWon + stats.t1BckgPointsLost)}%)",
        secondValue:
            "${stats.t2BckgPointsWon}/${stats.t2BckgPointsWon + stats.t2BckgPointsLost} (${calculatePercent(stats.t2BckgPointsWon, stats.t2BckgPointsWon + stats.t2BckgPointsLost)}%)",
        percentage1: calculatePercent(stats.t1BckgPointsWon,
            stats.t1BckgPointsWon + stats.t1BckgPointsLost),
        percentage2: calculatePercent(stats.t2BckgPointsWon,
            stats.t2BckgPointsWon + stats.t2BckgPointsLost),
      ),
      Stat(
        name: "Winners en fondo/approach",
        firstValue: "${stats.t1BckgWinner}",
        secondValue: "${stats.t2BckgWinner}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Errores en fondo/approach",
        firstValue: "${stats.t1BckgError}",
        secondValue: "${stats.t2BckgError}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Total winner",
        firstValue:
            "${stats.t1MeshWinners + stats.t1BckgWinner + stats.t1FirstReturnWinner + stats.t1SecondReturnWinner + stats.t1Aces}",
        secondValue:
            "${stats.t2MeshWinners + stats.t2BckgWinner + stats.t2FirstReturnWinner + stats.t2SecondReturnWinner + stats.t2Aces}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Total errores no forzados",
        firstValue:
            "${stats.t1MeshError + stats.t1BckgError + stats.t1DoubleFaults}",
        secondValue:
            "${stats.t2MeshError + stats.t2BckgError + stats.t2DoubleFaults}",
        percentage1: null,
        percentage2: null,
      ),
    ]),
    Section(title: "Puntos", stats: [
      Stat(
        name: "Puntos cortos ganados",
        firstValue:
            "${stats.t1ShortRallyWon}/${stats.t1ShortRallyWon + stats.t1ShortRallyLost} (${calculatePercent(stats.t1ShortRallyWon, stats.t1ShortRallyWon + stats.t1ShortRallyLost)}%)",
        secondValue:
            "${stats.t2ShortRallyWon}/${stats.t2ShortRallyWon + stats.t2ShortRallyLost} (${calculatePercent(stats.t2ShortRallyWon, stats.t2ShortRallyWon + stats.t2ShortRallyLost)}%)",
        percentage1: calculatePercent(stats.t1ShortRallyWon,
            stats.t1ShortRallyWon + stats.t1ShortRallyLost),
        percentage2: calculatePercent(stats.t2ShortRallyWon,
            stats.t2ShortRallyWon + stats.t2ShortRallyLost),
      ),
      Stat(
        name: "Puntos medianos ganados",
        firstValue:
            "${stats.t1MediumRallyWon}/${stats.t1MediumRallyWon + stats.t1MediumRallyLost} (${calculatePercent(stats.t1MediumRallyWon, stats.t1MediumRallyWon + stats.t1MediumRallyLost)}%)",
        secondValue:
            "${stats.t2MediumRallyWon}/${stats.t2MediumRallyWon + stats.t2MediumRallyLost} (${calculatePercent(stats.t2MediumRallyWon, stats.t2MediumRallyWon + stats.t2MediumRallyLost)}%)",
        percentage1: calculatePercent(stats.t1MediumRallyWon,
            stats.t1MediumRallyWon + stats.t1MediumRallyLost),
        percentage2: calculatePercent(stats.t2MediumRallyWon,
            stats.t2MediumRallyWon + stats.t2MediumRallyLost),
      ),
      Stat(
        name: "Puntos largos ganados",
        firstValue:
            "${stats.t1LongRallyWon}/${stats.t1LongRallyWon + stats.t1LongRallyLost} (${calculatePercent(stats.t1LongRallyWon, stats.t1LongRallyWon + stats.t1LongRallyLost)}%)",
        secondValue:
            "${stats.t2LongRallyWon}/${stats.t2LongRallyWon + stats.t2LongRallyLost} (${calculatePercent(stats.t2LongRallyWon, stats.t2LongRallyWon + stats.t2LongRallyLost)}%)",
        percentage1: calculatePercent(
            stats.t1LongRallyWon, stats.t1LongRallyWon + stats.t1LongRallyLost),
        percentage2: calculatePercent(
            stats.t2LongRallyWon, stats.t2LongRallyWon + stats.t2LongRallyLost),
      ),
    ])
  ];
}

List<Section> buildTournamentPartnersTableStats(
  ParticipantStats p1,
  ParticipantStats p2,
) {
  int p1ServicesDone = p1.firstServIn + p1.secondServIn + p1.dobleFaults;
  int p2ServicesDone = p2.firstServIn + p2.secondServIn + p2.dobleFaults;

  return [
    Section(title: "Servicio", stats: [
      Stat(
        name: "Aces",
        firstValue: "${p1.aces}",
        secondValue: "${p2.aces}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Doble faltas",
        firstValue: "${p1.dobleFaults}",
        secondValue: "${p2.dobleFaults}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "1er servicio in",
        firstValue:
            "${p1.firstServIn}/${p1ServicesDone} (${calculatePercent(p1.firstServIn, p1ServicesDone)}%)",
        secondValue:
            "${p2.firstServIn}/${p2ServicesDone} (${calculatePercent(p2.firstServIn, p2ServicesDone)}%)",
        percentage1: calculatePercent(p1.firstServIn, p1ServicesDone),
        percentage2: calculatePercent(p2.firstServIn, p2ServicesDone),
      ),
      Stat(
        name: "1er saque ganador",
        firstValue: "${p1.firstServWon}",
        secondValue: "${p2.firstServWon}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados con el 1er servicio",
        firstValue:
            "${p1.pointsWinnedFirstServ}/${p1.firstServIn} (${calculatePercent(p1.pointsWinnedFirstServ, p1.firstServIn)}%)",
        secondValue:
            "${p2.pointsWinnedFirstServ}/${p2.firstServIn} (${calculatePercent(p2.pointsWinnedFirstServ, p2.firstServIn)}%)",
        percentage1: calculatePercent(p1.pointsWinnedFirstServ, p1.firstServIn),
        percentage2: calculatePercent(p2.pointsWinnedFirstServ, p2.firstServIn),
      ),
      Stat(
        name: "2do servicio in",
        firstValue:
            "${p1.secondServIn}/${p1.secondServIn + p1.dobleFaults} (${calculatePercent(p1.secondServIn, p1.secondServIn + p1.dobleFaults)}%)",
        secondValue:
            "${p2.secondServIn}/${p2.secondServIn + p2.dobleFaults} (${calculatePercent(p2.secondServIn, p2.secondServIn + p2.dobleFaults)}%)",
        percentage1:
            calculatePercent(p1.secondServIn, p1.secondServIn + p1.dobleFaults),
        percentage2:
            calculatePercent(p2.secondServIn, p2.secondServIn + p2.dobleFaults),
      ),
      Stat(
        name: "2do saque ganador",
        firstValue: "${p1.secondServWon}",
        secondValue: "${p2.secondServWon}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados con el 2do servicio",
        firstValue:
            "${p1.pointsWinnedSecondServ}/${p1.secondServIn} (${calculatePercent(p1.pointsWinnedSecondServ, p1.secondServIn)}%)",
        secondValue:
            "${p2.pointsWinnedSecondServ}/${p2.secondServIn} (${calculatePercent(p2.pointsWinnedSecondServ, p2.secondServIn)}%)",
        percentage1:
            calculatePercent(p1.pointsWinnedSecondServ, p1.secondServIn),
        percentage2:
            calculatePercent(p2.pointsWinnedSecondServ, p2.secondServIn),
      ),
      Stat(
        name: "Break points salvados",
        firstValue: "${p1.breakPtsSaved}/${p1.saveBreakPtsChances}",
        secondValue: "${p2.breakPtsSaved}/${p2.saveBreakPtsChances}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Games ganados con el servicio",
        firstValue:
            "${p1.gamesWonServing}/${p1.gamesWonServing + p1.gamesLostServing}",
        secondValue:
            "${p2.gamesWonServing}/${p2.gamesWonServing + p2.gamesLostServing}",
        percentage1: null,
        percentage2: null,
      ),
    ]),
    Section(title: "Devolución", stats: [
      Stat(
        name: "1era devolución in",
        firstValue:
            "${p1.firstReturnIn}/${p1.firstReturnIn + p1.firstReturnOut} (${calculatePercent(p1.firstReturnIn, p1.firstReturnIn + p1.firstReturnOut)}%)",
        secondValue:
            "${p2.firstReturnIn}/${p2.firstReturnIn + p2.firstReturnOut} (${calculatePercent(p2.firstReturnIn, p2.firstReturnIn + p2.firstReturnOut)}%)",
        percentage1: calculatePercent(
            p1.firstReturnIn, p1.firstReturnIn + p1.firstReturnOut),
        percentage2: calculatePercent(
            p2.firstReturnIn, p2.firstReturnIn + p2.firstReturnOut),
      ),
      Stat(
        name: "1era devolución ganadora",
        firstValue: "${p1.firstReturnWon}",
        secondValue: "${p2.firstReturnWon}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Winner con 1era devolución",
        firstValue: "${p1.firstReturnWinner}",
        secondValue: "${p2.firstReturnWinner}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados con la 1era devolución",
        firstValue:
            "${p1.pointsWinnedFirstReturn}/${p1.firstReturnIn + p1.firstReturnOut} (${calculatePercent(p1.pointsWinnedFirstReturn, p1.firstReturnIn + p1.firstReturnOut)}%)",
        secondValue:
            "${p2.pointsWinnedFirstReturn}/${p2.firstReturnIn + p2.firstReturnOut} (${calculatePercent(p2.pointsWinnedFirstReturn, p2.firstReturnIn + p2.firstReturnOut)}%)",
        percentage1: calculatePercent(
            p1.pointsWinnedFirstReturn, p1.firstReturnIn + p1.firstReturnOut),
        percentage2: calculatePercent(
            p2.pointsWinnedFirstReturn, p2.firstReturnIn + p2.firstReturnOut),
      ),
      Stat(
        name: "2da devolución in",
        firstValue:
            "${p1.secondReturnIn}/${p1.secondReturnIn + p1.secondReturnOut} (${calculatePercent(p1.secondReturnIn, p1.secondReturnIn + p1.secondReturnOut)}%)",
        secondValue:
            "${p2.secondReturnIn}/${p2.secondReturnIn + p2.secondReturnOut} (${calculatePercent(p2.secondReturnIn, p2.secondReturnIn + p2.secondReturnOut)}%)",
        percentage1: calculatePercent(
            p1.secondReturnIn, p1.secondReturnIn + p1.secondReturnOut),
        percentage2: calculatePercent(
            p2.secondReturnIn, p2.secondReturnIn + p2.secondReturnOut),
      ),
      Stat(
        name: "2da devolución ganadora",
        firstValue: "${p1.secondReturnWon}",
        secondValue: "${p2.secondReturnWon}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Winner con 2da devolución",
        firstValue: "${p1.secondReturnWinner}",
        secondValue: "${p2.secondReturnWinner}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados con la 2da devolución",
        firstValue:
            "${p1.pointsWinnedSecondReturn}/${p1.secondReturnIn + p1.secondReturnOut} (${calculatePercent(p1.pointsWinnedSecondReturn, p1.secondReturnIn + p1.secondReturnOut)}%)",
        secondValue:
            "${p2.pointsWinnedSecondReturn}/${p2.secondReturnIn + p2.secondReturnOut} (${calculatePercent(p2.pointsWinnedSecondReturn, p2.secondReturnIn + p2.secondReturnOut)}%)",
        percentage1: calculatePercent(p1.pointsWinnedSecondReturn,
            p1.secondReturnIn + p1.secondReturnOut),
        percentage2: calculatePercent(p2.pointsWinnedSecondReturn,
            p2.secondReturnIn + p2.secondReturnOut),
      ),
      Stat(
        name: "Break point",
        firstValue: "${p1.breakPts}/${p1.breakPtsChances}",
        secondValue: "${p2.breakPts}/${p2.breakPtsChances}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Games ganados devolviendo",
        firstValue:
            "${p1.gamesWonReturning}/${p1.gamesWonReturning + p1.gamesLostReturning}",
        secondValue:
            "${p2.gamesWonReturning}/${p2.gamesWonReturning + p2.gamesLostReturning}",
        percentage1: null,
        percentage2: null,
      ),
    ]),
    Section(title: "Pelota en Juego", stats: [
      Stat(
        name: "Puntos ganados en malla",
        firstValue:
            "${p1.meshPointsWon}/${p1.meshPointsWon + p1.meshPointsLost} (${calculatePercent(p1.meshPointsWon, p1.meshPointsWon + p1.meshPointsLost)}%)",
        secondValue:
            "${p2.meshPointsWon}/${p2.meshPointsWon + p2.meshPointsLost} (${calculatePercent(p2.meshPointsWon, p2.meshPointsWon + p2.meshPointsLost)}%)",
        percentage1: calculatePercent(
            p1.meshPointsWon, p1.meshPointsWon + p1.meshPointsLost),
        percentage2: calculatePercent(
            p2.meshPointsWon, p2.meshPointsWon + p2.meshPointsLost),
      ),
      Stat(
        name: "Winners en malla",
        firstValue: "${p1.meshWinner}",
        secondValue: "${p2.meshWinner}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Errores en malla",
        firstValue: "${p1.meshError}",
        secondValue: "${p2.meshError}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Puntos ganados en fondo/approach",
        firstValue:
            "${p1.bckgPointsWon}/${p1.bckgPointsWon + p1.bckgPointsLost} (${calculatePercent(p1.bckgPointsWon, p1.bckgPointsWon + p1.bckgPointsLost)}%)",
        secondValue:
            "${p2.bckgPointsWon}/${p2.bckgPointsWon + p2.bckgPointsLost} (${calculatePercent(p2.bckgPointsWon, p2.bckgPointsWon + p2.bckgPointsLost)}%)",
        percentage1: calculatePercent(
            p1.bckgPointsWon, p1.bckgPointsWon + p1.bckgPointsLost),
        percentage2: calculatePercent(
            p2.bckgPointsWon, p2.bckgPointsWon + p2.bckgPointsLost),
      ),
      Stat(
        name: "Winners en fondo/approach",
        firstValue: "${p1.bckgWinner}",
        secondValue: "${p2.bckgWinner}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Errores en fondo/approach",
        firstValue: "${p1.bckgError}",
        secondValue: "${p2.bckgError}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Total winner",
        firstValue:
            "${p1.meshWinner + p1.bckgWinner + p1.firstReturnWinner + p1.secondReturnWinner + p1.aces}",
        secondValue:
            "${p2.meshWinner + p2.bckgWinner + p2.firstReturnWinner + p2.secondReturnWinner + p2.aces}",
        percentage1: null,
        percentage2: null,
      ),
      Stat(
        name: "Total errores no forzados",
        firstValue: "${p1.meshError + p1.bckgError + p1.dobleFaults}",
        secondValue: "${p2.meshError + p2.bckgError + p2.dobleFaults}",
        percentage1: null,
        percentage2: null,
      ),
    ]),
    Section(title: "Puntos", stats: [
      Stat(
        name: "Puntos cortos ganados",
        firstValue:
            "${p1.shortRallyWon}/${p1.shortRallyWon + p1.shortRallyLost} (${calculatePercent(p1.shortRallyWon, p1.shortRallyWon + p1.shortRallyLost)}%)",
        secondValue:
            "${p2.shortRallyWon}/${p2.shortRallyWon + p2.shortRallyLost} (${calculatePercent(p2.shortRallyWon, p2.shortRallyWon + p2.shortRallyLost)}%)",
        percentage1: calculatePercent(
            p1.shortRallyWon, p1.shortRallyWon + p1.shortRallyLost),
        percentage2: calculatePercent(
            p2.shortRallyWon, p2.shortRallyWon + p2.shortRallyLost),
      ),
      Stat(
        name: "Puntos medianos ganados",
        firstValue:
            "${p1.mediumRallyWon}/${p1.mediumRallyWon + p1.mediumRallyLost} (${calculatePercent(p1.mediumRallyWon, p1.mediumRallyWon + p1.mediumRallyLost)}%)",
        secondValue:
            "${p2.mediumRallyWon}/${p2.mediumRallyWon + p2.mediumRallyLost} (${calculatePercent(p2.mediumRallyWon, p2.mediumRallyWon + p2.mediumRallyLost)}%)",
        percentage1: calculatePercent(
            p1.mediumRallyWon, p1.mediumRallyWon + p1.mediumRallyLost),
        percentage2: calculatePercent(
            p2.mediumRallyWon, p2.mediumRallyWon + p2.mediumRallyLost),
      ),
      Stat(
        name: "Puntos largos ganados",
        firstValue:
            "${p1.longRallyWon}/${p1.longRallyWon + p1.longRallyLost} (${calculatePercent(p1.longRallyWon, p1.longRallyWon + p1.longRallyLost)}%)",
        secondValue:
            "${p2.longRallyWon}/${p2.longRallyWon + p2.longRallyLost} (${calculatePercent(p2.longRallyWon, p2.longRallyWon + p2.longRallyLost)}%)",
        percentage1: calculatePercent(
            p1.longRallyWon, p1.longRallyWon + p1.longRallyLost),
        percentage2: calculatePercent(
            p2.longRallyWon, p2.longRallyWon + p2.longRallyLost),
      ),
    ])
  ];
}
