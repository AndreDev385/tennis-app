import 'dart:convert';

import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<Match>> getPausedMatch(String matchId) async {
  try {
    final response = await Api.get('match/paused/$matchId');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    final body = jsonDecode(response.body);

    Match match = Match.fromJson(body);

    return Result.ok(match);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
