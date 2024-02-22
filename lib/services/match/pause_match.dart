import 'dart:convert';

import 'package:tennis_app/environment.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

const apiUrl = Environment.apiUrl;

Future<Result<dynamic>> pauseMatch(Map<String, dynamic> data) async {
  try {
    data["setsQuantity"] = jsonEncode(data["setsQuantity"]);
    data["gamesPerSet"] = jsonEncode(data["gamesPerSet"]);
    data["superTiebreak"] = jsonEncode(data["superTiebreak"]);
    data["tracker"] = jsonEncode(data["tracker"]);
    data["initialTeam"] = jsonEncode(data["initialTeam"]);
    data["doubleServeFlow"] = jsonEncode(data["doubleServeFlow"]);
    data["singleServeFlow"] = jsonEncode(data["singleServeFlow"]);
    data["sets"] = jsonEncode(data["sets"]);
    data["currentSetIdx"] = jsonEncode(data["currentSetIdx"]);
    data["currentGame"] = jsonEncode(data["currentGame"]);
    data["setsWon"] = jsonEncode(data["setsWon"]);
    data["setsLost"] = jsonEncode(data["setsLost"]);
    data["matchWon"] = jsonEncode(data["matchWon"]);
    data["matchFinish"] = jsonEncode(data["matchFinish"]);

    final response = await Api.put("match/pause", data);
    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok(jsonDecode(response.body)['message']);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
