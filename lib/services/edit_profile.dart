import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/get_my_user_data.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> editProfile(Map<String, String> data) async {
  try {
    final response = await Api.put('users/', data);

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    await getMyUserData();

    return Result.ok(jsonDecode(response.body)['message']);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
