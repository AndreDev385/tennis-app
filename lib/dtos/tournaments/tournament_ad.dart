class TournamentAd {
  final String? link;
  final String image;
  final String tournamentId;

  const TournamentAd({
    required this.link,
    required this.image,
    required this.tournamentId,
  });

  TournamentAd.skeleton()
      : link = "",
        image = "",
        tournamentId = "";

  TournamentAd.fromJson(Map<String, dynamic> json)
      : link = json["link"],
        image = json["image"],
        tournamentId = json["tournamentId"];
}
