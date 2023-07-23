import 'dart:convert';

import 'package:tennis_app/services/api.dart';

class CreatePlayerRequest {
  final String code;
  final String clubId;

  const CreatePlayerRequest({
    required this.code,
    required this.clubId,
  });

  Map<String, dynamic> toJson() => {'code': code, 'clubId': clubId};
}

class CreatePlayerResponse {
  final int statusCode;
  final String message;

  const CreatePlayerResponse({
    required this.statusCode,
    required this.message,
  });
}

Future<CreatePlayerResponse> createPlayer(CreatePlayerRequest data) async {
  final response = await Api.post('player', data.toJson());

  print("Status: ${response.statusCode} body: ${response.body}");

  return CreatePlayerResponse(
    statusCode: response.statusCode,
    message: jsonDecode(response.body)['message'],
  );
}
