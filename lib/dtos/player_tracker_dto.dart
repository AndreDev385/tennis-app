class PlayerTrackerDto {
  String playerId;
  String playerTrackerId;
  int pointsWon;
  int pointsWonServing;
  int pointsWonReturning;
  int pointsLost;
  int pointsLostReturning;
  int pointsLostServing;
  int saveBreakPtsChances;
  int breakPtsSaved;
  int gamesWonServing;
  int gamesLostServing;
  int pointsWinnedFirstServ;
  int pointsWinnedSecondServ;
  int firstServIn;
  int secondServIn;
  int aces;
  int dobleFaults;
  int pointsWinnedFirstReturn;
  int pointsWinnedSecondReturn;
  int firstReturnIn;
  int secondReturnIn;
  int firstReturnOut;
  int secondReturnOut;
  int meshPointsWon;
  int meshPointsLost;
  int bckgPointsWon;
  int bckgPointsLost;
  int winners;
  int noForcedErrors;

  PlayerTrackerDto({
    required this.playerId,
    required this.playerTrackerId,
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
    required this.aces,
    required this.dobleFaults,
    required this.pointsWinnedFirstReturn,
    required this.pointsWinnedSecondReturn,
    required this.firstReturnIn,
    required this.secondReturnIn,
    required this.firstReturnOut,
    required this.secondReturnOut,
    required this.meshPointsWon,
    required this.meshPointsLost,
    required this.bckgPointsWon,
    required this.bckgPointsLost,
    required this.winners,
    required this.noForcedErrors,
  });

  toJson() => {
        'playerTrackerId': playerTrackerId,
        'playerId': playerId,
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
        'aces': aces,
        'dobleFaults': dobleFaults,
        'pointsWinnedFirstReturn': pointsWinnedFirstReturn,
        'pointsWinnedSecondReturn': pointsWinnedSecondReturn,
        'firstReturnIn': firstReturnIn,
        'secondReturnIn': secondReturnIn,
        'firstReturnOut': firstReturnOut,
        'secondReturnOut': secondReturnOut,
        'meshPointsWon': meshPointsWon,
        'meshPointsLost': meshPointsLost,
        'bckgPointsWon': bckgPointsWon,
        'bckgPointsLost': bckgPointsLost,
        'winners': winners,
        'noForcedErrors': noForcedErrors,
      };

  PlayerTrackerDto.fromJson(Map<String, dynamic> json)
      : playerTrackerId =
            json['playerTrackerId'] != null ? json['playerTrackerId'] : "",
        playerId = json['playerId'] != null ? json['playerId'] : "",
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
        aces = json['aces'],
        dobleFaults = json['dobleFaults'],
        pointsWinnedFirstReturn = json['pointsWinnedFirstReturn'],
        pointsWinnedSecondReturn = json['pointsWinnedSecondReturn'],
        firstReturnIn = json['firstReturnIn'],
        secondReturnIn = json['secondReturnIn'],
        firstReturnOut = json['firstReturnOut'],
        secondReturnOut = json['secondReturnOut'],
        meshPointsWon = json['meshPointsWon'],
        meshPointsLost = json['meshPointsLost'],
        bckgPointsWon = json['bckgPointsWon'],
        bckgPointsLost = json['bckgPointsLost'],
        winners = json['winners'],
        noForcedErrors = json['noForcedErrors'];

  PlayerTrackerDto.empty()
      : playerTrackerId = "",
        playerId = "",
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
        aces = 0,
        dobleFaults = 0,
        pointsWinnedFirstReturn = 0,
        pointsWinnedSecondReturn = 0,
        firstReturnIn = 0,
        secondReturnIn = 0,
        firstReturnOut = 0,
        secondReturnOut = 0,
        meshPointsWon = 0,
        meshPointsLost = 0,
        bckgPointsWon = 0,
        bckgPointsLost = 0,
        winners = 0,
        noForcedErrors = 0;

  // for calculate set stats
  PlayerTrackerDto.calculate({
    required PlayerTrackerDto first,
    required PlayerTrackerDto second,
  })  : playerTrackerId = first.playerTrackerId,
        playerId = first.playerTrackerId,
        meshPointsWon = first.meshPointsWon - second.meshPointsWon,
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
        dobleFaults = first.dobleFaults - second.dobleFaults,
        pointsWinnedFirstReturn =
            first.pointsWinnedFirstReturn - second.pointsWinnedFirstReturn,
        pointsWinnedSecondReturn =
            first.pointsWinnedSecondReturn - second.pointsWinnedSecondReturn,
        firstReturnIn = first.firstReturnIn - second.firstReturnIn,
        secondReturnIn = first.secondReturnIn - second.secondReturnIn,
        firstReturnOut = first.firstReturnOut - second.firstReturnOut,
        secondReturnOut = first.secondReturnOut - second.secondReturnOut,
        meshPointsLost = first.meshPointsLost - second.meshPointsLost,
        bckgPointsWon = first.bckgPointsWon - second.bckgPointsWon,
        bckgPointsLost = first.bckgPointsLost - second.bckgPointsLost,
        winners = first.winners - second.winners,
        noForcedErrors = first.noForcedErrors - second.noForcedErrors;
}
