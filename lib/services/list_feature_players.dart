import 'dart:convert';

import 'package:tennis_app/dtos/feature_player_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<FeaturePlayerDto>>> listFeaturePlayers({
  required String teamId,
  String? seasonId,
  String? journey,
}) async {
  try {
    Map<String, String> queryMap = {
      "teamId": teamId,
    };

    if (seasonId != null && seasonId.isNotEmpty) {
      queryMap["seasonId"] = seasonId;
    }

    if (journey != null && journey.isNotEmpty) {
      queryMap["journey"] = journey;
    }

    String query = mapQueryToUrlString(queryMap);

    final response = await Api.get("team/feature-players$query");

    if (response.statusCode != 200) {
      print(jsonDecode(response.body));
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> rawList = jsonDecode(response.body);

    List<FeaturePlayerDto> list =
        rawList.map((e) => FeaturePlayerDto.fromJson(e)).toList();

    return Result.ok(list);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
