import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> deleteUserAccount() async {
  try {
    final response = await Api.put("users/delete", {});

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok("Usuario eliminado con éxito");
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
