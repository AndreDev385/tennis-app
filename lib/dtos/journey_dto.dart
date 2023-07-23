class JourneyDto {
  String name;

  JourneyDto.fromJson(Map<String, dynamic> json) : name = json['name'];
}
