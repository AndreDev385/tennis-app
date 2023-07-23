import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<CategoryDto>>> listCategories(
  Map<String, String> queryMap,
) async {
  final response = await Api.get("categories${mapQueryToUrlString(queryMap)}");

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  SharedPreferences storage = await SharedPreferences.getInstance();

  if (queryMap.isEmpty) {
    storage.setString("categories", response.body);
  }

  List<dynamic> rawList = jsonDecode(response.body);

  List<CategoryDto> list = rawList.map((e) => CategoryDto.fromJson(e)).toList();

  return Result.ok(list);
}

Future<List<CategoryDto>> getCategoriesFromStorage() async {
  SharedPreferences storage = await SharedPreferences.getInstance();

  List<dynamic> rawList = jsonDecode(storage.getString("categories")!);

  List<CategoryDto> list = rawList.map((e) => CategoryDto.fromJson(e)).toList();

  return list;
}
