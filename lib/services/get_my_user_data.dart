import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/services/api.dart';

class GetUserDataResponse {
  final int statusCode;
  final String? message;

  const GetUserDataResponse({
    required this.statusCode,
    this.message,
  });
}

Future<GetUserDataResponse> getMyUserData() async {
  final response = await Api.get('users/me');

  if (response.statusCode != 200) {
    return GetUserDataResponse(
      statusCode: response.statusCode,
      message: jsonDecode(response.body),
    );
  }

  SharedPreferences storage = await SharedPreferences.getInstance();

  storage.setString("user", response.body);

  return GetUserDataResponse(statusCode: response.statusCode);
}
