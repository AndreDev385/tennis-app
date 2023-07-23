import 'dart:convert';

import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<ClashDto>>> listClash(Map<String, String> query) async {
  String queryUrl = mapQueryToUrlString(query);

  final response = await Api.get("clash$queryUrl");

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  List<dynamic> rawList = jsonDecode(response.body);

  List<ClashDto> list = rawList.map((e) => ClashDto.fromJson(e)).toList();

  return Result.ok(list);
}
