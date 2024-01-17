import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> changePassword(String newPassword) async {
  try {
    final response =
        await Api.put("users/change-password", {"newPassword": newPassword});

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok(jsonDecode(response.body)['message']);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
