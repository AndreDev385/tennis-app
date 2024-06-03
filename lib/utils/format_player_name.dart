import 'package:get/get_utils/get_utils.dart';

import '../dtos/player_dto.dart';

String formatPlayerDtoName(PlayerDto player) {
  return "${player.user.firstName} ${player.user.lastName}";
}

String formatInitials(String first, String last) {
  return "${first[0]}${last[0]}";
}

String formatName(String firstName, String lastName) {
  String splitFirstName = firstName.split(" ")[0];

  return "${splitFirstName.capitalizeFirst} ${lastName.capitalizeFirst}";
}

String shortNameFormat(String firstName, String lastName) {
  String splitFirstName = firstName.split(" ")[0];
  String splitLastName = lastName.split(" ")[0];

  return "$splitFirstName ${splitLastName[0].capitalize}.";
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
