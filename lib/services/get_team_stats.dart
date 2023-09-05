import 'dart:convert';

import 'package:tennis_app/dtos/team_stats.dto.dart';
import 'package:tennis_app/services/api.dart';
import 'package:tennis_app/services/utils.dart';

Future<Result<TeamStatsDto>> getTeamStats(
  String? journey,
  String season,
  String teamId,
) async {
  try {
    Map<String, String> query = {"teamId": teamId};

    if (season.isNotEmpty) {
      query["season"] = season;
    }

    if (journey != null && journey.isNotEmpty) {
      query["journey"] = journey;
    }

    String queryString = mapQueryToUrlString(query);

    final response = await Api.get("team/stats$queryString");

    if (response.statusCode != 200) {
      return Result.fail(jsonDecode(response.body)['message']);
    }

    List<dynamic> rawList = jsonDecode(response.body);

    if (rawList.isEmpty) {
      return Result.fail(
        "No se encontraron estadísticas con los valores seleccionados",
      );
    }

    List<TeamStatsDto> listStats =
        rawList.map((e) => TeamStatsDto.fromJson(e)).toList();

    int gamesWonAsLocal = 0;
    int gamesPlayedAsLocal = 0;
    int gamesWonAsVisitor = 0;
    int gamesPlayedAsVisitor = 0;
    int totalGamesWon = 0;
    int totalGamesPlayed = 0;
    //sets
    int setsWonAsLocal = 0;
    int setsPlayedAsLocal = 0;
    int setsWonAsVisitor = 0;
    int setsPlayedAsVisitor = 0;
    int totalSetsWon = 0;
    int totalSetsPlayed = 0;
    // super tie-break
    int superTieBreaksWonAsLocal = 0;
    int superTieBreaksPlayedAsLocal = 0;
    int superTieBreaksWonAsVisitor = 0;
    int superTieBreaksPlayedAsVisitor = 0;
    int totalSuperTieBreaksWon = 0;
    int totalSuperTieBreaksPlayed = 0;
    // match
    int matchWonAsLocal = 0;
    int matchLostAsLocal = 0;
    int matchPlayedAsLocal = 0;
    int matchWonAsVisitor = 0;
    int matchLostAsVisitor = 0;
    int matchPlayedAsVisitor = 0;
    int totalMatchWon = 0;
    int totalMatchPlayed = 0;
    // match won with first set won
    int matchsWonWithFirstSetWonAsLocal = 0;
    int matchsPlayedWithFirstSetWonAsLocal = 0;
    int matchsWonWithFirstSetWonAsVisitor = 0;
    int matchsPlayedWithFirstSetWonAsVisitor = 0;
    int totalMatchsWonWithFirstSetWon = 0;
    int totalMatchsPlayedWithFirstSetWon = 0;
    // clash won
    int clashWonAsLocal = 0;
    int clashPlayedAsLocal = 0;
    int clashWonAsVisitor = 0;
    int clashPlayedAsVisitor = 0;
    int totalClashWon = 0;
    int totalClashPlayed = 0;

    for (var i = 0; i < listStats.length; i++) {
      gamesWonAsLocal += listStats[i].gamesWonAsLocal;
      gamesPlayedAsLocal = listStats[i].gamesPlayedAsLocal;
      gamesWonAsVisitor = listStats[i].gamesWonAsVisitor;
      gamesPlayedAsVisitor = listStats[i].gamesPlayedAsVisitor;
      totalGamesWon = listStats[i].totalGamesWon;
      totalGamesPlayed = listStats[i].totalGamesPlayed;
      //sets
      setsWonAsLocal = listStats[i].setsWonAsLocal;
      setsPlayedAsLocal = listStats[i].setsPlayedAsLocal;
      setsWonAsVisitor = listStats[i].setsWonAsVisitor;
      setsPlayedAsVisitor = listStats[i].setsPlayedAsVisitor;
      totalSetsWon = listStats[i].totalSetsWon;
      totalSetsPlayed = listStats[i].totalSetsPlayed;
      // super tie-break
      superTieBreaksWonAsLocal = listStats[i].superTieBreaksWonAsLocal;
      superTieBreaksPlayedAsLocal = listStats[i].superTieBreaksPlayedAsLocal;
      superTieBreaksWonAsVisitor = listStats[i].superTieBreaksWonAsVisitor;
      superTieBreaksPlayedAsVisitor =
          listStats[i].superTieBreaksPlayedAsVisitor;
      totalSuperTieBreaksWon = listStats[i].totalSuperTieBreaksWon;
      totalSuperTieBreaksPlayed = listStats[i].totalSuperTieBreaksPlayed;
      // match
      matchWonAsLocal = listStats[i].matchWonAsLocal;
      matchLostAsLocal = listStats[i].matchLostAsLocal;
      matchPlayedAsLocal = listStats[i].matchPlayedAsLocal;
      matchWonAsVisitor = listStats[i].matchWonAsVisitor;
      matchLostAsVisitor = listStats[i].matchLostAsVisitor;
      matchPlayedAsVisitor = listStats[i].matchPlayedAsVisitor;
      totalMatchWon = listStats[i].totalMatchWon;
      totalMatchPlayed = listStats[i].totalMatchPlayed;
      // match won with first set won
      matchsWonWithFirstSetWonAsLocal =
          listStats[i].matchsWonWithFirstSetWonAsLocal;
      matchsPlayedWithFirstSetWonAsLocal =
          listStats[i].matchsPlayedWithFirstSetWonAsLocal;
      matchsWonWithFirstSetWonAsVisitor =
          listStats[i].matchsWonWithFirstSetWonAsVisitor;
      matchsPlayedWithFirstSetWonAsVisitor =
          listStats[i].matchsPlayedWithFirstSetWonAsVisitor;
      totalMatchsWonWithFirstSetWon =
          listStats[i].totalMatchsWonWithFirstSetWon;
      totalMatchsPlayedWithFirstSetWon =
          listStats[i].totalMatchsPlayedWithFirstSetWon;
      // clash won
      clashWonAsLocal = listStats[i].clashWonAsLocal;
      clashPlayedAsLocal = listStats[i].clashPlayedAsLocal;
      clashWonAsVisitor = listStats[i].clashWonAsVisitor;
      clashPlayedAsVisitor = listStats[i].clashPlayedAsVisitor;
      totalClashWon = listStats[i].totalClashWon;
      totalClashPlayed = listStats[i].totalClashPlayed;
    }

    TeamStatsDto teamStats = TeamStatsDto(
        teamStatsId: listStats[0].teamStatsId,
        seasonId: season,
        teamId: teamId,
        gamesWonAsLocal: gamesWonAsLocal,
        gamesPlayedAsLocal: gamesPlayedAsLocal,
        gamesWonAsVisitor: gamesWonAsVisitor,
        gamesPlayedAsVisitor: gamesPlayedAsVisitor,
        totalGamesWon: totalGamesWon,
        totalGamesPlayed: totalGamesPlayed,
        setsWonAsLocal: setsWonAsLocal,
        setsPlayedAsLocal: setsPlayedAsLocal,
        setsWonAsVisitor: setsWonAsVisitor,
        setsPlayedAsVisitor: setsPlayedAsVisitor,
        totalSetsWon: totalSetsWon,
        totalSetsPlayed: totalSetsPlayed,
        superTieBreaksWonAsLocal: superTieBreaksWonAsLocal,
        superTieBreaksPlayedAsLocal: superTieBreaksPlayedAsLocal,
        superTieBreaksWonAsVisitor: superTieBreaksWonAsVisitor,
        superTieBreaksPlayedAsVisitor: superTieBreaksPlayedAsVisitor,
        totalSuperTieBreaksWon: totalSuperTieBreaksWon,
        totalSuperTieBreaksPlayed: totalSuperTieBreaksPlayed,
        matchWonAsLocal: matchWonAsLocal,
        matchLostAsLocal: matchLostAsLocal,
        matchPlayedAsLocal: matchPlayedAsLocal,
        matchWonAsVisitor: matchWonAsVisitor,
        matchLostAsVisitor: matchLostAsVisitor,
        matchPlayedAsVisitor: matchPlayedAsVisitor,
        totalMatchWon: totalMatchWon,
        totalMatchPlayed: totalMatchPlayed,
        matchsWonWithFirstSetWonAsLocal: matchsWonWithFirstSetWonAsLocal,
        matchsPlayedWithFirstSetWonAsLocal: matchsPlayedWithFirstSetWonAsLocal,
        matchsWonWithFirstSetWonAsVisitor: matchsWonWithFirstSetWonAsVisitor,
        matchsPlayedWithFirstSetWonAsVisitor:
            matchsPlayedWithFirstSetWonAsVisitor,
        totalMatchsWonWithFirstSetWon: totalMatchsWonWithFirstSetWon,
        totalMatchsPlayedWithFirstSetWon: totalMatchsPlayedWithFirstSetWon,
        clashWonAsLocal: clashWonAsLocal,
        clashPlayedAsLocal: clashPlayedAsLocal,
        clashWonAsVisitor: clashWonAsVisitor,
        clashPlayedAsVisitor: clashPlayedAsVisitor,
        totalClashWon: totalClashWon,
        totalClashPlayed: totalClashPlayed);

    return Result.ok(teamStats);
  } catch (e) {
    print(e);
    return Result.fail("Ha ocurrido un error");
  }
}
