import 'package:tennis_app/dtos/player_dto.dart';

String formatPlayerName(PlayerDto player) {
  return "${player.user.firstName} ${player.user.lastName}";
}
