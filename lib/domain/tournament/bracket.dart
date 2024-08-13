import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/dtos/tournaments/contest_clash.dart';
import 'package:tennis_app/dtos/tournaments/team.dart';

import '../../dtos/tournaments/couple.dart';
import 'participant.dart';

class Bracket {
  final String id;
  final String contestId;
  final TournamentMatch? match;
  final ContestClash? clash;
  final String? left;
  final String? right;
  final String? parent;
  final Place rightPlace;
  final Place leftPlace;
  final int deep;

  const Bracket({
    required this.id,
    required this.contestId,
    required this.match,
    required this.clash,
    required this.left,
    required this.right,
    required this.parent,
    required this.rightPlace,
    required this.leftPlace,
    required this.deep,
  });

  Bracket.skeleton()
      : id = "",
        contestId = "",
        match = null,
        clash = null,
        left = null,
        right = null,
        parent = null,
        rightPlace = Place.skeleton(),
        leftPlace = Place.skeleton(),
        deep = 3;

  Bracket.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        contestId = json['contestId'],
        match = json['match'] != null
            ? TournamentMatch.fromJson(json['match'])
            : null,
        clash = json['clash'] != null
            ? ContestClash.fromJson(json['clash'])
            : null,
        left = json['left'],
        right = json['right'],
        parent = json['parent'],
        rightPlace = Place.fromJson(json['rightPlace']),
        leftPlace = Place.fromJson(json['leftPlace']),
        deep = json['deep'];

  @override
  String toString() {
    return "${rightPlace.value} - ${leftPlace.value}";
  }
}

class Place {
  final int value;
  final Participant? participant;
  final Couple? couple;
  final ContestTeam? team;

  const Place({
    required this.value,
    required this.participant,
    required this.couple,
    required this.team,
  });

  Place.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        participant = json['participant'] != null
            ? Participant.fromJson(json['participant'])
            : null,
        team = json['contestTeam'] != null
            ? ContestTeam.fromJson(json['contestTeam'])
            : null,
        couple =
            json['couple'] != null ? Couple.fromJson(json['couple']) : null;

  Place.skeleton()
      : value = 9,
        participant = Participant.skeleton(),
        team = ContestTeam.skeleton(),
        couple = Couple.skeleton();
}
