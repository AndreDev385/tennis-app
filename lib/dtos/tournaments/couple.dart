import '../../domain/tournament/participant.dart';

class Couple {
  final String coupleId;
  final Participant p1;
  final Participant p2;

  const Couple({
    required this.coupleId,
    required this.p1,
    required this.p2,
  });

  Couple.fromJson(Map<String, dynamic> json)
      : coupleId = json['coupleId'],
        p1 = Participant.fromJson(json['p1']),
        p2 = Participant.fromJson(json['p2']);

  Couple.skeleton()
      : coupleId = "",
        p1 = Participant.skeleton(),
        p2 = Participant.skeleton();
}
