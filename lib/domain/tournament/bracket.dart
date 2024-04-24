import '../../dtos/tournaments/couple.dart';
import 'participant.dart';

class Bracket {
  final String id;
  final String contestId;
  final String? match;
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
        left = null,
        right = null,
        parent = null,
        rightPlace = Place.skeleton(),
        leftPlace = Place.skeleton(),
        deep = 3;

  Bracket.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        contestId = json['contestId'],
        match = json['match'],
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

  const Place({
    required this.value,
    required this.participant,
    required this.couple,
  });

  Place.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        participant = json['participant'] != null
            ? Participant.fromJson(json['participant'])
            : null,
        couple =
            json['couple'] != null ? Couple.fromJson(json['couple']) : null;

  Place.skeleton()
      : value = 9,
        participant = Participant.skeleton(),
        couple = Couple.skeleton();
}
