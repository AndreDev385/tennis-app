part of 'statistics.dart';

class PlayerStatistics {
  int pointsWon;
  int pointsWonServing;
  int pointsWonReturning;

  int pointsLost;
  int pointsLostReturning;
  int pointsLostServing;

  //break points saved - rival break points
  int saveBreakPtsChances;
  int breakPtsSaved;

  // intermediate
  // serv
  int gamesWonServing;
  int gamesLostServing;
  int pointsWinnedFirstServ;
  int pointsWinnedSecondServ;
  int firstServIn;
  int secondServIn;
  int aces;
  int dobleFaults;
  // return
  int pointsWinnedFirstReturn;
  int pointsWinnedSecondReturn;
  int firstReturnIn;
  int secondReturnIn;
  // places
  int meshPointsWon; // malla
  int meshPointsLost;
  int bckgPointsWon; // fondo/approach
  int bckgPointsLost; // fondo/approach
  int winners;
  int noForcedErrors;

  PlayerStatistics({
    // basic
    required this.pointsWon,
    required this.pointsWonServing,
    required this.pointsWonReturning,
    required this.pointsLost,
    required this.pointsLostReturning,
    required this.pointsLostServing,
    required this.saveBreakPtsChances,
    required this.breakPtsSaved,
    // intermediate
    this.gamesWonServing = 0,
    this.gamesLostServing = 0,
    this.pointsWinnedFirstServ = 0,
    this.pointsWinnedSecondServ = 0,
    this.firstServIn = 0,
    this.secondServIn = 0,
    this.aces = 0,
    this.dobleFaults = 0,
    this.pointsWinnedFirstReturn = 0,
    this.pointsWinnedSecondReturn = 0,
    this.firstReturnIn = 0,
    this.secondReturnIn = 0,
    this.meshPointsWon = 0,
    this.meshPointsLost = 0,
    this.bckgPointsWon = 0,
    this.bckgPointsLost = 0,
    this.winners = 0,
    this.noForcedErrors = 0,
  });

  // basic //
  void pointWon() {
    pointsWon++;
  }

  void pointLost() {
    pointsLost++;
  }

  void pointWonServing() {
    pointsWonServing++;
    pointWon();
  }

  void pointLostServing() {
    pointsLostServing++;
    pointLost();
  }

  void pointWonReturning() {
    pointsWonReturning++;
    pointWon();
  }

  void pointLostReturning() {
    pointsLostReturning++;
    pointLost();
  }

  void rivalBreakPoint() {
    saveBreakPtsChances++;
  }

  void saveBreakPt() {
    breakPtsSaved++;
  }
  // basic //

  // intermediate //
  void winGameServing() {
    gamesWonServing++;
  }

  void loseGameServing() {
    gamesLostServing++;
  }

  void servicePoint(bool isFirstServe, bool winPoint) {
    if (isFirstServe) {
      firstServIn++;
      if (winPoint) {
        pointsWinnedFirstServ++;
      }
      return;
    }
    secondServIn++;
    if (winPoint) {
      pointsWinnedSecondServ++;
    }
  }

  void returnPoint(bool isFirstServe, bool winPoint) {
    if (isFirstServe) {
      firstReturnIn++;
      if (winPoint) {
        pointsWinnedFirstReturn++;
      }
      return;
    }
    secondReturnIn++;
    if (winPoint) {
      pointsWinnedSecondReturn++;
    }
  }

  void ace(bool isFirstServe) {
    aces++;
    if (isFirstServe) {
      pointsWinnedFirstServ++;
      firstServIn++;
      return;
    }
    pointsWinnedSecondServ++;
    secondServIn++;
  }

  void doubleFault() {
    dobleFaults++;
  }

  void error() {
    noForcedErrors++;
  }

  void meshPoint(bool winPoint) {
    if (winPoint) {
      meshPointsWon++;
      return;
    }
    meshPointsLost++;
  }

  void bckgPoint(bool winPoint) {
    if (winPoint) {
      bckgPointsWon++;
      return;
    }
    bckgPointsLost++;
  }

  void winnerPoint() {
    winners++;
    bckgPointsWon++;
  }
  // intermediate //

  PlayerStatistics clone() {
    return PlayerStatistics(
      pointsWon: pointsWon,
      pointsWonServing: pointsWonServing,
      pointsWonReturning: pointsWonReturning,

      pointsLost: pointsLost,
      pointsLostServing: pointsLostServing,
      pointsLostReturning: pointsLostReturning,

      saveBreakPtsChances: saveBreakPtsChances,
      breakPtsSaved: breakPtsSaved,
      // intermediate
      pointsWinnedFirstServ: pointsWinnedFirstServ,
      pointsWinnedSecondServ: pointsWinnedSecondServ,
      firstServIn: firstServIn,
      secondServIn: secondServIn,
      aces: aces,
      dobleFaults: dobleFaults,

      pointsWinnedFirstReturn: pointsWinnedFirstReturn,
      pointsWinnedSecondReturn: pointsWinnedSecondReturn,
      firstReturnIn: firstReturnIn,
      secondReturnIn: secondReturnIn,

      meshPointsWon: meshPointsWon,
      meshPointsLost: meshPointsLost,
      bckgPointsWon: bckgPointsWon,
      bckgPointsLost: bckgPointsLost,
      winners: winners,
      noForcedErrors: noForcedErrors,
    );
  }

  PlayerStatistics.fromJson(Map<String, dynamic> json)
      : pointsWon = json["pointsWon"],
        pointsWonServing = json["pointsWonServing"],
        pointsWonReturning = json["pointsWonReturning"],
        pointsLost = json["pointsLost"],
        pointsLostServing = json["pointsLostServing"],
        pointsLostReturning = json["pointsLostReturning"],
        saveBreakPtsChances = json["saveBreakPtsChances"],
        breakPtsSaved = json["breakPtsSaved"],
        // intermediate
        gamesWonServing = json["gamesWonServing"],
        gamesLostServing = json["gamesLostServing"],
        pointsWinnedFirstServ = json["pointsWinnedFirstServ"],
        pointsWinnedSecondServ = json["pointsWinnedSecondServ"],
        firstServIn = json["firstServIn"],
        secondServIn = json["secondServIn"],
        aces = json["aces"],
        dobleFaults = json["dobleFaults"],
        pointsWinnedFirstReturn = json["pointsWinnedFirstReturn"],
        pointsWinnedSecondReturn = json["pointsWinnedSecondReturn"],
        firstReturnIn = json["firstReturnIn"],
        secondReturnIn = json["secondReturnIn"],
        meshPointsWon = json["meshPointsWon"],
        meshPointsLost = json["meshPointsLost"],
        bckgPointsWon = json["bckgPointsWon"],
        bckgPointsLost = json["bckgPointsLost"],
        winners = json["winners"],
        noForcedErrors = json["noForcedErrors"];

  toJson({
    String? playerId,
    String? playerTrackerId,
  }) =>
      {
        "playerId": playerId,
        "playerTrackerId": playerTrackerId,
        "pointsWon": pointsWon,
        "pointsWonServing": pointsWonServing,
        "pointsWonReturning": pointsWonReturning,
        "pointsLost": pointsLost,
        "pointsLostReturning": pointsLostReturning,
        "pointsLostServing": pointsLostServing,
        "saveBreakPtsChances": saveBreakPtsChances,
        "breakPtsSaved": breakPtsSaved,
        "gamesWonServing": gamesWonServing,
        "gamesLostServing": gamesLostServing,
        "pointsWinnedFirstServ": pointsWinnedFirstServ,
        "pointsWinnedSecondServ": pointsWinnedSecondServ,
        "firstServIn": firstServIn,
        "secondServIn": secondServIn,
        "aces": aces,
        "dobleFaults": dobleFaults,
        "pointsWinnedFirstReturn": pointsWinnedFirstReturn,
        "pointsWinnedSecondReturn": pointsWinnedSecondReturn,
        "firstReturnIn": firstReturnIn,
        "secondReturnIn": secondReturnIn,
        "meshPointsWon": meshPointsWon,
        "meshPointsLost": meshPointsLost,
        "bckgPointsWon": bckgPointsWon,
        "bckgPointsLost": bckgPointsLost,
        "winners": winners,
        "noForcedErrors": noForcedErrors,
      };

  @override
  String toString() {
    return '''
           ServPtsWon: $pointsWonServing, ServPtsLost: $pointsLostServing
           RetPtsWon: $pointsWonReturning, RetPtsLost: $pointsLostReturning
           saveBreakPtsChances: $saveBreakPtsChances, breakPtsSaved: $breakPtsSaved

           gamesWonServing: $gamesWonServing gamesLostServing: $gamesLostServing
           aces: $aces, dobleFault: $dobleFaults
           firstServIn: $firstServIn, secondServIn: $secondServIn
           firstServWon: $pointsWinnedFirstServ, secondServWon: $pointsWinnedSecondServ

           firstRetIn: $firstReturnIn, secondRetIn: $secondReturnIn
           firstReturnWon: $pointsWinnedFirstReturn, secondRetWon: $pointsWinnedSecondReturn

           mallaWon: $meshPointsWon, mallaLost: $meshPointsLost, fondoWon: $bckgPointsWon, fondoLost: $bckgPointsLost
           winnersWon: $winners, noForcedErrors: $noForcedErrors\n
           ''';
  }
}
