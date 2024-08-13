import 'dart:convert';

import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<PaginateResponse<TournamentMatch>>> paginateTournamentMatches(
  Map<String, dynamic> q,
) async {
  try {
    String query = mapQueryToUrlString(q);

    final response = await Api.get('tournament-match/pagination$query');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    Map<String, dynamic> json = jsonDecode(response.body);

    List<TournamentMatch> matches = (json['rows'] as List<dynamic>).map((r) {
      return TournamentMatch.fromJson(r);
    }).toList();

    return Result.ok(PaginateResponse<TournamentMatch>(
      rows: matches,
      count: json['count'],
    ));
  } catch (e, s) {
    print("Err: $e $s");
    return Result.fail("Error al cargar los partidos");
  }
}
