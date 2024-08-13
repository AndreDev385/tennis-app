class ContestTeam {
  final String contestTeamId;
  final String contestId;
  final String name;
  final List<String> participantsIds;

  const ContestTeam({
    required this.contestTeamId,
    required this.contestId,
    required this.name,
    required this.participantsIds,
  });

  ContestTeam.fromJson(Map<String, dynamic> json)
      : contestTeamId = json['contestTeamId'],
        contestId = json['contestId'],
        name = json['name'],
        participantsIds = (json['participantsIds'] as List<dynamic>)
            .map((r) => r as String)
            .toList();

  ContestTeam.skeleton()
      : contestTeamId = "",
        contestId = "",
        name = "Aguila 1",
        participantsIds = [];
}
