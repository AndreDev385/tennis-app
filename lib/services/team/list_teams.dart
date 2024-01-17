import 'dart:convert';

import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<TeamDto>>> listTeams(String clubId) async {
  try {
    final response = await Api.get('/team/by-club/$clubId');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> rawList = jsonDecode(response.body);

    List<TeamDto> list = rawList.map((e) => TeamDto.fromJson(e)).toList();

    return Result.ok(list);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
