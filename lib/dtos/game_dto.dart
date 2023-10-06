class GameDto {
  final int myPoints;
  final int rivalPoints;
  final bool isTieBreak;

  const GameDto({
    required this.myPoints,
    required this.rivalPoints,
    required this.isTieBreak,
  });

  GameDto.fromJson(Map<String, dynamic> json)
      : myPoints = json['myPoints'],
        rivalPoints = json['rivalPoints'],
        isTieBreak = json['isTieBreak'];
}
