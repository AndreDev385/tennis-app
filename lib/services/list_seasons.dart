import 'dart:convert';

import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<SeasonDto>>> listSeasons(Map<String, String> query) async {
  try {
    String queryUrl = mapQueryToUrlString(query);

    final response = await Api.get("season$queryUrl");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    StorageHandler st = await createStorageHandler();

    st.saveSeasons(response.body);

    List<dynamic> rawList = jsonDecode(response.body);

    List<SeasonDto> list = rawList.map((e) => SeasonDto.fromJson(e)).toList();

    return Result.ok(list);
  } catch (e) {
    return Result.fail("Error al cargar temporadas");
  }
}
