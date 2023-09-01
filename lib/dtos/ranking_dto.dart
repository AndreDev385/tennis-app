import 'package:tennis_app/dtos/clash_dtos.dart';

class RankingDto {
  final String rankingId;
  final String position;
  final TeamDto team;
  final String seasonId;
  final String symbol;

  const RankingDto({
    required this.position,
    required this.rankingId,
    required this.seasonId,
    required this.team,
    required this.symbol
  });

  RankingDto.fromJson(Map<String, dynamic> json)
      : position = json['position'],
        rankingId = json['rankingId'],
        symbol = json['symbol'],
        team = TeamDto.fromJson(json['team']),
        seasonId = json['seasonId'];
}
