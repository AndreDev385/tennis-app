import 'package:tennis_app/dtos/tournaments/team.dart';

class ContestClash {
  final String contestClashId;
  final String contestId;
  final bool? t1WonClash;
  final bool isFinish;
  final List<String> matchIds;
  final ContestTeam team1;
  final ContestTeam team2;

  const ContestClash({
    required this.contestClashId,
    required this.contestId,
    required this.t1WonClash,
    required this.isFinish,
    required this.matchIds,
    required this.team1,
    required this.team2,
  });

  ContestClash.fromJson(Map<String, dynamic> json)
      : contestClashId = json['contestClashId'],
        contestId = json['contestId'],
        t1WonClash = json['t1WonClash'],
        isFinish = json['isFinish'],
        matchIds = (json['matchIds'] as List<dynamic>)
            .map((r) => r as String)
            .toList(),
        team1 = ContestTeam.fromJson(json['team1']),
        team2 = ContestTeam.fromJson(json['team2']);

  ContestClash.skeleton()
      : contestClashId = "",
        contestId = "",
        t1WonClash = null,
        isFinish = false,
        matchIds = [],
        team1 = ContestTeam.skeleton(),
        team2 = ContestTeam.skeleton();
}
