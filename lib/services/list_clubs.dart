import 'dart:convert';

import 'package:tennis_app/dtos/club_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<ClubDto>>> listClubs(Map<String, String> queryMap) async {
  try {
    String queryUrl = mapQueryToUrlString(queryMap);

    final response = await Api.get("club$queryUrl");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> rawList = jsonDecode(response.body);

    List<ClubDto> list = rawList.map((e) => ClubDto.fromJson(e)).toList();

    return Result.ok(list);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
