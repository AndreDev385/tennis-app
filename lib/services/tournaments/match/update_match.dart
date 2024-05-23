import 'dart:convert';

import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> updateMatch(
  TournamentMatch match,
  MatchStatuses status,
) async {
  try {
    Map<String, dynamic> data = match.toJson();

    data['status'] = status.index;

    final response = await Api.put(
      "tournament-match",
      {'data': jsonEncode(data)},
    );

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    switch (status) {
      case MatchStatuses.Paused:
        return Result.ok("Partido pausado");

      case MatchStatuses.Canceled:
        return Result.ok("Partido cancelado");

      case MatchStatuses.Finished:
        return Result.ok("Partido finalizado con exito");

      // live
      default:
        return Result.ok("Partido iniciado");
    }
  } catch (e, s) {
    print("$e $s");
    return Result.fail("Ha ocurrido un error");
  }
}
