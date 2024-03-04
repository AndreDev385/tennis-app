class UserDto {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final bool canTrack;
  final bool isAdmin;
  final bool isPlayer;
  final bool isDeleted;

  const UserDto({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isAdmin,
    required this.canTrack,
    required this.isPlayer,
    required this.isDeleted,
  });

  UserDto.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        canTrack = json['canTrack'],
        isAdmin = json['isAdmin'],
        isDeleted = json['isDeleted'],
        isPlayer = json['isPlayer'];

  Map<String, dynamic> toJson(UserDto user) => {
        'userId': user.userId,
        'email': user.email,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'canTrack': user.canTrack,
        'isAdmin': user.isAdmin,
        'isDeleted': user.isDeleted,
        'isPlayer': user.isPlayer,
      };
}
