import 'package:tennis_app/components/shared/stats_table.dart';
import 'package:tennis_app/domain/tournament/tournament_match_stats.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

List<Section> buildTournamentTableStats(TournamentMatchStats stats) {
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
      ),
      Stat(
        name: "Doble faltas",
        firstValue: "${stats.t1DoubleFaults}",
        secondValue: "${stats.t2DoubleFaults}",
      ),
      Stat(
        name: "1er servicio in",
        firstValue:
            "${stats.t1FirstServIn}/${t1ServicesDone} (${calculatePercent(stats.t1FirstServIn, t1ServicesDone)}%)",
        secondValue:
            "${stats.t2FirstServIn}/${t2ServicesDone} (${calculatePercent(stats.t2FirstServIn, t2ServicesDone)}%)",
      ),
      Stat(
        name: "1er saque ganador",
        firstValue: "${stats.t1FirstServWon}",
        secondValue: "${stats.t2FirstServWon}",
      ),
      Stat(
        name: "Puntos ganados con el 1er servicio",
        firstValue:
            "${stats.t1PointsWinnedFirstServ}/${stats.t1FirstServIn} (${calculatePercent(stats.t1PointsWinnedFirstServ, stats.t1FirstServIn)}%)",
        secondValue:
            "${stats.t2PointsWinnedFirstServ}/${stats.t2FirstServIn} (${calculatePercent(stats.t2PointsWinnedFirstServ, stats.t2FirstServIn)}%)",
      ),
      Stat(
        name: "2do servicio in",
        firstValue:
            "${stats.t1SecondServIn}/${stats.t1SecondServIn + stats.t1DoubleFaults} (${calculatePercent(stats.t1SecondServIn, stats.t1SecondServIn + stats.t1DoubleFaults)}%)",
        secondValue:
            "${stats.t2SecondServIn}/${stats.t2SecondServIn + stats.t2DoubleFaults} (${calculatePercent(stats.t2SecondServIn, stats.t2SecondServIn + stats.t2DoubleFaults)}%)",
      ),
      Stat(
        name: "2do saque ganador",
        firstValue: "${stats.t1SecondServWon}",
        secondValue: "${stats.t2SecondServWon}",
      ),
      Stat(
        name: "Puntos ganados con el 2do servicio",
        firstValue:
            "${stats.t1PointsWinnedSecondServ}/${stats.t1SecondServIn} (${calculatePercent(stats.t1PointsWinnedSecondServ, stats.t1SecondServIn)}%)",
        secondValue:
            "${stats.t2PointsWinnedSecondServ}/${stats.t2SecondServIn} (${calculatePercent(stats.t2PointsWinnedSecondServ, stats.t2SecondServIn)}%)",
      ),
      Stat(
        name: "Games ganados con el servicio",
        firstValue:
            "${stats.t1GamesWonServing}/${stats.t1GamesWonServing + stats.t1GamesLostServing}",
        secondValue:
            "${stats.t2GamesWonServing}/${stats.t2GamesWonServing + stats.t2GamesLostServing}",
      ),
    ]),
    Section(title: "Devolución", stats: [
      Stat(
        name: "1era Devolución in",
        firstValue:
            "${stats.t1FirstReturnIn}/${stats.t1FirstReturnIn + stats.t1FirstReturnOut} (${calculatePercent(stats.t1FirstReturnIn, stats.t1FirstReturnIn + stats.t1FirstReturnOut)}%)",
        secondValue:
            "${stats.t2FirstReturnIn}/${stats.t2FirstReturnIn + stats.t2FirstReturnOut} (${calculatePercent(stats.t2FirstReturnIn, stats.t2FirstReturnIn + stats.t2FirstReturnOut)}%)",
      ),
      Stat(
        name: "1era Devolución ganadora",
        firstValue: "${stats.t1FirstReturnWon}",
        secondValue: "${stats.t1FirstReturnWon}",
      ),
      Stat(
        name: "Winner con 1era devolución ganadora",
        firstValue: "${stats.t1FirstReturnWinner}",
        secondValue: "${stats.t2FirstReturnWinner}",
      ),
      Stat(
        name: "Puntos ganados con la 1era devolución",
        firstValue:
            "${stats.t1PointsWinnedFirstReturn}/${stats.t1FirstReturnIn + stats.t1FirstReturnOut} (${calculatePercent(stats.t1PointsWinnedFirstReturn, stats.t1FirstReturnIn + stats.t1FirstReturnOut)}%)",
        secondValue:
            "${stats.t2PointsWinnedFirstReturn}/${stats.t2FirstReturnIn + stats.t2FirstReturnOut} (${calculatePercent(stats.t2PointsWinnedFirstReturn, stats.t2FirstReturnIn + stats.t2FirstReturnOut)}%)",
      ),
      Stat(
        name: "2da devolución in",
        firstValue:
            "${stats.t1SecondReturnIn}/${stats.t1SecondReturnIn + stats.t1SecondReturnOut} (${calculatePercent(stats.t1SecondReturnIn, stats.t1SecondReturnIn + stats.t1SecondReturnOut)}%)",
        secondValue:
            "${stats.t2SecondReturnIn}/${stats.t2SecondReturnIn + stats.t2SecondReturnOut} (${calculatePercent(stats.t2SecondReturnIn, stats.t2SecondReturnIn + stats.t2SecondReturnOut)}%)",
      ),
      Stat(
        name: "2da devolución ganadora",
        firstValue: "${stats.t1SecondReturnWon}",
        secondValue: "${stats.t1SecondReturnWon}",
      ),
      Stat(
        name: "Winner con 2da devolución ganadora",
        firstValue: "${stats.t1SecondReturnWinner}",
        secondValue: "${stats.t2SecondReturnWinner}",
      ),
      Stat(
        name: "Puntos ganados con el 2da devolución",
        firstValue:
            "${stats.t1PointsWinnedSecondReturn}/${stats.t1SecondReturnIn + stats.t1SecondReturnOut} (${calculatePercent(stats.t1PointsWinnedSecondReturn, stats.t1SecondReturnIn + stats.t1SecondReturnOut)}%)",
        secondValue:
            "${stats.t2PointsWinnedSecondReturn}/${stats.t2SecondReturnIn + stats.t2SecondReturnOut} (${calculatePercent(stats.t2PointsWinnedSecondReturn, stats.t2SecondReturnIn + stats.t2SecondReturnOut)}%)",
      ),
      Stat(
        name: "Break point",
        firstValue: "1",
        secondValue: "2",
      ),
      Stat(
        name: "Games ganados devolviendo",
        firstValue:
            "${stats.t1GamesWonReturning}/${stats.t1GamesWonReturning + stats.t1GamesLostReturning}",
        secondValue:
            "${stats.t2GamesWonReturning}/${stats.t2GamesWonReturning + stats.t2GamesLostReturning}",
      ),
    ]),
    Section(title: "Pelota en Juego", stats: [
      Stat(
        name: "Puntos ganados en malla",
        firstValue:
            "${stats.t1MeshPointsWon}/${stats.t1MeshPointsWon + stats.t1MeshPointsLost} (${calculatePercent(stats.t1MeshPointsWon, stats.t1MeshPointsWon + stats.t1MeshPointsLost)}%)",
        secondValue:
            "${stats.t2MeshPointsWon}/${stats.t2MeshPointsWon + stats.t2MeshPointsLost} (${calculatePercent(stats.t2MeshPointsWon, stats.t2MeshPointsWon + stats.t2MeshPointsLost)}%)",
      ),
      Stat(
        name: "Winners en malla",
        firstValue: "${stats.t1MeshWinners}",
        secondValue: "${stats.t2MeshWinners}",
      ),
      Stat(
        name: "Errores en malla",
        firstValue: "${stats.t1MeshError}",
        secondValue: "${stats.t2MeshError}",
      ),
      Stat(
        name: "Puntos ganados en fondo/approach",
        firstValue:
            "${stats.t1BckgPointsWon}/${stats.t1BckgPointsWon + stats.t1BckgPointsLost} (${calculatePercent(stats.t1BckgPointsWon, stats.t1BckgPointsWon + stats.t1BckgPointsLost)}%)",
        secondValue:
            "${stats.t2BckgPointsWon}/${stats.t2BckgPointsWon + stats.t2BckgPointsLost} (${calculatePercent(stats.t2BckgPointsWon, stats.t2BckgPointsWon + stats.t2BckgPointsLost)}%)",
      ),
      Stat(
        name: "Winners en fondo/approach",
        firstValue: "${stats.t1BckgWinner}",
        secondValue: "${stats.t2BckgWinner}",
      ),
      Stat(
        name: "Errores en fondo/approach",
        firstValue: "${stats.t1BckgError}",
        secondValue: "${stats.t2BckgError}",
      ),
      Stat(
        name: "Total winner",
        firstValue:
            "${stats.t1MeshWinners + stats.t1BckgWinner + stats.t1FirstReturnWinner + stats.t1SecondReturnWinner + stats.t1Aces}",
        secondValue:
            "${stats.t2MeshWinners + stats.t2BckgWinner + stats.t2FirstReturnWinner + stats.t2SecondReturnWinner + stats.t2Aces}",
      ),
      Stat(
        name: "Total errores no forzados",
        firstValue:
            "${stats.t1MeshError + stats.t1BckgError + stats.t1DoubleFaults}",
        secondValue:
            "${stats.t2MeshError + stats.t2BckgError + stats.t2DoubleFaults}",
      ),
    ]),
    Section(title: "Puntos", stats: [
      Stat(
        name: "Puntos cortos ganados",
        firstValue:
            "${stats.t1MeshPointsWon}/${stats.t1MeshPointsWon + stats.t1MeshPointsLost} (${calculatePercent(stats.t1MeshPointsWon, stats.t1MeshPointsWon + stats.t1MeshPointsLost)}%)",
        secondValue:
            "${stats.t2MeshPointsWon}/${stats.t2MeshPointsWon + stats.t2MeshPointsLost} (${calculatePercent(stats.t2MeshPointsWon, stats.t2MeshPointsWon + stats.t2MeshPointsLost)}%)",
      ),
      Stat(
        name: "Puntos medianos ganados",
        firstValue: "${stats.t1MeshWinners}",
        secondValue: "${stats.t2MeshWinners}",
      ),
      Stat(
        name: "Puntos largos ganados",
        firstValue:
            "${stats.t1BckgPointsWon}/${stats.t1BckgPointsWon + stats.t1BckgPointsLost} (${calculatePercent(stats.t1BckgPointsWon, stats.t1BckgPointsWon + stats.t1BckgPointsLost)}%)",
        secondValue:
            "${stats.t2BckgPointsWon}/${stats.t2BckgPointsWon + stats.t2BckgPointsLost} (${calculatePercent(stats.t2BckgPointsWon, stats.t2BckgPointsWon + stats.t2BckgPointsLost)}%)",
      ),
      Stat(
        name: "Puntos ganados en total",
        firstValue:
            "${stats.t1BckgPointsWon}/${stats.t1BckgPointsWon + stats.t1BckgPointsLost} (${calculatePercent(stats.t1BckgPointsWon, stats.t1BckgPointsWon + stats.t1BckgPointsLost)}%)",
        secondValue:
            "${stats.t2BckgPointsWon}/${stats.t2BckgPointsWon + stats.t2BckgPointsLost} (${calculatePercent(stats.t2BckgPointsWon, stats.t2BckgPointsWon + stats.t2BckgPointsLost)}%)",
      ),
    ])
  ];
}

//List<Section> buildTournamentPartnersTableStats() {}
