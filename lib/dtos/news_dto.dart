class NewDto {
  final String clubEventId;
  final String clubId;
  final String link;
  final String image;

  const NewDto({
    required this.clubEventId,
    required this.clubId,
    required this.link,
    required this.image,
  });

  NewDto.fromJson(Map<String, dynamic> json)
      : clubEventId = json['clubEventId'],
        clubId = json['clubId'],
        link = json['link'],
        image = json['image'];
}
