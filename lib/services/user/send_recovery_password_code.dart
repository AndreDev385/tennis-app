import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> sendRecoveryPasswordCode(String email) async {
  try {
    final response = await Api.post("users/forget-password", {"email": email});

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok(jsonDecode(response.body)['message']);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
