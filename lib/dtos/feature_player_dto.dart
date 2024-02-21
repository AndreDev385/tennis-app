class FeaturePlayerDto {
  final String playerId;
  final String firstName;
  final String lastName;

  final int saveBreakPtsChances;
  final int breakPtsSaved;
  final int gamesWonServing;
  final int gamesLostServing;
  final int pointsWinnedFirstServ;
  final int pointsWinnedSecondServ;
  final int firstServIn;
  final int secondServIn;
  final int firstServWon;
  final int secondServWon;
  final int aces;
  final int dobleFaults;
  final int pointsWinnedFirstReturn;
  final int pointsWinnedSecondReturn;
  final int firstReturnIn;
  final int secondReturnIn;
  final int firstReturnOut;
  final int secondReturnOut;
  final int firstReturnWon;
  final int secondReturnWon;
  final int firstReturnWinner;
  final int secondReturnWinner;
  final int meshPointsWon;
  final int meshPointsLost;
  final int meshWinner;
  final int meshError;
  final int bckgPointsWon;
  final int bckgPointsLost;
  final int bckgWinner;
  final int bckgError;

  const FeaturePlayerDto({
    required this.playerId,
    required this.firstName,
    required this.lastName,
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
    required this.secondReturnWon,
    required this.firstReturnWinner,
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

  FeaturePlayerDto.fromJson(Map<String, dynamic> json)
      : playerId = json["playerId"],
        firstName = json['firstName'],
        lastName = json["lastName"],
        saveBreakPtsChances = json["saveBreakPtsChances"],
        breakPtsSaved = json["breakPtsSaved"],
        gamesWonServing = json["gamesWonServing"],
        gamesLostServing = json["gamesLostServing"],
        pointsWinnedFirstServ = json["pointsWinnedFirstServ"],
        pointsWinnedSecondServ = json["pointsWinnedSecondServ"],
        firstServIn = json["firstServIn"],
        secondServIn = json["secondServIn"],
        firstServWon = json["firstServWon"],
        secondServWon = json["secondServWon"],
        aces = json["aces"],
        dobleFaults = json["dobleFaults"],
        pointsWinnedFirstReturn = json["pointsWinnedFirstReturn"],
        pointsWinnedSecondReturn = json["pointsWinnedSecondReturn"],
        firstReturnIn = json["firstReturnIn"],
        secondReturnIn = json["secondReturnIn"],
        firstReturnOut = json["firstReturnOut"],
        secondReturnOut = json["secondReturnOut"],
        firstReturnWon = json["firstReturnWon"],
        secondReturnWon = json["secondReturnWon"],
        firstReturnWinner = json["firstReturnWinner"],
        secondReturnWinner = json["secondReturnWinner"],
        meshPointsWon = json["meshPointsWon"],
        meshPointsLost = json["meshPointsLost"],
        meshWinner = json["meshWinner"],
        meshError = json["meshError"],
        bckgPointsWon = json["bckgPointsWon"],
        bckgPointsLost = json["bckgPointsLost"],
        bckgWinner = json["bckgWinner"],
        bckgError = json["bckgError"];
}
