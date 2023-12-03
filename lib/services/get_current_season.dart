import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

import '../dtos/season_dto.dart';

Future<Result<SeasonDto>> getCurrentSeason() async {
  try {
    String query = mapQueryToUrlString({"isCurrentSeason": "true"});

    final response = await Api.get('season$query');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> rawList = jsonDecode(response.body);

    if (rawList.isEmpty) return Result.fail("No encontrado");

    return Result.ok(SeasonDto.fromJson(rawList[0]));
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
