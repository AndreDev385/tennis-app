import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

class GetUserDataResponse {
  final int statusCode;
  final String? message;

  const GetUserDataResponse({
    required this.statusCode,
    this.message,
  });
}

Future<Result<GetUserDataResponse>> getMyUserData() async {
  try {
    final response = await Api.get('users/me');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']) ;
    }

    SharedPreferences storage = await SharedPreferences.getInstance();

    storage.setString("user", response.body);

    return Result.ok(GetUserDataResponse(statusCode: response.statusCode));
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
