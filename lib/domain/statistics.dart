import 'package:tennis_app/domain/game.dart';
import 'package:tennis_app/domain/match.dart';

part 'player_statistics.dart';

class PlacePoint {
  static const mesh = 0;
  static const bckg = 1;
  static const winner = 2;
  static const wonReturn = 3;
}

class StatisticsTracker {
  PlayerStatistics me;
  PlayerStatistics? partner;

  // games
  int gamesWonReturning;

  int gamesLostReturning;

  // breakPoints winned
  int winBreakPtsChances;
  int breakPtsWinned;

  // rival
  int rivalAces;
  int rivalDobleFault;
  int rivalNoForcedErrors;
  int rivalWinners;

  int rivalPointsWinnedFirstServ;
  int rivalPointsWinnedSecondServ;
  int rivalFirstServIn;
  int rivalSecondServIn;

  int rivalPointsWinnedFirstReturn;
  int rivalPointsWinnedSecondReturn;
  int rivalFirstReturnIn;
  int rivalSecondReturnIn;

  // rally
  int shortRallyWon;
  int mediumRallyWon;
  int longRallyWon;
  int shortRallyLost;
  int mediumRallyLost;
  int longRallyLost;

  StatisticsTracker({
    required this.me,
    required this.gamesWonReturning,
    required this.gamesLostReturning,
    required this.winBreakPtsChances,
    required this.breakPtsWinned,
    // rival statistics,
    this.rivalPointsWinnedFirstServ = 0,
    this.rivalPointsWinnedSecondServ = 0,
    this.rivalFirstServIn = 0,
    this.rivalSecondServIn = 0,
    this.rivalPointsWinnedFirstReturn = 0,
    this.rivalPointsWinnedSecondReturn = 0,
    this.rivalFirstReturnIn = 0,
    this.rivalSecondReturnIn = 0,
    this.partner,
    this.rivalNoForcedErrors = 0,
    this.rivalAces = 0,
    this.rivalDobleFault = 0,
    this.rivalWinners = 0,
    this.shortRallyWon = 0,
    this.mediumRallyWon = 0,
    this.longRallyWon = 0,
    this.shortRallyLost = 0,
    this.mediumRallyLost = 0,
    this.longRallyLost = 0,
  });

  factory StatisticsTracker.singleGame() {
    PlayerStatistics me = PlayerStatistics(
      pointsWon: 0,
      pointsWonServing: 0,
      pointsWonReturning: 0,
      pointsLost: 0,
      pointsLostServing: 0,
      pointsLostReturning: 0,
      saveBreakPtsChances: 0,
      breakPtsSaved: 0,
    );

    return StatisticsTracker(
      me: me,
      gamesWonReturning: 0,
      gamesLostReturning: 0,
      winBreakPtsChances: 0,
      breakPtsWinned: 0,
      //rival serv in
      rivalPointsWinnedFirstServ: 0,
      rivalPointsWinnedSecondServ: 0,
      rivalFirstServIn: 0,
      rivalSecondServIn: 0,
      //rival ret in
      rivalPointsWinnedFirstReturn: 0,
      rivalPointsWinnedSecondReturn: 0,
      rivalFirstReturnIn: 0,
      rivalSecondReturnIn: 0,
    );
  }

  factory StatisticsTracker.doubleGame() {
    PlayerStatistics me = PlayerStatistics(
      pointsWon: 0,
      pointsWonServing: 0,
      pointsWonReturning: 0,
      pointsLost: 0,
      pointsLostServing: 0,
      pointsLostReturning: 0,
      saveBreakPtsChances: 0,
      breakPtsSaved: 0,
    );

    PlayerStatistics partner = PlayerStatistics(
      pointsWon: 0,
      pointsWonServing: 0,
      pointsWonReturning: 0,
      pointsLost: 0,
      pointsLostServing: 0,
      pointsLostReturning: 0,
      saveBreakPtsChances: 0,
      breakPtsSaved: 0,
    );

    return StatisticsTracker(
      me: me,
      partner: partner,
      gamesWonReturning: 0,
      gamesLostReturning: 0,
      breakPtsWinned: 0,
      winBreakPtsChances: 0,
      //rival serv in
      rivalPointsWinnedFirstServ: 0,
      rivalPointsWinnedSecondServ: 0,
      rivalFirstServIn: 0,
      rivalSecondServIn: 0,
      //rival ret in
      rivalPointsWinnedFirstReturn: 0,
      rivalPointsWinnedSecondReturn: 0,
      rivalFirstReturnIn: 0,
      rivalSecondReturnIn: 0,
    );
  }

  get totalPtsServ {
    if (partner != null) {
      return me.pointsWonServing + partner!.pointsWonServing;
    }
    return me.pointsWonServing;
  }

  get totalPtsServLost {
    if (partner != null) {
      return me.pointsLostServing + partner!.pointsLostServing;
    }
    return me.pointsLostServing;
  }

  get totalPtsRet {
    if (partner != null) {
      return me.pointsWonReturning + partner!.pointsWonReturning;
    }
    return me.pointsWonReturning;
  }

  get totalPtsRetLost {
    if (partner != null) {
      return me.pointsLostReturning + partner!.pointsLostReturning;
    }
    return me.pointsLostReturning;
  }

  get totalPts {
    return totalPtsServ + totalPtsRet;
  }

  get totalPtsLost {
    return totalPtsServLost + totalPtsRetLost;
  }

  get gamesWonServing {
    if (partner != null) {
      return me.gamesWonServing + partner!.gamesWonServing;
    }
    return me.gamesWonServing;
  }

  get gamesLostServing {
    if (partner != null) {
      return me.gamesLostServing + partner!.gamesLostServing;
    }
    return me.gamesLostServing;
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

  get firstServIn {
    int servIn = me.firstServIn;
    if (partner != null) {
      servIn += partner!.firstServIn;
    }
    return servIn;
  }

  get secondServIn {
    int servIn = me.secondServIn;
    if (partner != null) {
      servIn += partner!.secondServIn;
    }
    return servIn;
  }

  get pointsWon1Serv {
    int pointsWon = me.pointsWinnedFirstServ;
    if (partner != null) {
      pointsWon += partner!.pointsWinnedFirstServ;
    }
    return pointsWon;
  }

  get pointsWon2Serv {
    int pointsWon = me.pointsWinnedSecondServ;
    if (partner != null) {
      pointsWon += partner!.pointsWinnedSecondServ;
    }
    return pointsWon;
  }

  get firstRetIn {
    int returnsIn = me.firstReturnIn;
    if (partner != null) {
      returnsIn += partner!.firstReturnIn;
    }
    return returnsIn;
  }

  get secondRetIn {
    int returnsIn = me.secondReturnIn;
    if (partner != null) {
      returnsIn += partner!.secondReturnIn;
    }
    return returnsIn;
  }

  get pointsWon1Ret {
    int pointsWon = me.pointsWinnedFirstReturn;
    if (partner != null) {
      pointsWon += partner!.pointsWinnedFirstReturn;
    }
    return pointsWon;
  }

  get pointsWon2Ret {
    int pointsWon = me.pointsWinnedSecondReturn;
    if (partner != null) {
      pointsWon += partner!.pointsWinnedSecondReturn;
    }
    return pointsWon;
  }

  String rivalBreakPoints(Game game) {
    int breakPtsSaved = me.breakPtsSaved;
    int breakPtsChances = me.saveBreakPtsChances;
    if (partner != null) {
      breakPtsSaved += partner!.breakPtsSaved;
      breakPtsChances += partner!.saveBreakPtsChances;
    }
    int saved = breakPtsSaved;
    if (game.pointWinGame(game.rivalPoints, game.myPoints)) {
      saved += 1;
    }
    return "${breakPtsChances - saved}/$breakPtsChances";
  }

  get aces {
    int points = me.aces;
    if (partner != null) {
      points += partner!.aces;
    }
    return points;
  }

  get dobleFault {
    int points = me.dobleFaults;
    if (partner != null) {
      points += partner!.dobleFaults;
    }
    return points;
  }

  get meshPontsWon {
    int points = me.meshPointsWon;
    if (partner != null) {
      points += partner!.meshPointsWon;
    }
    return points;
  }

  get meshPontsLost {
    int points = me.meshPointsLost;
    if (partner != null) {
      points += partner!.meshPointsLost;
    }
    return points;
  }

  get bckgPontsWon {
    int points = me.bckgPointsWon;
    if (partner != null) {
      points += partner!.bckgPointsWon;
    }
    return points;
  }

  get bckgPontsLost {
    int points = me.bckgPointsLost;
    if (partner != null) {
      points += partner!.bckgPointsLost;
    }
    return points;
  }

  get winners {
    int points = me.winners;
    if (partner != null) {
      points += partner!.winners;
    }
    return points;
  }

  get noForcedErrors {
    int errors = me.noForcedErrors;
    if (partner != null) {
      errors += partner!.noForcedErrors;
    }
    return errors;
  }

  void winGame({
    required int servingPlayer,
    required bool winGame,
    required isSuperTieBreak,
  }) {
    if (!winGame || isSuperTieBreak) {
      return;
    }
    if (servingPlayer == PlayersIdx.me) {
      me.winGameServing();
    }
    if (servingPlayer == PlayersIdx.partner) {
      partner?.winGameServing();
    }
    if (servingPlayer != PlayersIdx.me && servingPlayer != PlayersIdx.partner) {
      gamesWonReturning++;
    }
  }

  void lostGame({
    required int servingPlayer,
    required bool lostGame,
    required isSuperTieBreak,
  }) {
    if (!lostGame || isSuperTieBreak) {
      return;
    }
    if (servingPlayer == PlayersIdx.me) {
      me.loseGameServing();
    }
    if (servingPlayer == PlayersIdx.partner) {
      partner?.loseGameServing();
    }
    if (servingPlayer != PlayersIdx.me && servingPlayer != PlayersIdx.partner) {
      gamesLostReturning++;
    }
  }

  // our break points //
  void breakPoint({required Game game, required int playerServing}) {
    if (playerServing == PlayersIdx.rival ||
        playerServing == PlayersIdx.rival2) {
      if (game.pointWinGame(game.myPoints, game.rivalPoints) && !game.winGame) {
        winBreakPtsChances++;
      }
    }
  }

  void winBreakPt({required Game game, required int playerServing}) {
    if ((playerServing == PlayersIdx.rival ||
            playerServing == PlayersIdx.rival2) &&
        game.winGame) {
      breakPtsWinned++;
    }
  }
  // our break points //

  // rival break points //
  void rivalBreakPoint({required Game game, required int playerServing}) {
    if (game.pointWinGame(game.rivalPoints, game.myPoints) && !game.loseGame) {
      if (playerServing == PlayersIdx.me) {
        me.rivalBreakPoint();
      }

      if (playerServing == PlayersIdx.partner) {
        partner?.rivalBreakPoint();
      }
    }
  }

  void saveBreakPt({required Game game, required int playerServing}) {
    if (game.pointWinGame(game.rivalPoints, game.myPoints) ||
        game.isDeuce(game.rivalPoints, game.myPoints)) {
      if (playerServing == PlayersIdx.me) {
        me.saveBreakPt();
      }
      if (playerServing == PlayersIdx.partner) {
        partner?.saveBreakPt();
      }
    }
  }
  // rival break points //

  // basic point statistic //
  void simplePoint({
    required bool winPoint,
    required int selectedPlayer,
    required bool isServing,
    required bool isReturning,
  }) {
    if (winPoint && isServing) {
      return _winServing(selectedPlayer);
    }
    if (winPoint && isReturning) {
      return _winReturning(selectedPlayer);
    }
    if (!winPoint && isServing) {
      return _loseServing(selectedPlayer);
    }
    if (!winPoint && isReturning) {
      return _loseReturning(selectedPlayer);
    }
    if (winPoint) {
      return _winPoint(selectedPlayer);
    }
    if (!winPoint) {
      return _losePoint(selectedPlayer);
    }
  }

  void _winServing(int player) {
    if (player == PlayersIdx.me) {
      return me.pointWonServing();
    }
    if (player == PlayersIdx.partner) {
      return partner?.pointWonServing();
    }
  }

  void _loseServing(int player) {
    if (player == PlayersIdx.me) {
      me.pointLostServing();
    }
    if (player == PlayersIdx.partner) {
      partner?.pointLostServing();
    }
  }

  void _winReturning(int player) {
    if (player == PlayersIdx.me) {
      me.pointWonReturning();
    }
    if (player == PlayersIdx.partner) {
      partner?.pointWonReturning();
    }
  }

  void _loseReturning(int player) {
    if (player == PlayersIdx.me) {
      me.pointLostReturning();
    }
    if (player == PlayersIdx.partner) {
      partner?.pointLostReturning();
    }
  }

  void _winPoint(int player) {
    if (player == PlayersIdx.me) {
      me.pointWon();
    }
    if (player == PlayersIdx.partner) {
      partner?.pointWon();
    }
  }

  void _losePoint(int player) {
    if (player == PlayersIdx.me) {
      me.pointLost();
    }
    if (player == PlayersIdx.partner) {
      partner?.pointLost();
    }
  }
  // basic point statistic //

  // intermediate point statistic //
  void ace({
    required int playerServing,
    required bool isFirstServe,
    required bool winPoint,
  }) {
    if (winPoint) {
      if (playerServing == PlayersIdx.me) {
        return me.ace(isFirstServe);
      }
      if (playerServing == PlayersIdx.partner) {
        return partner?.ace(isFirstServe);
      }
      return;
    }
    if (isFirstServe) {
      rivalFirstServIn++;
      rivalPointsWinnedFirstServ++;
    } else {
      rivalSecondServIn++;
      rivalPointsWinnedSecondServ++;
    }
    rivalAces++;
  }

  void doubleFault({
    required int playerServing,
  }) {
    print("PLAYER SERVING $playerServing");
    if (playerServing == PlayersIdx.me) {
      return me.doubleFault();
    }
    if (playerServing == PlayersIdx.partner) {
      return partner?.doubleFault();
    }
    rivalDobleFault++;
  }

  void servicePoint({
    required bool firstServe,
    required int playerServing,
    required bool winPoint,
    bool action = false,
  }) {
    if (playerServing == PlayersIdx.me || playerServing == PlayersIdx.partner) {
      if (firstServe && action) {
        rivalFirstReturnIn++;
        if (!winPoint) {
          rivalPointsWinnedFirstReturn++;
        }
      }
      if (!firstServe && action) {
        rivalSecondReturnIn++;
        if (!winPoint) {
          rivalPointsWinnedSecondReturn++;
        }
      }
    }
    // we are serving
    if (playerServing == PlayersIdx.me) {
      return me.servicePoint(firstServe, winPoint);
    }

    if (playerServing == PlayersIdx.partner) {
      return partner?.servicePoint(firstServe, winPoint);
    }
    // rivals serving
    if (firstServe) {
      rivalFirstServIn++;
      if (!winPoint) {
        rivalPointsWinnedFirstServ++;
      }
    } else {
      rivalSecondServIn++;
      if (!winPoint) {
        rivalPointsWinnedSecondServ++;
      }
    }
  }

  void returnPoint({
    required isFirstServe,
    required int playerReturning,
    required bool winPoint,
  }) {
    if (playerReturning == PlayersIdx.me ||
        playerReturning == PlayersIdx.partner) {
      if (isFirstServe) {
        rivalFirstServIn++;
        if (!winPoint) {
          rivalPointsWinnedFirstServ++;
        }
      } else {
        rivalSecondServIn++;
        if (!winPoint) {
          rivalPointsWinnedSecondServ++;
        }
      }
    }
    if (playerReturning == PlayersIdx.me) {
      return me.returnPoint(isFirstServe, winPoint);
    }
    if (playerReturning == PlayersIdx.partner) {
      return partner?.returnPoint(isFirstServe, winPoint);
    }
    if (isFirstServe) {
      rivalFirstReturnIn++;
      if (!winPoint) {
        rivalPointsWinnedFirstReturn++;
      }
      return;
    }
    rivalSecondReturnIn++;
    if (!winPoint) {
      rivalPointsWinnedSecondReturn++;
    }
  }

  void meshPoint({
    required int selectedPlayer,
    required bool winPoint,
  }) {
    if (selectedPlayer == PlayersIdx.me) {
      return me.meshPoint(winPoint);
    }
    if (selectedPlayer == PlayersIdx.partner) {
      return partner?.meshPoint(winPoint);
    }
  }

  void bckgPoint({
    required int selectedPlayer,
    required bool winPoint,
  }) {
    if (selectedPlayer == PlayersIdx.me) {
      return me.bckgPoint(winPoint);
    }
    if (selectedPlayer == PlayersIdx.partner) {
      return partner?.bckgPoint(winPoint);
    }
  }

  void winnerPoint({
    required int selectedPlayer,
    required bool winPoint,
  }) {
    if (winPoint) {
      if (selectedPlayer == PlayersIdx.me) {
        return me.winnerPoint();
      }
      if (selectedPlayer == PlayersIdx.partner) {
        return partner?.winnerPoint();
      }
    } else {
      rivalWinners++;
      if (selectedPlayer == PlayersIdx.me) {
        return me.bckgPoint(false);
      }
      if (selectedPlayer == PlayersIdx.partner) {
        return partner?.bckgPoint(false);
      }
    }
  }

  void placePoint({
    required int selectedPlayer,
    required int playerServing,
    required int playerReturning,
    required int place,
    required bool winPoint,
  }) {
    if (place == PlacePoint.mesh) {
      meshPoint(
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
      );
    }
    if (place == PlacePoint.bckg) {
      bckgPoint(
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
      );
    }
    if (place == PlacePoint.winner) {
      winnerPoint(
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
      );
    }
  }

  void noForcedError(int player, bool winPoint) {
    if (!winPoint) {
      if (player == PlayersIdx.me) {
        me.error();
      }
      if (player == PlayersIdx.partner) {
        partner?.error();
      }
    } else {
      rivalNoForcedErrors++;
    }
  }
  // intermediate point statistic //

  // advanced //
  void winRally(int rally, bool winPoint) {
    if (rally < 4) {
      winPoint ? shortRallyWon++ : shortRallyLost++;
    }
    if (rally >= 5 && rally < 9) {
      winPoint ? mediumRallyWon++ : mediumRallyLost++;
    }
    if (rally >= 9) {
      winPoint ? longRallyWon++ : longRallyLost++;
    }
  }

  StatisticsTracker clone() {
    return StatisticsTracker(
      me: me.clone(),
      partner: partner?.clone(),

      // games
      gamesWonReturning: gamesWonReturning,
      gamesLostReturning: gamesLostReturning,

      // breakPoints winned
      winBreakPtsChances: winBreakPtsChances,
      breakPtsWinned: breakPtsWinned,

      rivalAces: rivalAces,
      rivalDobleFault: rivalDobleFault,
      rivalNoForcedErrors: rivalNoForcedErrors,
      rivalWinners: rivalWinners,

      //rival
      rivalPointsWinnedFirstServ: rivalPointsWinnedFirstServ,
      rivalPointsWinnedSecondServ: rivalPointsWinnedSecondServ,
      rivalFirstServIn: rivalFirstServIn,
      rivalSecondServIn: rivalSecondServIn,

      rivalPointsWinnedFirstReturn: rivalPointsWinnedFirstReturn,
      rivalPointsWinnedSecondReturn: rivalPointsWinnedSecondReturn,
      rivalFirstReturnIn: rivalFirstReturnIn,
      rivalSecondReturnIn: rivalSecondReturnIn,

      shortRallyWon: shortRallyWon,
      mediumRallyWon: mediumRallyWon,
      longRallyWon: longRallyWon,

      shortRallyLost: shortRallyLost,
      mediumRallyLost: mediumRallyLost,
      longRallyLost: longRallyLost,
    );
  }

  StatisticsTracker.fromJson(Map<String, dynamic> json)
      : me = PlayerStatistics.fromJson(json['me']),
        partner = json["partner"] != null
            ? PlayerStatistics.fromJson(json['partner'])
            : null,
        gamesLostReturning = json["gamesLostReturning"],
        gamesWonReturning = json["gamesWonReturning"],
        winBreakPtsChances = json["winBreakPtsChances"],
        breakPtsWinned = json["breakPtsWinned"],
        rivalAces = json["rivalAces"],
        longRallyWon = json["longRallyWon"],
        rivalWinners = json["rivalWinners"],
        longRallyLost = json["longRallyLost"],
        shortRallyWon = json["shortRallyWon"],
        mediumRallyWon = json["mediumRallyWon"],
        shortRallyLost = json["shortRallyLost"],
        mediumRallyLost = json["mediumRallyLost"],
        rivalDobleFault = json["rivalDobleFault"],
        rivalFirstServIn = json["rivalFirstServIn"],
        rivalSecondServIn = json["rivalSecondServIn"],
        rivalFirstReturnIn = json["rivalFirstReturnIn"],
        rivalNoForcedErrors = json["rivalNoForcedErrors"],
        rivalSecondReturnIn = json["rivalSecondReturnIn"],
        rivalPointsWinnedFirstServ = json["rivalPointsWinnedFirstServ"],
        rivalPointsWinnedSecondServ = json["rivalPointsWinnedSecondServ"],
        rivalPointsWinnedFirstReturn = json["rivalPointsWinnedFirstReturn"],
        rivalPointsWinnedSecondReturn = json["rivalPointsWinnedSecondReturn"];

  toJson({
    String? trackerId,
    String? matchId,
    String? player1Id,
    String? player2Id,
    String? player1TrackerId,
    String? player2TrackerId,
  }) =>
      {
        "trackerId": trackerId,
        "matchId": matchId,
        "me": me.toJson(
          playerId: player1Id,
          playerTrackerId: player1TrackerId,
        ),
        "partner": partner != null
            ? partner!.toJson(
                playerId: player2Id,
                playerTrackerId: player2TrackerId,
              )
            : null,
        "gamesLostReturning": gamesLostReturning,
        "gamesWonReturning": gamesWonReturning,
        "winBreakPtsChances": winBreakPtsChances,
        "breakPtsWinned": breakPtsWinned,
        "rivalAces": rivalAces,
        "longRallyWon": longRallyWon,
        "rivalWinners": rivalWinners,
        "longRallyLost": longRallyLost,
        "shortRallyWon": shortRallyWon,
        "mediumRallyWon": mediumRallyWon,
        "shortRallyLost": shortRallyLost,
        "mediumRallyLost": mediumRallyLost,
        "rivalDobleFault": rivalDobleFault,
        "rivalFirstServIn": rivalFirstServIn,
        "rivalSecondServIn": rivalSecondServIn,
        "rivalFirstReturnIn": rivalFirstReturnIn,
        "rivalNoForcedErrors": rivalNoForcedErrors,
        "rivalSecondReturnIn": rivalSecondReturnIn,
        "rivalPointsWinnedFirstServ": rivalPointsWinnedFirstServ,
        "rivalPointsWinnedSecondServ": rivalPointsWinnedSecondServ,
        "rivalPointsWinnedFirstReturn": rivalPointsWinnedFirstReturn,
        "rivalPointsWinnedSecondReturn": rivalPointsWinnedSecondReturn,
      };

  @override
  String toString() {
    return '''
        me:
        $me
        partner
        $partner
        totalPtsServ: $totalPtsServ, totalPtsRet: $totalPtsRet, totalWon: $totalPts
        totalPtsServLost: $totalPtsServLost, totalPtsRetLost: $totalPtsRetLost, totalLost: $totalPtsLost
        gamesWonRet:$gamesWonReturning, gamesWon: $totalGamesWon
        gamesLostRet:$gamesLostReturning, gamesLost: $totalGamesLost
        breakPts: $winBreakPtsChances, breakPtsWon: $breakPtsWinned

        rival1ServIn: $rivalFirstServIn rival2Servin: $rivalSecondServIn
        rivalPtsWon1Serv: $rivalPointsWinnedFirstServ rivalPtsWon2Serv: $rivalPointsWinnedSecondServ
        rival1RetIn: $rivalFirstReturnIn rival2RetIn: $rivalSecondReturnIn
        rivalPtswon1Ret: $rivalPointsWinnedFirstReturn rivalPtsWon2Ret: $rivalPointsWinnedSecondReturn
        rivalNoForcedErrors: $rivalNoForcedErrors, rivalWinners: $rivalWinners, rivalAces: $rivalAces dobleFault: $rivalDobleFault

        shortRallyWon: $shortRallyWon, mediumRallyWon: $mediumRallyWon, longRallyWon: $longRallyWon
        shortRallyLost: $shortRallyLost, mediumRallyLost: $mediumRallyLost, longRallyLost: $longRallyLost
           ''';
  }
}
