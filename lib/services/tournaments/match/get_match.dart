import 'dart:convert';

import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<TournamentMatch>> getMatch(Map<String, String> q) async {
  try {
    final query = mapQueryToUrlString(q);

    final response = await Api.get('tournament/match$query');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    TournamentMatch match = TournamentMatch.fromJson(jsonDecode(response.body));

    return Result.ok(match);
  } catch (e) {
    print(e);
    return Result.fail("Ha ocurrido un error");
  }
}
