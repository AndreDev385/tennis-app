import 'dart:convert';

import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<MatchDto>> getMatchById(String matchId) async {
  try {
    final response = await Api.get("match/$matchId");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    MatchDto match = MatchDto.fromJson(jsonDecode(response.body));

    return Result.ok(match);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
