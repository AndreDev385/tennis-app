import 'dart:convert';

import '../../api.dart';
import '../../utils.dart';

Future<Result<String>> createBracketMatch(
  String bracketId,
  String surface,
) async {
  try {
    final response = await Api.put("tournament-match/create-bracket-match", {
      'bracketId': bracketId,
      'surface': surface,
    });

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok("Partido creado");
  } catch (e) {
    print(e);
    return Result.fail("Ha ocurrido un error");
  }
}
