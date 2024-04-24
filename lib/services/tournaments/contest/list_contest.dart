import 'dart:convert';

import '../../../dtos/tournaments/contest.dart';
import '../../api.dart';
import '../../utils.dart';

Future<Result<List<Contest>>> listContest(String tournamentId) async {
  try {
    String query = mapQueryToUrlString({
      'tournamentId': tournamentId,
    });

    final response = await Api.get('tournament/contest$query');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> raw = jsonDecode(response.body);

    print(raw);

    final contest = raw.map((e) {
      return Contest.fromJson(e);
    }).toList();

    return Result.ok(contest);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
