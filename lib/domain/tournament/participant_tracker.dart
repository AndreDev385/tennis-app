import '../shared/utils.dart';

class ParticipantStats {
  String participantTrackerId;
  String participantId;
  String tournamentId;
  String matchId;

  bool isDouble;
  //break points saved - rival break points
  int saveBreakPtsChances;
  int breakPtsSaved;
  int breakPtsChances;
  int breakPts;

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
  int gamesWonReturning;
  int gamesLostReturning;
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
  // rally
  int shortRallyWon;
  int shortRallyLost;
  int mediumRallyWon;
  int mediumRallyLost;
  int longRallyWon;
  int longRallyLost;

  ParticipantStats({
    required this.participantTrackerId,
    required this.participantId,
    required this.tournamentId,
    required this.matchId,
    required this.isDouble,
    this.saveBreakPtsChances = 0,
    this.breakPtsSaved = 0,
    this.breakPtsChances = 0,
    this.breakPts = 0,
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
    this.gamesWonReturning = 0,
    this.gamesLostReturning = 0,
    // place
    this.meshPointsWon = 0,
    this.meshPointsLost = 0,
    this.meshWinner = 0,
    this.meshError = 0,
    this.bckgPointsWon = 0,
    this.bckgPointsLost = 0,
    this.bckgWinner = 0,
    this.bckgError = 0,
    // rally
    this.shortRallyWon = 0,
    this.mediumRallyWon = 0,
    this.longRallyWon = 0,
    this.shortRallyLost = 0,
    this.mediumRallyLost = 0,
    this.longRallyLost = 0,
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

  void rivalBreakPoint() {
    saveBreakPtsChances++;
  }

  void saveBreakPt() {
    breakPtsSaved++;
  }

  void chanceToBreakPt() {
    breakPtsChances++;
  }

  void breakPtWon() {
    breakPts++;
  }

  void winGameServing() {
    gamesWonServing++;
  }

  void loseGameServing() {
    gamesLostServing++;
  }

  void winGameReturning() {
    gamesWonReturning++;
  }

  void loseGameReturning() {
    gamesLostReturning++;
  }

  // Saque no devuelto
  void serviceWonPoint({required bool isFirstServe}) {
    if (isFirstServe) {
      pointsWinnedFirstServ++;
      firstServIn++;
      firstServWon++;
      return;
    }
    secondServIn++;
    secondServWon++;
    pointsWinnedSecondServ++;
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

  void rallyPoint({required int rally, required bool winPoint}) {
    if (rally < Rally.short) {
      winPoint ? this.shortRallyWon++ : this.shortRallyLost++;
    }
    if (rally >= Rally.short && rally < Rally.medium) {
      winPoint ? this.mediumRallyWon++ : this.mediumRallyLost++;
    }
    if (rally >= Rally.medium) {
      winPoint ? this.longRallyWon++ : this.longRallyLost++;
    }
  }

  ParticipantStats clone() {
    return ParticipantStats(
      participantTrackerId: participantTrackerId,
      participantId: participantId,
      tournamentId: tournamentId,
      matchId: matchId,
      isDouble: isDouble,

      saveBreakPtsChances: saveBreakPtsChances,
      breakPtsSaved: breakPtsSaved,
      breakPts: breakPts,
      breakPtsChances: breakPtsChances,
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
      gamesWonReturning: gamesWonReturning,
      gamesLostReturning: gamesWonReturning,
      //place
      meshWinner: meshWinner,
      meshError: meshError,
      meshPointsWon: meshPointsWon,
      meshPointsLost: meshPointsLost,
      bckgWinner: bckgWinner,
      bckgError: bckgError,
      bckgPointsWon: bckgPointsWon,
      bckgPointsLost: bckgPointsLost,

      shortRallyWon: shortRallyWon,
      shortRallyLost: shortRallyLost,
      mediumRallyWon: mediumRallyWon,
      mediumRallyLost: mediumRallyLost,
      longRallyWon: longRallyWon,
      longRallyLost: longRallyLost,
    );
  }

  ParticipantStats.fromJson(Map<String, dynamic> json)
      : participantTrackerId = json['participantTrackerId'],
        participantId = json['participantId'],
        tournamentId = json['tournamentId'],
        matchId = json['matchId'],

        isDouble = json['isDouble'],
        saveBreakPtsChances = json['saveBreakPtsChances'],
        breakPtsSaved = json['breakPtsSaved'],
        breakPtsChances = json['breakPtsChances'],
        breakPts = json['breakPts'],
        gamesWonServing = json['gamesWonServing'],
        gamesLostServing = json['gamesLostServing'],
        pointsWinnedFirstServ = json['pointsWinnedFirstServ'],
        pointsWinnedSecondServ = json['pointsWinnedSecondServ'],
        firstServIn = json['firstServIn'],
        secondServIn = json['secondServIn'],
        aces = json['aces'],
        dobleFaults = json['dobleFaults'],
        firstServWon = json['firstServWon'],
        secondServWon = json['secondServWon'],
        pointsWinnedFirstReturn = json['pointsWinnedFirstReturn'],
        pointsWinnedSecondReturn = json['pointsWinnedSecondReturn'],
        firstReturnWon = json['firstReturnWon'],
        secondReturnWon = json['secondReturnWon'],
        firstReturnWinner = json['firstReturnWinner'],
        secondReturnWinner = json['secondReturnWinner'],
        firstReturnIn = json['firstReturnIn'],
        secondReturnIn = json['secondReturnIn'],
        firstReturnOut = json['firstReturnOut'],
        secondReturnOut = json['secondReturnOut'],
        gamesWonReturning = json['gamesWonReturning'],
        gamesLostReturning = json['gamesLostReturning'],
        meshPointsWon = json['meshPointsWon'],
        meshPointsLost = json['meshPointsLost'],
        meshWinner = json['meshWinner'],
        meshError = json['meshError'],
        bckgPointsWon = json['bckgPointsWon'],
        bckgPointsLost = json['bckgPointsLost'],
        bckgWinner = json['bckgWinner'],
        bckgError = json['bckgError'],
        shortRallyWon = json['shortRallyWon'],
        mediumRallyWon = json['mediumRallyWon'],
        longRallyWon = json['longRallyWon'],
        shortRallyLost = json['shortRallyLost'],
        mediumRallyLost = json['mediumRallyLost'],
        longRallyLost = json['longRallyLost'];

  ParticipantStats.skeleton()
      : participantTrackerId = "",
        participantId = "",
        tournamentId = "",
        matchId = "",
        isDouble = false,
        saveBreakPtsChances = 0,
        breakPtsSaved = 0,
        breakPtsChances = 0,
        breakPts = 0,
        gamesWonServing = 0,
        gamesLostServing = 0,
        pointsWinnedFirstServ = 0,
        pointsWinnedSecondServ = 0,
        firstServIn = 0,
        secondServIn = 0,
        aces = 0,
        dobleFaults = 0,
        firstServWon = 0,
        secondServWon = 0,
        pointsWinnedFirstReturn = 0,
        pointsWinnedSecondReturn = 0,
        firstReturnWon = 0,
        secondReturnWon = 0,
        firstReturnWinner = 0,
        secondReturnWinner = 0,
        firstReturnIn = 0,
        secondReturnIn = 0,
        firstReturnOut = 0,
        secondReturnOut = 0,
        gamesWonReturning = 0,
        gamesLostReturning = 0,
        meshPointsWon = 0,
        meshPointsLost = 0,
        meshWinner = 0,
        meshError = 0,
        bckgPointsWon = 0,
        bckgPointsLost = 0,
        bckgWinner = 0,
        bckgError = 0,
        shortRallyWon = 0,
        mediumRallyWon = 0,
        longRallyWon = 0,
        shortRallyLost = 0,
        mediumRallyLost = 0,
        longRallyLost = 0;

  toJson() {
    return {
      'participantTrackerId': participantTrackerId,
      'participantId': participantId,
      'tournamentId': tournamentId,
      'matchId': matchId,
      'isDouble': isDouble,
      'saveBreakPtsChances': saveBreakPtsChances,
      'breakPtsSaved': breakPtsSaved,
      'breakPtsChances': breakPtsChances,
      'breakPts': breakPts,
      'gamesWonServing': gamesWonServing,
      'gamesLostServing': gamesLostServing,
      'pointsWinnedFirstServ': pointsWinnedFirstServ,
      'pointsWinnedSecondServ': pointsWinnedSecondServ,
      'firstServIn': firstServIn,
      'secondServIn': secondServIn,
      'aces': aces,
      'dobleFaults': dobleFaults,
      'firstServWon': firstServWon,
      'secondServWon': secondServWon,
      'pointsWinnedFirstReturn': pointsWinnedFirstReturn,
      'pointsWinnedSecondReturn': pointsWinnedSecondReturn,
      'firstReturnWon': firstReturnWon,
      'secondReturnWon': secondReturnWon,
      'firstReturnWinner': firstReturnWinner,
      'secondReturnWinner': secondReturnWinner,
      'firstReturnIn': firstReturnIn,
      'secondReturnIn': secondReturnIn,
      'firstReturnOut': firstReturnOut,
      'secondReturnOut': secondReturnOut,
      'gamesWonReturning': gamesWonReturning,
      'gamesLostReturning': gamesLostReturning,
      'meshPointsWon': meshPointsWon,
      'meshPointsLost': meshPointsLost,
      'meshWinner': meshWinner,
      'meshError': meshError,
      'bckgPointsWon': bckgPointsWon,
      'bckgPointsLost': bckgPointsLost,
      'bckgWinner': bckgWinner,
      'bckgError': bckgError,
      'shortRallyWon': shortRallyWon,
      'mediumRallyWon': mediumRallyWon,
      'longRallyWon': longRallyWon,
      'shortRallyLost': shortRallyLost,
      'mediumRallyLost': mediumRallyLost,
      'longRallyLost': longRallyLost,
    };
  }
}
