import 'dart:convert';

import 'package:tennis_app/dtos/ranking_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<dynamic>> listRankings() async {
  final response = await Api.get("team/rankings");

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  List<dynamic> rawList = jsonDecode(response.body);

  print(rawList);

  List<RankingDto> rankings =
      rawList.map((e) => RankingDto.fromJson(e)).toList();

  return Result.ok(rankings);
}
