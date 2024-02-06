import 'dart:convert';

import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<CategoryDto>>> listCategories(
  Map<String, String> queryMap,
) async {
  try {
    final response =
        await Api.get("categories${mapQueryToUrlString(queryMap)}");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    StorageHandler st = await createStorageHandler();

    if (queryMap.isEmpty) {
      st.saveCategories(response.body);
    }

    List<dynamic> rawList = jsonDecode(response.body);

    List<CategoryDto> list =
        rawList.map((e) => CategoryDto.fromJson(e)).toList();

    return Result.ok(list);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}

Future<List<CategoryDto>> getCategoriesFromStorage() async {
  StorageHandler st = await createStorageHandler();

  List<dynamic> rawList = jsonDecode(st.getCategories());

  List<CategoryDto> list = rawList.map((e) => CategoryDto.fromJson(e)).toList();

  return list;
}
