import 'dart:convert';

import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/utils.dart';

import "../api.dart";

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

Future<Result<LoginResponse>> login(LoginRequest data) async {
  try {
    var body = data.toJson();

    final response = await Api.post("users/login", body);

    if (response.statusCode == 400 || response.statusCode == 500) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    StorageHandler st = await createStorageHandler();

    st.saveToken(jsonDecode(response.body)["access_token"]);

    LoginResponse res = LoginResponse(
        statusCode: response.statusCode,
        accessToken: jsonDecode(response.body)['access_token']);

    return Result.ok(res);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
