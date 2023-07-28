import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<dynamic>> getPlayerData() async {
  final response = await Api.get('player/me');

  if (response.statusCode != 200) {
    return Result.fail(jsonDecode(response.body)['message']);
  }

  SharedPreferences storage = await SharedPreferences.getInstance();

  storage.setString("player", response.body);
  PlayerDto player = PlayerDto.fromJson(jsonDecode(response.body));

  print("json ${jsonDecode(response.body)}");

  print(player);

  return Result.ok(player);
}
