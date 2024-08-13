import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> createBracketClash(String bracketId) async {
  try {
    final response = await Api.post(
      "contest/create-bracket-clash",
      {"bracketId": bracketId},
    );

    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      return Result.fail(body['message']);
    }

    return Result.ok(body['message']);
  } catch (e, s) {
    print("$e\n $s\n");
    return Result.fail("Ha ocurrido un error");
  }
}
