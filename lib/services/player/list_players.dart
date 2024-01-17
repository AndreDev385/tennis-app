import 'dart:convert';

import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<PlayerDto>>> listPlayers(
  Map<String, dynamic> queryMap,
) async {
  try {
    String query = mapQueryToUrlString(queryMap);

    final response = await Api.get("/player$query");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> rawList = jsonDecode(response.body);

    List<PlayerDto> list = rawList.map((e) => PlayerDto.fromJson(e)).toList();

    return Result.ok(list);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
