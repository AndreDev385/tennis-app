import 'dart:convert';

import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<dynamic>>> listMatchs(Map<String, String> query) async {
  String queryUrl = mapQueryToUrlString(query);

  final response = await Api.get("match$queryUrl");

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  List<dynamic> rawList = jsonDecode(response.body);

  List<MatchDto> list = rawList.map((e) => MatchDto.fromJson(e)).toList();

  return Result.ok(list);
}
