class PlayerName {
  final String firstName;
  final String lastName;

  const PlayerName({
    required this.firstName,
    required this.lastName,
  });

  PlayerName.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'];
}

class FeatureCoupleDto {
  final PlayerName player;
  final PlayerName partner;
  final int meshPointsWon;
  final int meshPointsLost;
  final int firstServIn;
  final int secondServIn;
  final int dobleFaults;
  final int pointsWinnedFirstServ;
  final int pointsWinnedSecondServe;
  final int winBreakPtsChances;
  final int breakPtsWinned;

  const FeatureCoupleDto({
    required this.player,
    required this.partner,
    required this.meshPointsWon,
    required this.meshPointsLost,
    required this.firstServIn,
    required this.secondServIn,
    required this.dobleFaults,
    required this.pointsWinnedFirstServ,
    required this.pointsWinnedSecondServe,
    required this.winBreakPtsChances,
    required this.breakPtsWinned,
  });

  FeatureCoupleDto.fromJson(Map<String, dynamic> json)
      : player = PlayerName.fromJson(json['player']),
        partner = PlayerName.fromJson(json['partner']),
        meshPointsWon = json['meshPointsWon'],
        meshPointsLost = json['meshPointsLost'],
        firstServIn = json['firstServIn'],
        secondServIn = json['secondServIn'],
        dobleFaults = json['dobleFaults'],
        pointsWinnedFirstServ = json['pointsWinnedFirstServ'],
        pointsWinnedSecondServe = json['pointsWinnedSecondServe'],
        winBreakPtsChances = json['winBreakPtsChances'],
        breakPtsWinned = json['breakPtsWinned'];
}
