class PlayerDto {
  final String playerId;
  final String clubId;
  final PlayerUserDto user;
  final bool? isDeleted;

  const PlayerDto({
    required this.playerId,
    required this.clubId,
    required this.user,
    this.isDeleted,
  });

  PlayerDto.fromJson(Map<String, dynamic> json)
      : playerId = json['playerId'],
        clubId = json['clubId'],
        isDeleted = json['isDeleted'] ?? false,
        user = PlayerUserDto.fromJson(json['user']);
}

class PlayerUserDto {
  final String userId;
  final String firstName;
  final String lastName;

  const PlayerUserDto({
    required this.userId,
    required this.firstName,
    required this.lastName,
  });

  PlayerUserDto.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        firstName = json['firstName'],
        lastName = json['lastName'];
}
