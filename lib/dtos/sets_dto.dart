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

  SetDto({
    required this.myGames,
    required this.rivalGames,
    this.setWon,
    this.stats,
  });

  SetDto.fromJson(Map<String, dynamic> json)
      : myGames = json['myGames'],
        rivalGames = json['rivalGames'],
        setWon = json['setWon'],
        stats =
            json['stats'] != null ? TrackerDto.fromJson(json['stats']) : null;

  toJson() => {
        'myGames': myGames,
        'rivalGames': rivalGames,
        'setWon': setWon,
        'stats': stats,
      };
}
