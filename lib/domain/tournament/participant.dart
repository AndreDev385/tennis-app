class Participant {
  final String participantId;
  final bool isDeleted;
  final String userId;
  final String firstName;
  final String lastName;
  final String? ci;
  final String? device;
  final String? avatar;

  const Participant({
    required this.participantId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.ci,
    this.device = null,
    this.avatar,
    this.isDeleted = false,
  });

  Participant.fromJson(Map<String, dynamic> json)
      : participantId = json['participantId'],
        isDeleted = json['isDeleted'],
        device = json['device'],
        avatar = json['avatar'],
        userId = json['user']['userId'],
        firstName = json['user']['firstName'],
        lastName = json['user']['lastName'],
        ci = json['user']['ci'];

  Participant.skeleton()
      : participantId = "",
        isDeleted = false,
        device = "",
        avatar = "",
        userId = "",
        firstName = "Nombre",
        lastName = "Apellido",
        ci = "V9999999";
}
