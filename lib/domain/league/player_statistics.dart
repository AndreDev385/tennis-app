part of 'statistics.dart';

class PlayerStatistics {
  bool isDouble;
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
  int firstServIn;
  int secondServIn;
  int aces;
  int dobleFaults;
  int firstServWon; // Saque no devuelto
  int secondServWon; // Saque no devuelto
  int pointsWinnedFirstServ;
  int pointsWinnedSecondServ;
  int gamesWonServing;
  int gamesLostServing;
  // return
  int firstReturnWon; // boton devolucion ganada
  int secondReturnWon; // botton devolucion ganada
  int firstReturnWinner; // winner con devolucion ganada
  int secondReturnWinner; // winner con devolucion ganada
  int firstReturnIn;
  int secondReturnIn;
  int firstReturnOut;
  int secondReturnOut;
  int pointsWinnedFirstReturn;
  int pointsWinnedSecondReturn;
  // places
  int meshPointsWon; // malla
  int meshPointsLost; // malla
  int meshWinner;
  int meshError;
  int bckgPointsWon; // fondo/approach
  int bckgPointsLost; // fondo/approach
  int bckgWinner;
  int bckgError;
  // total
  //int winners;
  //int noForcedErrors;

  PlayerStatistics({
    required this.isDouble,
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
    // serv
    this.gamesWonServing = 0,
    this.gamesLostServing = 0,
    this.pointsWinnedFirstServ = 0,
    this.pointsWinnedSecondServ = 0,
    this.firstServIn = 0,
    this.secondServIn = 0,
    this.aces = 0,
    this.dobleFaults = 0,
    this.firstServWon = 0,
    this.secondServWon = 0,
    // return
    this.pointsWinnedFirstReturn = 0,
    this.pointsWinnedSecondReturn = 0,
    this.firstReturnWon = 0,
    this.secondReturnWon = 0,
    this.firstReturnWinner = 0,
    this.secondReturnWinner = 0,
    this.firstReturnIn = 0,
    this.secondReturnIn = 0,
    this.firstReturnOut = 0,
    this.secondReturnOut = 0,
    // place
    this.meshPointsWon = 0,
    this.meshPointsLost = 0,
    this.meshWinner = 0,
    this.meshError = 0,
    this.bckgPointsWon = 0,
    this.bckgPointsLost = 0,
    this.bckgWinner = 0,
    this.bckgError = 0,
    //this.winners = 0,
    //this.noForcedErrors = 0,
  });

  int get noForcedErrors {
    return meshError + bckgError + dobleFaults;
  }

  int get winners {
    return meshWinner +
        bckgWinner +
        firstReturnWinner +
        secondReturnWinner +
        aces;
  }

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

  void serviceWonPoint({required bool isFirstServe}) {
    if (isFirstServe) {
      firstServWon++;
      return;
    }
    secondServWon++;
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

  void returnOut(bool isFirstServe) {
    if (isFirstServe) {
      firstReturnOut++;
      return;
    }
    secondReturnOut++;
  }

  void returnWonPoint({required bool winner, required bool isFirstServe}) {
    if (isFirstServe) {
      firstReturnWon++;
      if (winner) {
        firstReturnWinner++;
      }
      return;
    }
    secondReturnWon++;
    if (winner) {
      secondReturnWinner++;
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
      firstServIn++;
      firstServWon++;
      pointsWinnedFirstServ++;
      return;
    }
    secondServIn++;
    secondServWon++;
    pointsWinnedSecondServ++;
  }

  void doubleFault() {
    dobleFaults++;
  }

  void meshPoint({
    required bool winPoint,
    required bool winner,
    required bool error,
  }) {
    if (winPoint) {
      meshPointsWon++;
      if (winner) {
        meshWinner++;
      }
      return;
    }
    meshPointsLost++;
    if (error) {
      meshError++;
    }
  }

  void bckgPoint({
    required bool winPoint,
    required bool winner,
    required bool error,
  }) {
    if (winPoint) {
      bckgPointsWon++;
      if (winner) {
        bckgWinner++;
      }
      return;
    }
    bckgPointsLost++;
    if (error) {
      bckgError++;
    }
  }

  // intermediate //

  PlayerStatistics clone() {
    return PlayerStatistics(
      isDouble: isDouble,
      pointsWon: pointsWon,
      pointsWonServing: pointsWonServing,
      pointsWonReturning: pointsWonReturning,

      pointsLost: pointsLost,
      pointsLostServing: pointsLostServing,
      pointsLostReturning: pointsLostReturning,

      saveBreakPtsChances: saveBreakPtsChances,
      breakPtsSaved: breakPtsSaved,
      // intermediate
      //serv
      gamesWonServing: gamesWonServing,
      gamesLostServing: gamesLostServing,
      pointsWinnedFirstServ: pointsWinnedFirstServ,
      pointsWinnedSecondServ: pointsWinnedSecondServ,
      firstServIn: firstServIn,
      secondServIn: secondServIn,
      aces: aces,
      dobleFaults: dobleFaults,
      firstServWon: firstServWon,
      secondServWon: secondServWon,
      // ret
      pointsWinnedFirstReturn: pointsWinnedFirstReturn,
      pointsWinnedSecondReturn: pointsWinnedSecondReturn,
      firstReturnIn: firstReturnIn,
      firstReturnOut: firstReturnOut,
      secondReturnIn: secondReturnIn,
      secondReturnOut: secondReturnOut,
      firstReturnWon: firstReturnWon,
      secondReturnWon: secondReturnWon,
      firstReturnWinner: firstReturnWinner,
      secondReturnWinner: secondReturnWinner,

      //place
      meshWinner: meshWinner,
      meshError: meshError,
      meshPointsWon: meshPointsWon,
      meshPointsLost: meshPointsLost,
      bckgWinner: bckgWinner,
      bckgError: bckgError,
      bckgPointsWon: bckgPointsWon,
      bckgPointsLost: bckgPointsLost,
      //winners: winners,
      //noForcedErrors: noForcedErrors,
    );
  }

  PlayerStatistics.fromJson(Map<String, dynamic> json)
      : isDouble = json["isDouble"],
        pointsWon = json["pointsWon"],
        pointsWonServing = json["pointsWonServing"],
        pointsWonReturning = json["pointsWonReturning"],
        pointsLost = json["pointsLost"],
        pointsLostServing = json["pointsLostServing"],
        pointsLostReturning = json["pointsLostReturning"],
        saveBreakPtsChances = json["saveBreakPtsChances"],
        breakPtsSaved = json["breakPtsSaved"],
        // intermediate
        // serv
        gamesWonServing = json["gamesWonServing"],
        gamesLostServing = json["gamesLostServing"],
        pointsWinnedFirstServ = json["pointsWinnedFirstServ"],
        pointsWinnedSecondServ = json["pointsWinnedSecondServ"],
        firstServIn = json["firstServIn"],
        secondServIn = json["secondServIn"],
        aces = json["aces"],
        dobleFaults = json["dobleFaults"],
        firstServWon = json["firstServWon"],
        secondServWon = json["secondServWon"],
        // return
        pointsWinnedFirstReturn = json["pointsWinnedFirstReturn"],
        pointsWinnedSecondReturn = json["pointsWinnedSecondReturn"],
        firstReturnWon = json["firstReturnWon"],
        secondReturnWon = json["secondReturnWon"],
        firstReturnWinner = json["firstReturnWinner"],
        secondReturnWinner = json["secondReturnWinner"],
        firstReturnIn = json["firstReturnIn"],
        secondReturnIn = json["secondReturnIn"],
        firstReturnOut = json["firstReturnOut"],
        secondReturnOut = json["secondReturnOut"],
        // place
        meshPointsWon = json["meshPointsWon"],
        meshPointsLost = json["meshPointsLost"],
        meshWinner = json['meshWinner'],
        meshError = json['meshError'],
        bckgPointsWon = json["bckgPointsWon"],
        bckgPointsLost = json["bckgPointsLost"],
        bckgWinner = json['bckgWinner'],
        bckgError = json['bckgError'];
  //winners = json["winners"],
  //noForcedErrors = json["noForcedErrors"];

  toJson({
    String? playerId,
    String? seasonId,
    String? playerTrackerId,
  }) =>
      {
        "playerId": playerId,
        "playerTrackerId": playerTrackerId,
        "seasonId": seasonId,
        "isDouble": isDouble,
        "pointsWon": pointsWon,
        "pointsWonServing": pointsWonServing,
        "pointsWonReturning": pointsWonReturning,
        "pointsLost": pointsLost,
        "pointsLostReturning": pointsLostReturning,
        "pointsLostServing": pointsLostServing,
        "saveBreakPtsChances": saveBreakPtsChances,
        "breakPtsSaved": breakPtsSaved,
        // serv
        "gamesWonServing": gamesWonServing,
        "gamesLostServing": gamesLostServing,
        "pointsWinnedFirstServ": pointsWinnedFirstServ,
        "pointsWinnedSecondServ": pointsWinnedSecondServ,
        "firstServIn": firstServIn,
        "secondServIn": secondServIn,
        "aces": aces,
        "dobleFaults": dobleFaults,
        "firstServWon": firstServWon,
        "secondServWon": secondServWon,
        // return
        "pointsWinnedFirstReturn": pointsWinnedFirstReturn,
        "pointsWinnedSecondReturn": pointsWinnedSecondReturn,
        "firstReturnIn": firstReturnIn,
        "secondReturnIn": secondReturnIn,
        "firstReturnOut": firstReturnOut,
        "secondReturnOut": secondReturnOut,
        "firstReturnWon": firstReturnWon,
        "secondReturnWon": secondReturnWon,
        "firstReturnWinner": firstReturnWinner,
        "secondReturnWinner": secondReturnWinner,
        // place
        "meshPointsWon": meshPointsWon,
        "meshPointsLost": meshPointsLost,
        "meshError": meshError,
        "meshWinner": meshWinner,
        "bckgPointsWon": bckgPointsWon,
        "bckgPointsLost": bckgPointsLost,
        "bckgError": bckgError,
        "bckgWinner": bckgWinner,
        //"winners": winners,
        //"noForcedErrors": noForcedErrors,
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
           ''';
  }
}
