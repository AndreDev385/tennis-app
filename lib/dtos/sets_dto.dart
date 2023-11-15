import 'package:tennis_app/dtos/tracker_dto.dart';

class Sets {
  List<SetDto> list;

  Sets({required this.list});

  Sets.fromJson(List<dynamic> json)
      : list = json.map((e) => SetDto.fromJson(e)).toList();

  toJson() => list.map((e) => e.toJson()).toList();
}

class SetDto {
  int myGames;
  int rivalGames;
  bool? setWon;
  TrackerDto? stats;
  bool tiebreak;
  bool superTiebreak;
  int myTiebreakPoints;
  int rivalTiebreakPoints;

  SetDto({
    required this.myGames,
    required this.rivalGames,
    this.setWon,
    this.stats,
    this.tiebreak = false,
    this.superTiebreak = false,
    this.myTiebreakPoints = 0,
    this.rivalTiebreakPoints = 0,
  });

  SetDto.fromJson(Map<String, dynamic> json)
      : myGames = json['myGames'],
        rivalGames = json['rivalGames'],
        setWon = json['setWon'],
        tiebreak = json['tiebreak'] ?? false,
        superTiebreak = json['superTiebreak'] ?? false,
        myTiebreakPoints = json['myTiebreakPoints'] ?? 0,
        rivalTiebreakPoints = json['rivalTiebreakPoints'] ?? 0,
        stats =
            json['stats'] != null ? TrackerDto.fromJson(json['stats']) : null;

  toJson() => {
        'myGames': myGames,
        'rivalGames': rivalGames,
        'setWon': setWon,
        'tiebreak': tiebreak,
        'superTiebreak': superTiebreak,
        'myTiebreakPoints': myTiebreakPoints,
        'rivalTiebreakPoints': rivalTiebreakPoints,
        'stats': stats,
      };

  @override
  String toString() {
    return "tiebreak: $tiebreak\npoints: $myTiebreakPoints, rival: $rivalTiebreakPoints, games: $myGames, rival: $rivalGames";
  }
}
