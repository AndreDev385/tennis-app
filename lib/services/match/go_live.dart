import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

class GoLiveRequest {
  final String matchId;

  const GoLiveRequest({required this.matchId});

  toJson() => {'matchId': matchId};
}

Future<Result<String>> goLive(GoLiveRequest request) async {
  try {
    final response = await Api.put("match/go-live", request.toJson());

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok(jsonDecode(response.body)['message']);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
