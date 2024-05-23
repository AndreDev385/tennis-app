import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/dtos/tournaments/couple.dart';
import 'package:tennis_app/dtos/tournaments/team.dart';

import '../../domain/tournament/participant.dart';

class InscribedList {
  final List<InscribedParticipant>? participants;
  final List<InscribedCouple>? couples;
  final List<InscribedTeam>? teams;

  const InscribedList({
    required this.participants,
    required this.couples,
    required this.teams,
  });

  factory InscribedList.fromJson(List<dynamic> json, String gameMode) {
    if (gameMode == GameMode.team) {
      return InscribedList(
        participants: null,
        couples: null,
        teams: json.map((r) {
          return InscribedTeam.fromJson(r);
        }).toList(),
      );
    }
    if (gameMode == GameMode.double) {
      return InscribedList(
          participants: null,
          teams: null,
          couples: json.map((r) {
            return InscribedCouple.fromJson(r);
          }).toList());
    } else {
      return InscribedList(
        participants: (json).map((r) {
          return InscribedParticipant.fromJson(r);
        }).toList(),
        couples: null,
        teams: null,
      );
    }
  }

  factory InscribedList.skeleton(int howMany) {
    return InscribedList(
      participants: List<InscribedParticipant>.filled(
          howMany, InscribedParticipant.skeleton()),
      couples: null,
      teams: null,
    );
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

class InscribedTeam {
  final int? position;
  final ContestTeam contestTeam;

  const InscribedTeam({
    required this.position,
    required this.contestTeam,
  });

  InscribedTeam.fromJson(Map<String, dynamic> json)
      : position = json['position'],
        contestTeam = ContestTeam.fromJson(json['contestTeam']);

  InscribedTeam.skeleton()
      : position = 1,
        contestTeam = ContestTeam.skeleton();
}
