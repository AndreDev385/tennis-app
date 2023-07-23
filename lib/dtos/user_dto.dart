class UserDto {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final bool canTrack;
  final bool isAdmin;
  final bool isPlayer;

  const UserDto({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isAdmin,
    required this.canTrack,
    required this.isPlayer,
  });

  UserDto.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        canTrack = json['canTrack'],
        isAdmin = json['isAdmin'],
        isPlayer = json['isPlayer'];

  Map<String, dynamic> toJson(UserDto user) => {
        'userId': user.userId,
        'email': user.email,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'canTrack': user.canTrack,
        'isAdmin': user.isAdmin,
        'isPlayer': user.isPlayer,
      };
}
