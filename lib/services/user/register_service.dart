import 'dart:convert';

import 'package:tennis_app/services/api.dart';

class RegisterResponse {
  final String message;
  final bool success;

  const RegisterResponse({required this.message, required this.success});

  factory RegisterResponse.fromJson(Map<String, dynamic> json, bool success) {
    return RegisterResponse(message: json['message'], success: success);
  }
}

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String ci;
  final String? code;

  const RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.ci,
    required this.password,
    this.code,
  });

  toJson() {
    Map<String, String> obj = {};

    obj['firstName'] = firstName;
    obj['lastName'] = lastName;
    obj['email'] = email;
    obj['password'] = password;
    obj['ci'] = ci;

    return obj;
  }
}

Future<RegisterResponse> register(RegisterRequest data) async {
  final response = await Api.post('users', data.toJson());

  return RegisterResponse.fromJson(
      jsonDecode(response.body), response.statusCode == 200);
}
