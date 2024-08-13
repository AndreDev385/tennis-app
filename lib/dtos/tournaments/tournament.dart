class Tournament {
  final String tournamentId;
  final String name;
  final int status;
  final DateTime startDate;
  final DateTime endDate;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TournamentRules rules;

  const Tournament({
    required this.tournamentId,
    required this.name,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.rules,
  });

  Tournament.fromJson(Map<String, dynamic> json)
      : tournamentId = json['tournamentId'],
        name = json['name'],
        status = json['status'],
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        image = json['image'],
        rules = TournamentRules.fromJson(json['rules']),
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Tournament.skeleton()
      : tournamentId = "",
        name = "Copa Colores",
        status = 0,
        rules = TournamentRules.skeleton(),
        startDate = DateTime.now(),
        endDate = DateTime.now(),
        image = "",
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();
}

class TournamentRules {
  final int setsQuantity;
  final int gamesPerSet;
  final int? matchesPerClash;

  const TournamentRules({
    required this.matchesPerClash,
    required this.gamesPerSet,
    required this.setsQuantity,
  });

  TournamentRules.fromJson(Map<String, dynamic> json)
      : setsQuantity = json['setsQuantity'],
        gamesPerSet = json['gamesPerSet'],
        matchesPerClash = json['matchesPerClash'];

  TournamentRules.skeleton()
      : setsQuantity = 0,
        gamesPerSet = 0,
        matchesPerClash = 0;
}
