import 'dart:convert';

import '../../dtos/tournaments/tournament.dart';
import '../api.dart';
import '../utils.dart';

Future<Result<PaginateResponse<Tournament>>> paginateTournaments() async {
  try {
    final response = await Api.get('tournament/');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    Map<String, dynamic> json = jsonDecode(response.body);

    List<Tournament> tournaments = (json['rows'] as List<dynamic>)
        .map((o) => Tournament.fromJson(o))
        .toList();

    return Result.ok(
      PaginateResponse<Tournament>(
        rows: tournaments,
        count: json['count'],
      ),
    );
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
