import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> verifyPasswordCode(String code) async {
  try {
    final response =
        await Api.post("users/validate-password-code", {"code": code});

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok(jsonDecode(response.body)['message']);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
