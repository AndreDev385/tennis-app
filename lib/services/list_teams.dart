import 'dart:convert';

import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/club_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/list_clubs.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<TeamDto>>> listTeams() async {
  final result = await listClubs({'isSubscribed': 'true'});

  if (result.isFailure) {
    return Result.fail(result.error!);
  }

  final clubs = result.getValue();

  ClubDto subscribedClub = clubs[0];
  final response = await Api.get('/team/by-club/${subscribedClub.clubId}');

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  List<dynamic> rawList = jsonDecode(response.body);

  print("rawList: $rawList");

  List<TeamDto> list = rawList.map((e) => TeamDto.fromJson(e)).toList();

  return Result.ok(list);
}
