import 'package:tennis_app/dtos/tracker_dto.dart';
import "./sets_dto.dart";

class MatchDto {
  final String matchId;
  final String clashId;
  final String mode;
  final String category;
  final int setsQuantity;
  Sets sets;
  final int gamesPerSet;
  final bool superTieBreak;
  final String address;
  final String surface;
  final MatchPlayerDto player1;
  final String player2;
  final MatchPlayerDto? player3;
  final String? player4;
  TrackerDto? tracker;
  bool isLive;
  bool isFinish;
  bool isPaused;
  bool? matchWon;
  bool? matchCancelled;

  MatchDto({
    required this.matchId,
    required this.clashId,
    required this.mode,
    required this.category,
    required this.setsQuantity,
    required this.sets,
    required this.gamesPerSet,
    required this.superTieBreak,
    required this.address,
    required this.surface,
    required this.player1,
    required this.player2,
    required this.player3,
    required this.player4,
    required this.tracker,
    required this.isLive,
    required this.isFinish,
    required this.isPaused,
    this.matchWon,
    this.matchCancelled,
  });

  MatchDto.fromJson(Map<String, dynamic> json)
      : matchId = json['matchId'],
        clashId = json['clashId'],
        mode = json['mode'],
        category = json['category'],
        setsQuantity = json['setsQuantity'],
        sets = Sets.fromJson(json['sets']),
        gamesPerSet = json['gamesPerSet'],
        superTieBreak = json['superTieBreak'],
        address = json['address'],
        surface = json['surface'],
        player1 = MatchPlayerDto.fromJson(json['player1']),
        player2 = json['player2'],
        player3 = json['player3'] != null
            ? MatchPlayerDto.fromJson(json['player3'])
            : null,
        player4 = json['player4'],
        tracker = json['tracker'] != null
            ? TrackerDto.fromJson(json['tracker'])
            : null,
        isLive = json['isLive'],
        isFinish = json['isFinish'],
        isPaused = json['isPaused'],
        matchWon = json['matchWon'],
        matchCancelled = json['isCancelled'];
}

class MatchPlayerDto {
  final String playerId;
  final String firstName;

  const MatchPlayerDto({
    required this.playerId,
    required this.firstName,
  });

  MatchPlayerDto.fromJson(Map<String, dynamic> json)
      : playerId = json['playerId'],
        firstName = json['name'];
}
