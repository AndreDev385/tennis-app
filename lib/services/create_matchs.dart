import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

class CreateMatchsRequest {
  final List<MatchRequest> matchs;
  final String clashId;
  final String surface;
  final String address;

  const CreateMatchsRequest({
    required this.matchs,
    required this.clashId,
    required this.surface,
    required this.address,
  });

  toJson() => {
        'clashId': clashId,
        'surface': surface,
        'address': address,
        'matchs': jsonEncode(matchs.map((e) => e.toJson()).toList())
      };
}

class MatchRequest {
  final String mode;
  final String player1;
  final String player2;
  final String? player3;
  final String? player4;

  const MatchRequest({
    required this.mode,
    required this.player1,
    required this.player2,
    this.player3,
    this.player4,
  });

  toJson() => {
        "mode": mode,
        "player1": player1,
        "player2": player2,
        "player3": player3,
        "player4": player4,
      };
}

Future<Result<dynamic>> createMatchs(CreateMatchsRequest data) async {
  final body = data.toJson();

  final response = await Api.post("match", body);

  if (response.statusCode != 201) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  return Result.ok(null);
}
