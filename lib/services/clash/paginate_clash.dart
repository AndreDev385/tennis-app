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
      print(jsonDecode(response.body));
      return Result.fail(jsonDecode(response.body)['message']);
    }

    final json = jsonDecode(response.body);

    final rows = (json['rows'] as List<dynamic>)
        .map((r) => ClashDto.fromJson(r))
        .toList();

    final result = PaginateResponse<ClashDto>(
      count: json['count'],
      rows: rows,
    );

    return Result.ok(result);
  } catch (e, s) {
    print("$e $s");
    return Result.fail("Ha ocurrido un error");
  }
}
