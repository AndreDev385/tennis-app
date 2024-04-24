import 'dart:convert';

import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<PaginateResponse<ClashDto>>> paginateClash(
  Map<String, dynamic> query,
) async {
  try {
    String queryUrl = mapQueryToUrlString(query);

    final response = await Api.get("clash/paginate$queryUrl");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    final json = jsonDecode(response.body);

    final result = PaginateResponse<ClashDto>(
      count: json['count'],
      rows: json['rows'].map((r) => ClashDto.fromJson(r)).toList(),
    );

    return Result.ok(result);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
