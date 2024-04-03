class PlayerTrackerDto {
  String playerId;
  String seasonId;
  String playerTrackerId;

  bool isDouble;
  int pointsWon;
  int pointsWonServing;
  int pointsWonReturning;
  int pointsLost;
  int pointsLostReturning;
  int pointsLostServing;
  int saveBreakPtsChances;
  int breakPtsSaved;
  // serv
  int gamesWonServing;
  int gamesLostServing;
  int pointsWinnedFirstServ;
  int pointsWinnedSecondServ;
  int firstServIn;
  int secondServIn;
  int firstServWon;
  int secondServWon;
  int aces;
  int dobleFaults;
  // ret
  int pointsWinnedFirstReturn;
  int pointsWinnedSecondReturn;
  int firstReturnIn;
  int secondReturnIn;
  int firstReturnWon;
  int secondReturnWon;
  int firstReturnWinner;
  int secondReturnWinner;
  int firstReturnOut;
  int secondReturnOut;
  // place
  int meshPointsWon;
  int meshPointsLost;
  int meshWinner;
  int meshError;
  int bckgPointsWon;
  int bckgPointsLost;
  int bckgWinner;
  int bckgError;

  PlayerTrackerDto({
    required this.playerId,
    required this.seasonId,
    required this.playerTrackerId,
    required this.isDouble,
    required this.pointsWon,
    required this.pointsWonServing,
    required this.pointsWonReturning,
    required this.pointsLost,
    required this.pointsLostReturning,
    required this.pointsLostServing,
    required this.saveBreakPtsChances,
    required this.breakPtsSaved,
    required this.gamesWonServing,
    required this.gamesLostServing,
    required this.pointsWinnedFirstServ,
    required this.pointsWinnedSecondServ,
    required this.firstServIn,
    required this.secondServIn,
    required this.firstServWon,
    required this.secondServWon,
    required this.aces,
    required this.dobleFaults,
    required this.pointsWinnedFirstReturn,
    required this.pointsWinnedSecondReturn,
    required this.firstReturnIn,
    required this.secondReturnIn,
    required this.firstReturnOut,
    required this.secondReturnOut,
    required this.firstReturnWon,
    required this.firstReturnWinner,
    required this.secondReturnWon,
    required this.secondReturnWinner,
    required this.meshPointsWon,
    required this.meshPointsLost,
    required this.meshWinner,
    required this.meshError,
    required this.bckgPointsWon,
    required this.bckgPointsLost,
    required this.bckgWinner,
    required this.bckgError,
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

  toJson() => {
        'playerTrackerId': playerTrackerId,
        'playerId': playerId,
        'seasonId': seasonId,
        'isDouble': isDouble,
        'pointsWon': pointsWon,
        'pointsWonServing': pointsWonServing,
        'pointsWonReturning': pointsWonReturning,
        'pointsLost': pointsLost,
        'pointsLostReturning': pointsLostReturning,
        'pointsLostServing': pointsLostServing,
        'saveBreakPtsChances': saveBreakPtsChances,
        'breakPtsSaved': breakPtsSaved,
        'gamesWonServing': gamesWonServing,
        'gamesLostServing': gamesLostServing,
        'pointsWinnedFirstServ': pointsWinnedFirstServ,
        'pointsWinnedSecondServ': pointsWinnedSecondServ,
        'firstServIn': firstServIn,
        'secondServIn': secondServIn,
        'firstServWon': firstServWon,
        'secondServWon': secondServWon,
        'aces': aces,
        'dobleFaults': dobleFaults,
        'pointsWinnedFirstReturn': pointsWinnedFirstReturn,
        'pointsWinnedSecondReturn': pointsWinnedSecondReturn,
        'firstReturnIn': firstReturnIn,
        'secondReturnIn': secondReturnIn,
        'firstReturnOut': firstReturnOut,
        'secondReturnOut': secondReturnOut,
        'firstReturnWon': firstReturnWon,
        'secondReturnWon': secondReturnWon,
        'firstReturnWinner': firstReturnWinner,
        'secondReturnWinner': secondReturnWinner,
        'meshPointsWon': meshPointsWon,
        'meshPointsLost': meshPointsLost,
        'meshError': meshError,
        'meshWinner': meshWinner,
        'bckgPointsWon': bckgPointsWon,
        'bckgPointsLost': bckgPointsLost,
        'bckgError': bckgError,
        'bckgWinner': bckgWinner,
      };

  PlayerTrackerDto.fromJson(Map<String, dynamic> json)
      : playerTrackerId =
            json['playerTrackerId'] != null ? json['playerTrackerId'] : "",
        playerId = json['playerId'] != null ? json['playerId'] : "",
        seasonId = json['seasonId'] != null ? json['seasonId'] : "",
        isDouble = json['isDouble'],
        pointsWon = json['pointsWon'],
        pointsWonServing = json['pointsWonServing'],
        pointsWonReturning = json['pointsWonReturning'],
        pointsLost = json['pointsLost'],
        pointsLostReturning = json['pointsLostReturning'],
        pointsLostServing = json['pointsLostServing'],
        saveBreakPtsChances = json['saveBreakPtsChances'],
        breakPtsSaved = json['breakPtsSaved'],
        gamesWonServing = json['gamesWonServing'],
        gamesLostServing = json['gamesLostServing'],
        pointsWinnedFirstServ = json['pointsWinnedFirstServ'],
        pointsWinnedSecondServ = json['pointsWinnedSecondServ'],
        firstServIn = json['firstServIn'],
        secondServIn = json['secondServIn'],
        firstServWon = json['firstServWon'],
        secondServWon = json['secondServWon'],
        aces = json['aces'],
        dobleFaults = json['dobleFaults'],
        pointsWinnedFirstReturn = json['pointsWinnedFirstReturn'],
        pointsWinnedSecondReturn = json['pointsWinnedSecondReturn'],
        firstReturnIn = json['firstReturnIn'],
        secondReturnIn = json['secondReturnIn'],
        firstReturnOut = json['firstReturnOut'],
        secondReturnOut = json['secondReturnOut'],
        firstReturnWon = json['firstReturnWon'],
        secondReturnWon = json['secondReturnWon'],
        firstReturnWinner = json['firstReturnWinner'],
        secondReturnWinner = json['secondReturnWinner'],
        meshPointsWon = json['meshPointsWon'],
        meshPointsLost = json['meshPointsLost'],
        meshWinner = json['meshWinner'],
        meshError = json['meshError'],
        bckgPointsWon = json['bckgPointsWon'],
        bckgPointsLost = json['bckgPointsLost'],
        bckgWinner = json['bckgWinner'],
        bckgError = json['bckgError'];

  PlayerTrackerDto.empty()
      : playerTrackerId = "",
        playerId = "",
        seasonId = "",
        isDouble = true,
        pointsWon = 0,
        pointsWonServing = 0,
        pointsWonReturning = 0,
        pointsLost = 0,
        pointsLostReturning = 0,
        pointsLostServing = 0,
        saveBreakPtsChances = 0,
        breakPtsSaved = 0,
        gamesWonServing = 0,
        gamesLostServing = 0,
        pointsWinnedFirstServ = 0,
        pointsWinnedSecondServ = 0,
        firstServIn = 0,
        secondServIn = 0,
        firstServWon = 0,
        secondServWon = 0,
        aces = 0,
        dobleFaults = 0,
        pointsWinnedFirstReturn = 0,
        pointsWinnedSecondReturn = 0,
        firstReturnIn = 0,
        secondReturnIn = 0,
        firstReturnOut = 0,
        secondReturnOut = 0,
        firstReturnWon = 0,
        firstReturnWinner = 0,
        secondReturnWon = 0,
        secondReturnWinner = 0,
        meshPointsWon = 0,
        meshPointsLost = 0,
        meshWinner = 0,
        meshError = 0,
        bckgPointsWon = 0,
        bckgPointsLost = 0,
        bckgWinner = 0,
        bckgError = 0;

  // for calculate set stats
  PlayerTrackerDto.calculate({
    required PlayerTrackerDto first,
    required PlayerTrackerDto second,
  })  : playerTrackerId = first.playerTrackerId,
        playerId = first.playerTrackerId,
        seasonId = first.seasonId,
        isDouble = first.isDouble,
        aces = first.aces - second.aces,
        pointsWon = first.pointsWon - second.pointsWon,
        pointsWonServing = first.pointsWonServing - second.pointsWonServing,
        pointsWonReturning =
            first.pointsWonReturning - second.pointsWonReturning,
        pointsLost = first.pointsLost - second.pointsLost,
        pointsLostReturning =
            first.pointsLostReturning - second.pointsLostReturning,
        pointsLostServing = first.pointsLostServing - second.pointsLostServing,
        saveBreakPtsChances =
            first.saveBreakPtsChances - second.saveBreakPtsChances,
        breakPtsSaved = first.breakPtsSaved - second.breakPtsSaved,
        gamesWonServing = first.gamesWonServing - second.gamesWonServing,
        gamesLostServing = first.gamesLostServing - second.gamesLostServing,
        pointsWinnedFirstServ =
            first.pointsWinnedFirstServ - second.pointsWinnedFirstServ,
        pointsWinnedSecondServ =
            first.pointsWinnedSecondServ - second.pointsWinnedSecondServ,
        firstServIn = first.firstServIn - second.firstServIn,
        secondServIn = first.secondServIn - second.secondServIn,
        firstServWon = first.firstServWon - second.firstServWon,
        secondServWon = first.secondServWon - second.secondServWon,
        dobleFaults = first.dobleFaults - second.dobleFaults,
        pointsWinnedFirstReturn =
            first.pointsWinnedFirstReturn - second.pointsWinnedFirstReturn,
        pointsWinnedSecondReturn =
            first.pointsWinnedSecondReturn - second.pointsWinnedSecondReturn,
        firstReturnIn = first.firstReturnIn - second.firstReturnIn,
        secondReturnIn = first.secondReturnIn - second.secondReturnIn,
        firstReturnOut = first.firstReturnOut - second.firstReturnOut,
        secondReturnOut = first.secondReturnOut - second.secondReturnOut,
        firstReturnWon = first.firstReturnWon - second.firstReturnWon,
        secondReturnWon = first.secondReturnWon - second.secondReturnWon,
        firstReturnWinner = first.firstReturnWinner - second.firstReturnWinner,
        secondReturnWinner =
            first.secondReturnWinner - second.secondReturnWinner,
        meshPointsLost = first.meshPointsLost - second.meshPointsLost,
        meshPointsWon = first.meshPointsWon - second.meshPointsWon,
        meshWinner = first.meshWinner - second.meshWinner,
        meshError = first.meshError - second.meshError,
        bckgPointsWon = first.bckgPointsWon - second.bckgPointsWon,
        bckgPointsLost = first.bckgPointsLost - second.bckgPointsLost,
        bckgError = first.bckgError - second.bckgError,
        bckgWinner = first.bckgWinner - second.bckgWinner;
}
