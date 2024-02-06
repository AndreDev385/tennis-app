import 'dart:convert';

import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<dynamic>> getPlayerData() async {
  try {
    final response = await Api.get('player/me');

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    StorageHandler st = await createStorageHandler();

    st.savePlayer(response.body);

    PlayerDto player = PlayerDto.fromJson(jsonDecode(response.body));

    return Result.ok(player);
  } catch (e) {
    return Result.fail("Ha ocurrido un error");
  }
}
