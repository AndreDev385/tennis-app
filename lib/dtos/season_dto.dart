class SeasonDto {
    final String seasonId;
    final String leagueId;
    final String name;

    const SeasonDto({
        required this.name,
        required this.seasonId,
        required this.leagueId,
    });

    SeasonDto.fromJson(Map<String, dynamic> json)
            : name = json['name'],
            seasonId = json['seasonId'],
            leagueId = json['leagueId'];
}
