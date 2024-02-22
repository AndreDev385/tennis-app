import 'dart:convert';

import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future addDevice(String token) async {
  try {
    final response = await Api.put("/player/device", {'token': token});

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    return Result.ok("");
  } catch (e) {
    return Result.fail("Error al agregar dispositivo");
  }
}
