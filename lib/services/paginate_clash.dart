import 'dart:convert';

import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

class ClashPagination {
  int count;
  List<ClashDto> clashes;

  ClashPagination({
    required this.count,
    required this.clashes,
  });

  ClashPagination.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        clashes = (json['rows'] as List<dynamic>)
            .map((r) => ClashDto.fromJson(r))
            .toList();
}

Future<Result<ClashPagination>> paginateClash(
  Map<String, dynamic> query,
) async {
  try {
    String queryUrl = mapQueryToUrlString(query);

    print(queryUrl);

    final response = await Api.get("clash/paginate$queryUrl");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok(ClashPagination.fromJson(jsonDecode(response.body)));
  } catch (e) {
    print(e);
    return Result.fail("Ha ocurrido un error");
  }
}
