class SeasonDto {
    final String seasonId;
    final String leagueId;
    final String name;
    final bool isFinish;
    final bool isCurrentSeason;

    const SeasonDto({
        required this.name,
        required this.seasonId,
        required this.leagueId,
        required this.isFinish,
        required this.isCurrentSeason,
    });

    SeasonDto.fromJson(Map<String, dynamic> json)
            : name = json['name'],
            seasonId = json['seasonId'],
            isFinish = json['isFinish'],
            isCurrentSeason = json['isCurrentSeason'],
            leagueId = json['leagueId'];
}
