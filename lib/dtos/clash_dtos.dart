class ClashDto {
  String seasonId;
  String clashId;
  String categoryName;
  TeamDto team1;
  TeamDto team2;
  String journey;
  String host;
  bool isFinish;

  ClashDto({
    required this.seasonId,
    required this.clashId,
    required this.categoryName,
    required this.team1,
    required this.team2,
    required this.journey,
    required this.host,
    required this.isFinish,
  });

  ClashDto.fromJson(Map<String, dynamic> json)
      : seasonId = json['seasonId'],
        clashId = json['clashId'],
        categoryName = json['category'],
        team1 = TeamDto.fromJson(json['team1']),
        team2 = TeamDto.fromJson(json['team2']),
        journey = json['journey'],
        host = json['host'],
        isFinish = json['isFinish'];
}

class TeamDto {
  String name;
  String clubName;
  String clubSymbol;

  TeamDto({
    required this.name,
    required this.clubName,
    required this.clubSymbol,
  });

  TeamDto.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        clubName = json['clubName'],
        clubSymbol = json['clubSymbol'];
}

