import 'package:tennis_app/domain/shared/set.dart';
import 'package:tennis_app/domain/tournament/participant_tracker.dart';
import 'package:uuid/uuid.dart';

import '../shared/game.dart';
import '../shared/serve_flow.dart';

Stats BuildTournamentStats(Map<String, dynamic> json) {
  final stats = TournamentMatchStats(
    trackerId: json['trackerId'],
    matchId: json['matchId'],
    player1: ParticipantStats.fromJson(json['player1']),
    player2: ParticipantStats.fromJson(json['player2']),
    player3: json['player3'] != null
        ? ParticipantStats.fromJson(json['player3'])
        : null,
    player4: json['player4'] != null
        ? ParticipantStats.fromJson(json['player4'])
        : null,
  );
  return stats;
}

class TournamentMatchStats implements Stats {
  String trackerId;
  String matchId;
  ParticipantStats player1;
  ParticipantStats player2;
  ParticipantStats? player3;
  ParticipantStats? player4;

  TournamentMatchStats({
    required this.trackerId,
    required this.matchId,
    required this.player1,
    required this.player2,
    this.player3,
    this.player4,
  });

  factory TournamentMatchStats.singleGame({
    required String p1Id,
    required String p2Id,
    required String tournamentId,
    required String matchId,
  }) {
    String trackerId = Uuid().toString();

    ParticipantStats p1 = ParticipantStats(
      participantTrackerId: Uuid().toString(),
      participantId: p1Id,
      matchId: matchId,
      tournamentId: tournamentId,
      isDouble: false,
    );

    ParticipantStats p2 = ParticipantStats(
      participantTrackerId: Uuid().toString(),
      participantId: p1Id,
      matchId: matchId,
      tournamentId: tournamentId,
      isDouble: false,
    );

    return TournamentMatchStats(
      trackerId: trackerId,
      matchId: matchId,
      player1: p1,
      player2: p2,
    );
  }

  factory TournamentMatchStats.doubleGame({
    required String p1Id,
    required String p2Id,
    required String p3Id,
    required String p4Id,
    required String tournamentId,
    required String matchId,
  }) {
    String trackerId = Uuid().toString();

    ParticipantStats p1 = ParticipantStats(
      participantTrackerId: Uuid().toString(),
      participantId: p1Id,
      matchId: matchId,
      tournamentId: tournamentId,
      isDouble: false,
    );

    ParticipantStats p2 = ParticipantStats(
      participantTrackerId: Uuid().toString(),
      participantId: p1Id,
      matchId: matchId,
      tournamentId: tournamentId,
      isDouble: false,
    );

    ParticipantStats p3 = ParticipantStats(
      participantTrackerId: Uuid().toString(),
      participantId: p3Id,
      matchId: matchId,
      tournamentId: tournamentId,
      isDouble: false,
    );

    ParticipantStats p4 = ParticipantStats(
      participantTrackerId: Uuid().toString(),
      participantId: p4Id,
      matchId: matchId,
      tournamentId: tournamentId,
      isDouble: false,
    );

    return TournamentMatchStats(
      trackerId: trackerId,
      matchId: matchId,
      player1: p1,
      player2: p2,
      player3: p3,
      player4: p4,
    );
  }

  get t1Aces {
    if (player3 != null) {
      return player1.aces + player3!.aces;
    }
    return player1.aces;
  }

  get t2Aces {
    if (player4 != null) {
      return player2.aces + player4!.aces;
    }
    return player2.aces;
  }

  get t1DoubleFaults {
    if (player3 != null) {
      return player1.dobleFaults + player3!.dobleFaults;
    }
    return player1.dobleFaults;
  }

  get t2DoubleFaults {
    if (player4 != null) {
      return player2.dobleFaults + player4!.dobleFaults;
    }
    return player2.dobleFaults;
  }

  get t1FirstServIn {
    if (player3 != null) {
      return player1.firstServIn + player3!.firstServIn;
    }
    return player1.firstServIn;
  }

  get t2FirstServIn {
    if (player4 != null) {
      return player2.firstServIn + player4!.firstServIn;
    }
    return player2.firstServIn;
  }

  get t1FirstServWon {
    if (player3 != null) {
      return player1.firstServWon + player3!.firstServWon;
    }
    return player1.firstServWon;
  }

  get t2FirstServWon {
    if (player4 != null) {
      return player2.firstServWon + player4!.firstServWon;
    }
    return player2.firstServWon;
  }

  get t1PointsWinnedFirstServ {
    if (player3 != null) {
      return player1.pointsWinnedFirstServ + player3!.pointsWinnedFirstServ;
    }
    return player1.pointsWinnedFirstServ;
  }

  get t2PointsWinnedFirstServ {
    if (player4 != null) {
      return player2.pointsWinnedFirstServ + player4!.pointsWinnedFirstServ;
    }
    return player2.pointsWinnedFirstServ;
  }

  get t1SecondServIn {
    if (player3 != null) {
      return player1.secondServIn + player3!.secondServIn;
    }
    return player1.secondServIn;
  }

  get t2SecondServIn {
    if (player4 != null) {
      return player2.secondServIn + player4!.secondServIn;
    }
    return player2.secondServIn;
  }

  get t1SecondServWon {
    if (player3 != null) {
      return player1.secondServWon + player3!.secondServWon;
    }
    return player1.secondServWon;
  }

  get t2SecondServWon {
    if (player4 != null) {
      return player2.secondServWon + player4!.secondServWon;
    }
    return player2.secondServWon;
  }

  get t1PointsWinnedSecondServ {
    if (player3 != null) {
      return player1.pointsWinnedSecondServ + player3!.pointsWinnedSecondServ;
    }
    return player1.pointsWinnedSecondServ;
  }

  get t2PointsWinnedSecondServ {
    if (player4 != null) {
      return player2.pointsWinnedSecondServ + player4!.pointsWinnedSecondServ;
    }
    return player2.pointsWinnedSecondServ;
  }

  get t1GamesWonServing {
    if (player3 != null) {
      return player1.gamesWonServing + player3!.gamesWonServing;
    }
    return player1.gamesWonServing;
  }

  get t2GamesWonServing {
    if (player4 != null) {
      return player2.gamesWonServing + player4!.gamesWonServing;
    }
    return player2.gamesWonServing;
  }

  get t1GamesLostServing {
    if (player3 != null) {
      return player1.gamesLostServing + player3!.gamesLostServing;
    }
    return player1.gamesLostServing;
  }

  get t2GamesLostServing {
    if (player4 != null) {
      return player2.gamesLostServing + player4!.gamesLostServing;
    }
    return player2.gamesLostServing;
  }

  get t1FirstReturnIn {
    if (player3 != null) {
      return player1.firstReturnIn + player3!.firstReturnIn;
    }
    return player1.firstReturnIn;
  }

  get t2FirstReturnIn {
    if (player4 != null) {
      return player2.firstReturnIn + player4!.firstReturnIn;
    }
    return player2.firstReturnIn;
  }

  get t1FirstReturnOut {
    if (player3 != null) {
      return player1.firstReturnOut + player3!.firstReturnOut;
    }
    return player1.firstReturnOut;
  }

  get t2FirstReturnOut {
    if (player4 != null) {
      return player2.firstReturnOut + player4!.firstReturnOut;
    }
    return player2.firstReturnOut;
  }

  get t1FirstReturnWon {
    if (player3 != null) {
      return player1.firstReturnWon + player3!.firstReturnWon;
    }
    return player1.firstReturnWon;
  }

  get t2FirstReturnWon {
    if (player4 != null) {
      return player2.firstReturnWon + player4!.firstReturnWon;
    }
    return player2.firstReturnWon;
  }

  get t1FirstReturnWinner {
    if (player3 != null) {
      return player1.firstReturnWinner + player3!.firstReturnWinner;
    }
    return player1.firstReturnWinner;
  }

  get t2FirstReturnWinner {
    if (player4 != null) {
      return player2.firstReturnWinner + player4!.firstReturnWinner;
    }
    return player2.firstReturnWinner;
  }

  get t1PointsWinnedFirstReturn {
    if (player3 != null) {
      return player1.pointsWinnedFirstReturn + player3!.pointsWinnedFirstReturn;
    }
    return player1.pointsWinnedFirstReturn;
  }

  get t2PointsWinnedFirstReturn {
    if (player4 != null) {
      return player2.pointsWinnedFirstReturn + player4!.pointsWinnedFirstReturn;
    }
    return player2.pointsWinnedFirstReturn;
  }

  get t1SecondReturnIn {
    if (player3 != null) {
      return player1.secondReturnIn + player3!.secondReturnIn;
    }
    return player1.secondReturnIn;
  }

  get t2SecondReturnIn {
    if (player4 != null) {
      return player2.secondReturnIn + player4!.secondReturnIn;
    }
    return player2.secondReturnIn;
  }

  get t1SecondReturnOut {
    if (player3 != null) {
      return player1.secondReturnOut + player3!.secondReturnOut;
    }
    return player1.secondReturnOut;
  }

  get t2SecondReturnOut {
    if (player4 != null) {
      return player2.secondReturnOut + player4!.secondReturnOut;
    }
    return player2.secondReturnOut;
  }

  get t1SecondReturnWon {
    if (player3 != null) {
      return player1.secondReturnWon + player3!.secondReturnWon;
    }
    return player1.secondReturnWon;
  }

  get t2SecondReturnWon {
    if (player4 != null) {
      return player2.secondReturnWon + player4!.secondReturnWon;
    }
    return player2.secondReturnWon;
  }

  get t1SecondReturnWinner {
    if (player3 != null) {
      return player1.secondReturnWinner + player3!.secondReturnWinner;
    }
    return player1.secondReturnWinner;
  }

  get t2SecondReturnWinner {
    if (player4 != null) {
      return player2.secondReturnWinner + player4!.secondReturnWinner;
    }
    return player2.secondReturnWinner;
  }

  get t1SaveBreakPtsChances {
    if (player3 != null) {
      return player1.saveBreakPtsChances + player3!.saveBreakPtsChances;
    }
    return player1.saveBreakPtsChances;
  }

  get t2SaveBreakPtsChances {
    if (player4 != null) {
      return player2.saveBreakPtsChances + player4!.saveBreakPtsChances;
    }
    return player2.saveBreakPtsChances;
  }

  get t1BreakPtsSaved {
    if (player3 != null) {
      return player1.breakPtsSaved + player3!.breakPtsSaved;
    }
    return player1.breakPtsSaved;
  }

  get t2BreakPtsSaved {
    if (player4 != null) {
      return player2.breakPtsSaved + player4!.breakPtsSaved;
    }
    return player2.breakPtsSaved;
  }

  get t1BreakPtsChances {
    return player1.breakPtsChances;
  }

  get t2BreakPtsChances {
    return player2.breakPtsChances;
  }

  get t1BreakPts {
    return player1.breakPts;
  }

  get t2BreakPts {
    return player2.breakPts;
  }

  get t1GamesWonReturning {
    return player1.gamesWonReturning;
  }

  get t2GamesWonReturning {
    return player2.gamesWonReturning;
  }

  get t1GamesLostReturning {
    return player1.gamesLostReturning;
  }

  get t2GamesLostReturning {
    return player2.gamesLostReturning;
  }

  get t1PointsWinnedSecondReturn {
    if (player3 != null) {
      return player1.pointsWinnedSecondReturn +
          player3!.pointsWinnedSecondReturn;
    }
    return player1.pointsWinnedSecondReturn;
  }

  get t2PointsWinnedSecondReturn {
    if (player4 != null) {
      return player2.pointsWinnedSecondReturn +
          player4!.pointsWinnedSecondReturn;
    }
    return player2.pointsWinnedSecondReturn;
  }

  get t1MeshPointsWon {
    if (player3 != null) {
      return player1.meshPointsWon + player3!.meshPointsWon;
    }
    return player1.meshPointsWon;
  }

  get t2MeshPointsWon {
    if (player4 != null) {
      return player2.meshPointsWon + player4!.meshPointsWon;
    }
    return player2.meshPointsWon;
  }

  get t1MeshPointsLost {
    if (player3 != null) {
      return player1.meshPointsLost + player3!.meshPointsLost;
    }
    return player1.meshPointsLost;
  }

  get t2MeshPointsLost {
    if (player4 != null) {
      return player2.meshPointsLost + player4!.meshPointsLost;
    }
    return player2.meshPointsLost;
  }

  get t1MeshWinners {
    if (player3 != null) {
      return player1.meshWinner + player3!.meshWinner;
    }
    return player1.meshWinner;
  }

  get t2MeshWinners {
    if (player4 != null) {
      return player2.meshWinner + player4!.meshWinner;
    }
    return player2.meshWinner;
  }

  get t1MeshError {
    if (player3 != null) {
      return player1.meshError + player3!.meshError;
    }
    return player1.meshError;
  }

  get t2MeshError {
    if (player4 != null) {
      return player2.meshError + player4!.meshError;
    }
    return player2.meshError;
  }

  get t1BckgPointsWon {
    if (player3 != null) {
      return player1.bckgPointsWon + player3!.bckgPointsWon;
    }
    return player1.bckgPointsWon;
  }

  get t2BckgPointsWon {
    if (player4 != null) {
      return player2.bckgPointsWon + player4!.bckgPointsWon;
    }
    return player2.bckgPointsWon;
  }

  get t1BckgPointsLost {
    if (player3 != null) {
      return player1.bckgPointsLost + player3!.bckgPointsLost;
    }
    return player1.bckgPointsLost;
  }

  get t2BckgPointsLost {
    if (player4 != null) {
      return player2.bckgPointsLost + player4!.bckgPointsLost;
    }
    return player2.bckgPointsLost;
  }

  get t1BckgWinner {
    if (player3 != null) {
      return player1.bckgWinner + player3!.bckgWinner;
    }
    return player1.bckgWinner;
  }

  get t2BckgWinner {
    if (player4 != null) {
      return player2.bckgWinner + player4!.bckgWinner;
    }
    return player2.bckgWinner;
  }

  get t1BckgError {
    if (player3 != null) {
      return player1.bckgError + player3!.bckgError;
    }
    return player1.bckgError;
  }

  get t2BckgError {
    if (player4 != null) {
      return player2.bckgError + player4!.bckgError;
    }
    return player2.bckgError;
  }

  get gamesWonServing {
    if (player3 != null) {
      return player1.gamesWonServing + player3!.gamesWonServing;
    }
    return player1.gamesWonServing;
  }

  get gamesLostServing {
    if (player3 != null) {
      return player1.gamesLostServing + player3!.gamesLostServing;
    }
    return player1.gamesLostServing;
  }

  get gamesWonReturning {
    if (player3 != null) {
      return player1.gamesWonReturning + player3!.gamesWonServing;
    }
    return player1.gamesWonReturning;
  }

  get gamesLostReturning {
    if (player3 != null) {
      return player1.gamesLostReturning + player3!.gamesLostServing;
    }
    return player1.gamesLostReturning;
  }

  get totalGamesWon {
    return gamesWonServing + gamesWonReturning;
  }

  get totalGamesLost {
    return gamesLostServing + gamesLostReturning;
  }

  get gamesPlayed {
    return totalGamesWon + totalGamesLost;
  }

  get t1ShortRallyWon {
    if (player3 != null) {
      return player1.shortRallyWon + player3!.shortRallyWon;
    }
    return player1.shortRallyWon;
  }

  get t1MediumRallyWon {
    if (player3 != null) {
      return player1.mediumRallyWon + player3!.mediumRallyWon;
    }
    return player1.mediumRallyWon;
  }

  get t1LongRallyWon {
    if (player3 != null) {
      return player1.longRallyWon + player3!.longRallyWon;
    }
    return player1.longRallyWon;
  }

  get t1ShortRallyLost {
    if (player3 != null) {
      return player1.shortRallyLost + player3!.shortRallyLost;
    }
    return player1.shortRallyLost;
  }

  get t1MediumRallyLost {
    if (player3 != null) {
      return player1.mediumRallyLost + player3!.mediumRallyLost;
    }
    return player1.mediumRallyLost;
  }

  get t1LongRallyLost {
    if (player3 != null) {
      return player1.longRallyLost + player3!.longRallyLost;
    }
    return player1.longRallyLost;
  }

  get t2ShortRallyWon {
    if (player4 != null) {
      return player2.shortRallyWon + player4!.shortRallyWon;
    }
    return player2.shortRallyWon;
  }

  get t2MediumRallyWon {
    if (player4 != null) {
      return player2.mediumRallyWon + player4!.mediumRallyWon;
    }
    return player2.mediumRallyWon;
  }

  get t2LongRallyWon {
    if (player4 != null) {
      return player2.longRallyWon + player4!.longRallyWon;
    }
    return player2.longRallyWon;
  }

  get t2ShortRallyLost {
    if (player4 != null) {
      return player2.shortRallyLost + player4!.shortRallyLost;
    }
    return player2.shortRallyLost;
  }

  get t2MediumRallyLost {
    if (player4 != null) {
      return player2.mediumRallyLost + player4!.mediumRallyLost;
    }
    return player2.mediumRallyLost;
  }

  get t2LongRallyLost {
    if (player4 != null) {
      return player2.longRallyLost + player4!.longRallyLost;
    }
    return player2.longRallyLost;
  }

  void gameEnd({
    required int servingPlayer,
    required bool isTieBreak,
    required bool gameEnd,
    required bool t1WinGame,
  }) {
    if (isTieBreak || !gameEnd) {
      return;
    }
    // must be the same for both players, the total of games loses by
    // the couple
    if (t1WinGame) {
      if (servingPlayer == PlayersIdx.me) {
        player1.winGameServing();
        player2.loseGameReturning();
        player4?.loseGameReturning();
      }
      if (servingPlayer == PlayersIdx.partner) {
        player3?.winGameServing();
        player2.loseGameReturning();
        player4?.loseGameReturning();
      }
      if (servingPlayer == PlayersIdx.rival) {
        player2.loseGameServing();
        player1.winGameReturning();
        player3?.winGameReturning();
      }
      if (servingPlayer == PlayersIdx.rival2) {
        player4?.loseGameServing();
        player1.winGameReturning();
        player3?.winGameReturning();
      }
    } else {
      if (servingPlayer == PlayersIdx.me) {
        player1.loseGameServing();
        player2.winGameReturning();
        player4?.winGameReturning();
      }
      if (servingPlayer == PlayersIdx.partner) {
        player3?.loseGameServing();
        player2.winGameReturning();
        player4?.winGameReturning();
      }
      if (servingPlayer == PlayersIdx.rival) {
        player2.winGameServing();
        player1.loseGameReturning();
        player3?.loseGameReturning();
      }
      if (servingPlayer == PlayersIdx.rival2) {
        player4?.winGameServing();
        player1.loseGameReturning();
        player3?.loseGameReturning();
      }
    }
  }

  void chanceToBreakPt({
    required Game game,
    required int servingPlayer,
  }) {
    if (game.isTiebreak()) return;
    if (!game.isBreakPtsChance(game.myPoints, game.rivalPoints)) {
      return;
    }
    if (game.winGame || game.loseGame) {
      return;
    }

    bool T1_LOSING = game.pointWinGame(game.rivalPoints, game.myPoints);
    bool T2_LOSING = game.pointWinGame(game.myPoints, game.rivalPoints);

    if (servingPlayer == PlayersIdx.me && T1_LOSING) {
      player1.saveBreakptsChance();
      player2.chanceToBreakPt();
      player4?.chanceToBreakPt();
    }
    if (servingPlayer == PlayersIdx.partner && T1_LOSING) {
      player3?.saveBreakptsChance();
      player2.chanceToBreakPt();
      player4?.chanceToBreakPt();
    }
    if (servingPlayer == PlayersIdx.rival && T2_LOSING) {
      player2.saveBreakptsChance();
      player1.chanceToBreakPt();
      player3?.chanceToBreakPt();
    }
    if (servingPlayer == PlayersIdx.rival2 && T2_LOSING) {
      player4?.saveBreakptsChance();
      player1.chanceToBreakPt();
      player3?.chanceToBreakPt();
    }
  }

  void breakPt({
    required Game game,
    required int playerServing,
  }) {
    if (game.isTiebreak()) return;

    bool rivalsServing =
        playerServing == PlayersIdx.rival || playerServing == PlayersIdx.rival2;

    bool teamServing =
        playerServing == PlayersIdx.me || playerServing == PlayersIdx.partner;

    if (rivalsServing && game.winGame) {
      print("T1 Breakpt\n");
      player1.breakPtWon();
      player3?.breakPtWon();
    }

    if (teamServing && game.loseGame) {
      print("T2 Breakpt\n");
      player2.breakPtWon();
      player4?.breakPtWon();
    }
  }

  void saveBreakPt({
    required Game game,
    required int playerServing,
    required bool t1Score,
  }) {
    if (game.isTiebreak()) return;

    bool ONE_POINT_LEFT_T1 = game.pointWinGame(game.myPoints, game.rivalPoints);
    bool ONE_POINT_LEFT_T2 = game.pointWinGame(game.rivalPoints, game.myPoints);
    bool DEUCE = game.isDeuce(game.rivalPoints, game.myPoints);

    if ((ONE_POINT_LEFT_T2 || DEUCE) && !game.loseGame && t1Score) {
      print("T1 SAVE BREAKPT");
      if (playerServing == PlayersIdx.me) {
        player1.breakPtSaved();
      }
      if (playerServing == PlayersIdx.partner) {
        player3?.breakPtSaved();
      }
    }

    if ((ONE_POINT_LEFT_T1 || DEUCE) && !game.winGame && !t1Score) {
      print("T2 SAVE BREAKPT");
      if (playerServing == PlayersIdx.rival) {
        player2.breakPtSaved();
      }
      if (playerServing == PlayersIdx.rival2) {
        player4?.breakPtSaved();
      }
    }
  }

  // intermediate point statistic //
  void ace({
    required int playerServing,
    required int playerReturning,
    required bool isFirstServe,
  }) {
    if (playerServing == PlayersIdx.me) {
      player1.ace(isFirstServe);
    }
    if (playerServing == PlayersIdx.partner) {
      player3?.ace(isFirstServe);
    }

    if (playerServing == PlayersIdx.rival) {
      player2.ace(isFirstServe);
    }
    if (playerServing == PlayersIdx.rival2) {
      player4?.ace(isFirstServe);
    }

    // returns out
    if (playerReturning == PlayersIdx.me) {
      player1.returnOut(isFirstServe);
    }
    if (playerReturning == PlayersIdx.partner) {
      player3?.returnOut(isFirstServe);
    }

    if (playerReturning == PlayersIdx.rival) {
      player2.returnOut(isFirstServe);
    }
    if (playerReturning == PlayersIdx.rival2) {
      player4?.returnOut(isFirstServe);
    }
  }

  void doubleFault({
    required int playerServing,
  }) {
    if (playerServing == PlayersIdx.me) {
      return player1.doubleFault();
    }
    if (playerServing == PlayersIdx.partner) {
      return player3?.doubleFault();
    }
    if (playerServing == PlayersIdx.rival) {
      return player2.doubleFault();
    }
    if (playerServing == PlayersIdx.rival2) {
      return player4?.doubleFault();
    }
  }

  // punto saque no devuelto
  void servWon({
    required int playerServing,
    required int playerReturning,
    required bool isFirstServe,
  }) {
    if (playerServing == PlayersIdx.me) {
      player1.serviceWonPoint(isFirstServe: isFirstServe);
    }
    if (playerServing == PlayersIdx.partner) {
      player3?.serviceWonPoint(isFirstServe: isFirstServe);
    }
    if (playerServing == PlayersIdx.rival) {
      player2.serviceWonPoint(isFirstServe: isFirstServe);
    }
    if (playerServing == PlayersIdx.rival2) {
      player4?.serviceWonPoint(isFirstServe: isFirstServe);
    }

    // returns out
    if (playerReturning == PlayersIdx.me) {
      player1.returnOut(isFirstServe);
    }
    if (playerReturning == PlayersIdx.partner) {
      player3?.returnOut(isFirstServe);
    }

    if (playerReturning == PlayersIdx.rival) {
      player2.returnOut(isFirstServe);
    }
    if (playerReturning == PlayersIdx.rival2) {
      player4?.returnOut(isFirstServe);
    }
  }

  void regularPoint({
    required bool firstServe,
    required int playerServing,
    required int playerReturning,
    required bool t1WinPoint,
    bool action = false,
  }) {
    // serving
    if (playerServing == PlayersIdx.me) {
      player1.servicePoint(firstServe, t1WinPoint);
    }
    if (playerServing == PlayersIdx.partner) {
      player3?.servicePoint(firstServe, t1WinPoint);
    }
    if (playerServing == PlayersIdx.rival) {
      player2.servicePoint(firstServe, !t1WinPoint);
    }
    if (playerServing == PlayersIdx.rival2) {
      player4?.servicePoint(firstServe, !t1WinPoint);
    }
    // returning
    if (playerReturning == PlayersIdx.me) {
      player1.returnPoint(firstServe, t1WinPoint);
    }
    if (playerReturning == PlayersIdx.partner) {
      player3?.returnPoint(firstServe, t1WinPoint);
    }
    if (playerReturning == PlayersIdx.rival) {
      player2.returnPoint(firstServe, !t1WinPoint);
    }
    if (playerReturning == PlayersIdx.rival2) {
      player4?.returnPoint(firstServe, !t1WinPoint);
    }
  }

  // boton de devolucion ganada
  void returnWon({
    required int playerReturning,
    required bool winner,
    required bool isFirstServe,
  }) {
    if (playerReturning == PlayersIdx.me) {
      player1.returnWonPoint(
        winner: winner,
        isFirstServe: isFirstServe,
      );
    }
    if (playerReturning == PlayersIdx.partner) {
      player3?.returnWonPoint(
        winner: winner,
        isFirstServe: isFirstServe,
      );
    }
    if (playerReturning == PlayersIdx.rival) {
      player2.returnWonPoint(
        winner: winner,
        isFirstServe: isFirstServe,
      );
    }
    if (playerReturning == PlayersIdx.rival2) {
      player4?.returnWonPoint(
        winner: winner,
        isFirstServe: isFirstServe,
      );
    }
  }

  void meshPoint({
    required int selectedPlayer,
    required bool winPoint,
    required bool winner,
    required bool error,
  }) {
    if (selectedPlayer == PlayersIdx.me) {
      return player1.meshPoint(
        winPoint: winPoint,
        winner: winner,
        error: error,
      );
    }
    if (selectedPlayer == PlayersIdx.partner) {
      return player3?.meshPoint(
        winPoint: winPoint,
        winner: winner,
        error: error,
      );
    }
    if (selectedPlayer == PlayersIdx.rival) {
      return player2.meshPoint(
        winPoint: winPoint,
        winner: winner,
        error: error,
      );
    }
    if (selectedPlayer == PlayersIdx.rival2) {
      return player4?.meshPoint(
        winPoint: winPoint,
        winner: winner,
        error: error,
      );
    }
  }

  void bckgPoint({
    required int selectedPlayer,
    required bool winPoint,
    required bool winner,
    required bool error,
  }) {
    if (selectedPlayer == PlayersIdx.me) {
      return player1.bckgPoint(
        winPoint: winPoint,
        winner: winner,
        error: error,
      );
    }
    if (selectedPlayer == PlayersIdx.partner) {
      return player3?.bckgPoint(
        winPoint: winPoint,
        winner: winner,
        error: error,
      );
    }
    if (selectedPlayer == PlayersIdx.rival) {
      return player2.bckgPoint(
        winPoint: winPoint,
        winner: winner,
        error: error,
      );
    }
    if (selectedPlayer == PlayersIdx.rival2) {
      return player4?.bckgPoint(
        winPoint: winPoint,
        winner: winner,
        error: error,
      );
    }
  }

  // advanced //
  void rallyPoint({
    required int playerWonSelected,
    required int playerLostSelected,
    required int rally,
  }) {
    print("$playerWonSelected, $playerLostSelected");
    // who won
    if (playerWonSelected == PlayersIdx.me) {
      player1.rallyPoint(rally: rally, winPoint: true);
    }
    if (playerWonSelected == PlayersIdx.partner) {
      player3?.rallyPoint(rally: rally, winPoint: true);
    }
    if (playerWonSelected == PlayersIdx.rival) {
      player2.rallyPoint(rally: rally, winPoint: true);
    }
    if (playerWonSelected == PlayersIdx.rival2) {
      player4?.rallyPoint(rally: rally, winPoint: true);
    }
    // who lost
    if (playerLostSelected == PlayersIdx.me) {
      player1.rallyPoint(rally: rally, winPoint: false);
    }
    if (playerLostSelected == PlayersIdx.partner) {
      player3?.rallyPoint(rally: rally, winPoint: false);
    }
    if (playerLostSelected == PlayersIdx.rival) {
      player2.rallyPoint(rally: rally, winPoint: false);
    }
    if (playerLostSelected == PlayersIdx.rival2) {
      player4?.rallyPoint(rally: rally, winPoint: false);
    }
  }

  TournamentMatchStats clone() {
    return TournamentMatchStats(
      trackerId: trackerId,
      matchId: matchId,
      player1: player1.clone(),
      player2: player2.clone(),
      player3: player3?.clone(),
      player4: player4?.clone(),
    );
  }

  TournamentMatchStats.skeleton()
      : trackerId = "",
        matchId = "",
        player1 = ParticipantStats.skeleton(),
        player2 = ParticipantStats.skeleton(),
        player3 = ParticipantStats.skeleton(),
        player4 = ParticipantStats.skeleton();

  Map<String, dynamic> toJson() {
    return {
      'trackerId': trackerId,
      'matchId': matchId,
      'player1': player1.toJson(),
      'player2': player2.toJson(),
      'player3': player3?.toJson(),
      'player4': player4?.toJson(),
    };
  }

  TournamentMatchStats.calculate(
      {required TournamentMatchStats first,
      required TournamentMatchStats second})
      : trackerId = first.trackerId,
        matchId = first.matchId,
        player1 = ParticipantStats.calculate(
            first: first.player1, second: second.player1),
        player2 = ParticipantStats.calculate(
            first: first.player2, second: second.player2),
        player3 = first.player3 != null
            ? ParticipantStats.calculate(
                first: first.player3!, second: second.player3!)
            : null,
        player4 = first.player4 != null
            ? ParticipantStats.calculate(
                first: first.player4!, second: second.player4!)
            : null;
}
