import 'dart:convert';

import '../../../dtos/tournaments/contest.dart';
import '../../api.dart';
import '../../utils.dart';

Future<Result<Contest>> getContest(String contestId) async {
  try {
    final response = await Api.get('contest/$contestId');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    dynamic raw = jsonDecode(response.body);

    Contest contest = Contest.fromJson(raw);

    return Result.ok(contest);
  } catch (e, s) {
    print("$e $s get contest");
    return Result.fail("Ha ocurrido un error");
  }
}
