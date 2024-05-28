class HomeAdDto {
  final String image;
  final String? link;

  const HomeAdDto({required this.image, required this.link});

  HomeAdDto.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        link = json['link'];

  HomeAdDto.skeleton()
      : image = "",
        link = '';
}
