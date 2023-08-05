import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> changeForgottenPassword(Map<String, String> body) async {
  final response = await Api.post("users/change-forgotten-password", body);

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  return Result.ok(jsonDecode(response.body)['message']);
}
