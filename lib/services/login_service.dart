import 'dart:convert';

import "api.dart";

class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  toJson() {
    Map<String, String> obj = {};

    obj['email'] = email;
    obj['password'] = password;

    return obj;
  }
}

class LoginResponse {
  final int statusCode;
  final String message;
  final String accessToken;

  const LoginResponse({
    required this.statusCode,
    this.message = "",
    this.accessToken = "",
  });
}

Future<LoginResponse> login(LoginRequest data) async {
  var body = data.toJson();

  final response = await Api.post("users/login", body);

  print("response: ${jsonDecode(response.body)}");

  LoginResponse res;

  if (response.statusCode == 400 || response.statusCode == 500) {
    res = LoginResponse(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message'],
    );
  } else {
    res = LoginResponse(
        statusCode: response.statusCode,
        accessToken: jsonDecode(response.body)['access_token']);
  }

  return res;
}
