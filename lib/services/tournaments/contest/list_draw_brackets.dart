import 'dart:convert';

import '../../../domain/tournament/bracket.dart';
import '../../api.dart';
import '../../utils.dart';

Future<Result<List<Bracket>>> listDrawBrackets(
  String contestId,
  int? deep,
) async {
  try {
    String query = "";
    if (deep != null) query = mapQueryToUrlString({'deep': deep});

    final response = await Api.get("tournament/brackets/$contestId$query");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> raw = jsonDecode(response.body);

    List<Bracket> list = raw.map((e) {
      return Bracket.fromJson(e);
    }).toList();

    return Result.ok(list);
  } catch (e) {
    print("Error list brackets: $e");
    return Result.fail("Ha ocurrido un error");
  }
}
