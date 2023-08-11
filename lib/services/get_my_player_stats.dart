import 'dart:convert';

import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<dynamic>> getMyPlayerStats({bool? last3, String? season}) async {
  Map<String, dynamic> obj = {};
  if (season != null) {
    obj['season'] = season;
  }

  if (last3 == true) {
    obj['last3'] = last3;
  }

  final query = mapQueryToUrlString(obj);

  final response = await Api.get('player/stats$query');

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  PlayerTrackerDto stats = PlayerTrackerDto.fromJson(jsonDecode(response.body));

  return Result.ok(stats);
}
