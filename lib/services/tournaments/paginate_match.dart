import 'dart:convert';

import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<PaginateResponse<TournamentMatch>>> paginateMatch(
  Map<String, dynamic> q,
) async {
  try {
    String query = mapQueryToUrlString(q);

    final response = await Api.get('tournament/matches-pagination$query');

    print("status code: ${response.statusCode}");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    Map<String, dynamic> json = jsonDecode(response.body);

    List<TournamentMatch> matches = (json['rows'] as List<dynamic>)
        .map((r) => TournamentMatch.fromJson(r))
        .toList();

    return Result.ok(PaginateResponse<TournamentMatch>(
      rows: matches,
      count: json['count'],
    ));
  } catch (e) {
    print(e);
    return Result.fail("Ha ocurrido un error");
  }
}
