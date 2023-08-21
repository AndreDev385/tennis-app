import 'dart:convert';

import 'package:tennis_app/dtos/news_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<NewDto>>> listNews(Map<String, String> query) async {
  try {
    String urlQuery = mapQueryToUrlString(query);

    final response = await Api.get('event$urlQuery');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> rawList = jsonDecode(response.body);

    List<NewDto> list = rawList.map((e) => NewDto.fromJson(e)).toList();

    return Result.ok(list);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
