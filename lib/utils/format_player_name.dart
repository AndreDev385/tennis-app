import 'package:tennis_app/dtos/player_dto.dart';

String formatPlayerDtoName(PlayerDto player) {
  return "${player.user.firstName} ${player.user.lastName}";
}

String formatPlayerName(String? name) {
  if (name == null || name == "") {
    return "";
  }

  final splitNames = name.split(" ");

  if (splitNames.length == 1) {
    return splitNames[0];
  }

  if (splitNames.length <= 2) {
    return "${splitNames[0]} ${splitNames[1][0]}.";
  }

  if (splitNames[2].trim().isEmpty) {
    return "${splitNames[0]} ${splitNames[1][0]}.";
  }

  return "${splitNames[0]} ${splitNames[2][0]}.";
}
