import 'dart:convert';

import 'package:tennis_app/domain/tournament/participant.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<PaginateResponse<Participant>>> paginateParticipants({
  List<String>? participantIds,
  int? offset,
  int? limit,
}) async {
  try {
    String query = "";
    Map<String, dynamic> q = {};

    if (offset != null) {
      q['offset'] = "$offset";
    }

    if (limit != null) {
      q['limit'] = "$limit";
    }

    if (participantIds != null) {
      q['participantId'] = participantIds;
    }

    query = mapQueryToUrlString(q);

    final response = await Api.get("participant$query");

    final body = jsonDecode(response.body);

    print("$body \n ${body['rows']}");

    if (response.statusCode != 200) {
      return Result.fail(body['message']);
    }

    List<Participant> list = (body['rows'] as List<dynamic>).map((r) {
      return Participant.fromJson(r);
    }).toList();

    return Result.ok(PaginateResponse(rows: list, count: body['count']));
  } catch (e, s) {
    print("$e $s");
    return Result.fail("Ha ocurrido un error");
  }
}
