import 'dart:convert';

import 'package:tennis_app/dtos/tournaments/contest_clash.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<PaginateResponse<ContestClash>>> paginateContestClashes(
  Map<String, String> q,
) async {
  try {
    var query = mapQueryToUrlString(q);

    final response = await Api.get("contest/clash$query");

    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      return Result.fail(body['message']);
    }

    List<dynamic> list = body['rows'];

    List<ContestClash> clashes = list.map((r) {
      return ContestClash.fromJson(r);
    }).toList();

    return Result.ok(PaginateResponse(count: body['count'], rows: clashes));
  } catch (e, s) {
    print("$e\n$s\b");
    return Result.fail("Ha ocurrido un error");
  }
}
