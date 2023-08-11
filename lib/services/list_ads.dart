import 'dart:convert';

import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<AdDto>>> listAds(Map<String, String> query) async {
  String urlQuery = mapQueryToUrlString(query);

  final response = await Api.get('ads$urlQuery');

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  List<dynamic> rawList = jsonDecode(response.body);

  List<AdDto> list = rawList.map((e) => AdDto.fromJson(e)).toList();

  return Result.ok(list);
}
