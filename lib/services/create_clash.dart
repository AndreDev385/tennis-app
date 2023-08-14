import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result> createClash(CreateClashDto data) async {
  final response = await Api.post("clash", data.toJson());

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  return Result.ok(jsonDecode(response.body)['clashId']);
}

class CreateClashDto {
  final String categoryId;
  final TeamForClash team1;
  final TeamForClash team2;
  final String journey;
  final String host;

  const CreateClashDto({
    required this.categoryId,
    required this.team1,
    required this.team2,
    required this.journey,
    required this.host,
  });

  toJson() => {
        'categoryId': categoryId,
        'team1Name': team1.name,
        'team1ClubId': team1.clubId,
        'team2Name': team2.name,
        'team2ClubId': team2.clubId,
        'journey': journey,
        'host': host,
      };
}

class TeamForClash {
  final String name;
  final String clubId;

  const TeamForClash({required this.name, required this.clubId});
}
