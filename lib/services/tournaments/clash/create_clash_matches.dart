import 'dart:convert';

import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/services/api.dart';
import '../../utils.dart';

class RequestData {
  String clashId;
  List<MatchCreationData> matches;
  String surface;

  RequestData({
    required this.clashId,
    required this.matches,
    required this.surface,
  });
}

class MatchCreationData {
  String? mode;
  String? p1Id;
  String? p2Id;
  String? p3Id;
  String? p4Id;

  MatchCreationData({
    this.mode,
    this.p1Id,
    this.p2Id,
    this.p3Id,
    this.p4Id,
  });
}

createClashMatches(RequestData data) async {
  try {
    Map<String, dynamic> body = {
      "clashId": data.clashId,
      "surface": data.surface,
      "matches": data.matches.map((r) {
        var content = {
          "mode": r.mode,
          "p1Id": r.p1Id,
          "p2Id": r.p2Id,
        };

        if (r.mode == GameMode.double) {
          content['p3Id'] = r.p3Id!;
          content['p4Id'] = r.p4Id!;
        }

        return content;
      }).toList()
    };

    final result = await Api.put('tournament-match/create-clash-matches', body);

    final bodyRes = jsonDecode(result.body);

    if (result.statusCode != 200) {
      return Result.fail(bodyRes['message']);
    }

    return Result.ok(bodyRes['message']);
  } catch (e) {
    return Result.fail("Ha ocurrido un error al crear los partidos");
  }
}
