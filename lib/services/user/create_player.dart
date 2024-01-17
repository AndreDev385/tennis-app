import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<String>> createPlayer(Map<String, String> data) async {
  try {
    final response = await Api.post('player', data);

    if (response.statusCode != 201) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok("Jugador subscrito con exito");
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
