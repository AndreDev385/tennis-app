class Tournament {
  final String tournamentId;
  final String name;
  final int status;
  final DateTime startDate;
  final DateTime endDate;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tournament({
    required this.tournamentId,
    required this.name,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  Tournament.fromJson(Map<String, dynamic> json)
      : tournamentId = json['tournamentId'],
        name = json['name'],
        status = json['status'],
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        image = json['image'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
