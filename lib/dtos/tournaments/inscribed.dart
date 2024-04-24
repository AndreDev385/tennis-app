import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/dtos/tournaments/couple.dart';

import '../../domain/tournament/participant.dart';

class InscribedList {
  final List<InscribedParticipant>? participants;
  final List<InscribedCouple>? couples;

  const InscribedList({
    required this.participants,
    required this.couples,
  });

  factory InscribedList.fromJson(List<dynamic> json, String gameMode) {
    if (gameMode == GameMode.single) {
      return InscribedList(
        participants: (json).map((r) {
          return InscribedParticipant.fromJson(r);
        }).toList(),
        couples: null,
      );
    } else {
      return InscribedList(
          participants: null,
          couples: json.map((r) {
            return InscribedCouple.fromJson(r);
          }).toList());
    }
  }

  factory InscribedList.skeleton(int howMany) {
    return InscribedList(
        participants: List<InscribedParticipant>.filled(
            howMany, InscribedParticipant.skeleton()),
        couples: null);
  }
}

class InscribedParticipant {
  final int? position;
  final Participant participant;

  const InscribedParticipant({
    required this.position,
    required this.participant,
  });

  InscribedParticipant.fromJson(Map<String, dynamic> json)
      : position = json['position'],
        participant = Participant.fromJson(json['participant']);

  InscribedParticipant.skeleton()
      : position = 1,
        participant = Participant.skeleton();
}

class InscribedCouple {
  final int? position;
  final Couple couple;

  InscribedCouple({
    required this.position,
    required this.couple,
  });

  InscribedCouple.fromJson(Map<String, dynamic> json)
      : position = json['position'],
        couple = Couple.fromJson(json['couple']);

  InscribedCouple.skeleton()
      : position = 1,
        couple = Couple.skeleton();
}
