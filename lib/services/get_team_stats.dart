import 'dart:convert';

import 'package:tennis_app/dtos/team_stats.dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<TeamStatsDto>> getTeamStats(
  String journey,
  String season,
  String teamId,
) async {

  String query = mapQueryToUrlString({
    'journey': journey,
    'season': season,
    'teamId': teamId,
  });

  final response = await Api.get("team/stats$query");

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  List<dynamic> rawList = jsonDecode(response.body);

  if (rawList.isEmpty) {
    return Result.fail(
      "No se encontraron estadisticas con los valores seleccionados",
    );
  }

  TeamStatsDto teamStats = TeamStatsDto.fromJson(rawList[0]);

  return Result.ok(teamStats);
}
