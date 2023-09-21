class FeaturePlayerDto {
  final String playerId;
  final String firstName;
  final String lastName;
  final int firstServIn;
  final int secondServIn;
  final int dobleFaults;
  final int pointsWinnedFirstServ;
  final int pointsWinnedSecondServe;
  final int meshPointsLost;
  final int meshPointsWon;

  const FeaturePlayerDto({
    required this.playerId,
    required this.firstName,
    required this.lastName,
    required this.firstServIn,
    required this.secondServIn,
    required this.dobleFaults,
    required this.pointsWinnedFirstServ,
    required this.pointsWinnedSecondServe,
    required this.meshPointsLost,
    required this.meshPointsWon,
  });

  FeaturePlayerDto.fromJson(Map<String, dynamic> json)
      : playerId = json["playerId"],
        firstName = json['firstName'],
        lastName = json["lastName"],
        firstServIn = json["firstServIn"],
        secondServIn = json['secondServIn'],
        dobleFaults = json['dobleFaults'],
        pointsWinnedFirstServ = json["pointsWinnedFirstServ"],
        pointsWinnedSecondServe = json["pointsWinnedSecondServe"],
        meshPointsLost = json["meshPointsLost"],
        meshPointsWon = json["meshPointsWon"];

  toJson() => {
        "playerId": playerId,
        "firstName": firstName,
        "lastName": lastName,
        "firstServIn": firstServIn,
        "secondServIn": secondServIn,
        "dobleFaults": dobleFaults,
        "pointsWinnedFirstServ": pointsWinnedFirstServ,
        "meshPointsLost": meshPointsLost,
        "meshPointsWon": meshPointsWon,
      };
}
