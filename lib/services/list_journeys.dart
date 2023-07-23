import 'dart:convert';

import 'package:tennis_app/dtos/journey_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<List<JourneyDto>>> listJourneys() async {
  final response = await Api.get("/utils/journeys");

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  List<dynamic> rawList = jsonDecode(response.body);

  List<JourneyDto> journeys =
      rawList.map((e) => JourneyDto.fromJson(e)).toList();

  return Result.ok(journeys);
}
