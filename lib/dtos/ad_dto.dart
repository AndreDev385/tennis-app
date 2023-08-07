class AdDto {
  final String adId;
  final String image;
  final String clubId;
  final String link;

  const AdDto({
    required this.adId,
    required this.image,
    required this.clubId,
    required this.link,
  });

  AdDto.fromJson(Map<String, dynamic> json)
      : adId = json['adId'],
        image = json['image'],
        link = json['link'],
        clubId = json['clubId'];
}
