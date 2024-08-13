import 'dart:convert';

import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<PlayerTrackerDto>> getMyPlayerStats(
  Map<String, dynamic> query,
) async {
  try {
    final queryUrl = mapQueryToUrlString(query);

    final response = await Api.get('player/stats$queryUrl');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    PlayerTrackerDto stats =
        PlayerTrackerDto.fromJson(jsonDecode(response.body));

    return Result.ok(stats);
  } catch (e, s) {
    print("$e\n$s");
    return Result.fail("Error al cargar estadísticas");
  }
}
