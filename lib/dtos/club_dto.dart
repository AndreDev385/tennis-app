class ClubDto {
  final String clubId;
  final String name;
  final String symbol;
  final String? code;
  final bool isSubscribed;

  const ClubDto({
    required this.clubId,
    required this.name,
    required this.symbol,
    required this.isSubscribed,
    this.code,
  });

  ClubDto.fromJson(Map<String, dynamic> json)
      : clubId = json['clubId'],
        name = json['name'],
        symbol = json['symbol'],
        code = json['code'],
        isSubscribed = json['isSubscribed'];

  Map<String, dynamic> toJson(ClubDto club) => {
        'clubId': club.clubId,
        'name': club.name,
        'symbol': club.symbol,
        'code': club.code,
        'isSubscribed': club.isSubscribed,
      };
}
