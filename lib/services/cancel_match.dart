import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> cancelMatch(Map<String, dynamic> data) async {
  data['tracker'] = jsonEncode(data['tracker']);
  data['sets'] = jsonEncode(data['sets']);
  data['superTieBreak'] = jsonEncode(data['superTieBreak']);
  final response = await Api.put("match/cancel", data);

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }
  return Result.ok(jsonDecode(response.body)['message']);
}
