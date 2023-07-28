class TeamStatsDto {
  final String teamStatsId;
  final String seasonId;
  final String journey;
  final String teamId;
  //games
  final int gamesWonAsLocal;
  final int gamesPlayedAsLocal;
  final int gamesWonAsVisitor;
  final int gamesPlayedAsVisitor;
  final int totalGamesWon;
  final int totalGamesPlayed;
  //sets
  final int setsWonAsLocal;
  final int setsPlayedAsLocal;
  final int setsWonAsVisitor;
  final int setsPlayedAsVisitor;
  final int totalSetsWon;
  final int totalSetsPlayed;
  // super tie-break
  final int superTieBreaksWonAsLocal;
  final int superTieBreaksPlayedAsLocal;
  final int superTieBreaksWonAsVisitor;
  final int superTieBreaksPlayedAsVisitor;
  final int totalSuperTieBreaksWon;
  final int totalSuperTieBreaksPlayed;
  // match
  final int matchWonAsLocal;
  final int matchLostAsLocal;
  final int matchPlayedAsLocal;
  final int matchWonAsVisitor;
  final int matchLostAsVisitor;
  final int matchPlayedAsVisitor;
  final int totalMatchWon;
  final int totalMatchPlayed;
  // match won with first set won
  final int matchsWonWithFirstSetWonAsLocal;
  final int matchsPlayedWithFirstSetWonAsLocal;
  final int matchsWonWithFirstSetWonAsVisitor;
  final int matchsPlayedWithFirstSetWonAsVisitor;
  final int totalMatchsWonWithFirstSetWon;
  final int totalMatchsPlayedWithFirstSetWon;
  // clash won
  final int clashWonAsLocal;
  final int clashPlayedAsLocal;
  final int clashWonAsVisitor;
  final int clashPlayedAsVisitor;
  final int totalClashWon;
  final int totalClashPlayed;

  TeamStatsDto({
    required this.teamStatsId,
    required this.seasonId,
    required this.journey,
    required this.teamId,
    //games
    required this.gamesWonAsLocal,
    required this.gamesPlayedAsLocal,
    required this.gamesWonAsVisitor,
    required this.gamesPlayedAsVisitor,
    required this.totalGamesWon,
    required this.totalGamesPlayed,
    //sets
    required this.setsWonAsLocal,
    required this.setsPlayedAsLocal,
    required this.setsWonAsVisitor,
    required this.setsPlayedAsVisitor,
    required this.totalSetsWon,
    required this.totalSetsPlayed,
    // super tie-break
    required this.superTieBreaksWonAsLocal,
    required this.superTieBreaksPlayedAsLocal,
    required this.superTieBreaksWonAsVisitor,
    required this.superTieBreaksPlayedAsVisitor,
    required this.totalSuperTieBreaksWon,
    required this.totalSuperTieBreaksPlayed,
    // match
    required this.matchWonAsLocal,
    required this.matchLostAsLocal,
    required this.matchPlayedAsLocal,
    required this.matchWonAsVisitor,
    required this.matchLostAsVisitor,
    required this.matchPlayedAsVisitor,
    required this.totalMatchWon,
    required this.totalMatchPlayed,
    // match won with first set won
    required this.matchsWonWithFirstSetWonAsLocal,
    required this.matchsPlayedWithFirstSetWonAsLocal,
    required this.matchsWonWithFirstSetWonAsVisitor,
    required this.matchsPlayedWithFirstSetWonAsVisitor,
    required this.totalMatchsWonWithFirstSetWon,
    required this.totalMatchsPlayedWithFirstSetWon,
    // clash won
    required this.clashWonAsLocal,
    required this.clashPlayedAsLocal,
    required this.clashWonAsVisitor,
    required this.clashPlayedAsVisitor,
    required this.totalClashWon,
    required this.totalClashPlayed,
  });

  TeamStatsDto.fromJson(Map<String, dynamic> json)
      : teamStatsId = json['teamStatsId'],
        seasonId = json['seasonId'],
        journey = json['journey'],
        teamId = json['teamId'],
        //games
        gamesWonAsLocal = json['gamesWonAsLocal'],
        gamesPlayedAsLocal = json['gamesPlayedAsLocal'],
        gamesWonAsVisitor = json['gamesWonAsVisitor'],
        gamesPlayedAsVisitor = json['gamesPlayedAsVisitor'],
        totalGamesWon = json['totalGamesWon'],
        totalGamesPlayed = json['totalGamesPlayed'],
        //sets
        setsWonAsLocal = json['setsWonAsLocal'],
        setsPlayedAsLocal = json['setsPlayedAsLocal'],
        setsWonAsVisitor = json['setsWonAsVisitor'],
        setsPlayedAsVisitor = json['setsPlayedAsVisitor'],
        totalSetsWon = json['totalSetsWon'],
        totalSetsPlayed = json['totalSetsPlayed'],
        // super tie-break
        superTieBreaksWonAsLocal = json['superTieBreaksWonAsLocal'],
        superTieBreaksPlayedAsLocal = json['superTieBreaksPlayedAsLocal'],
        superTieBreaksWonAsVisitor = json['superTieBreaksWonAsVisitor'],
        superTieBreaksPlayedAsVisitor = json['superTieBreaksPlayedAsVisitor'],
        totalSuperTieBreaksWon = json['totalSuperTieBreaksWon'],
        totalSuperTieBreaksPlayed = json['totalSuperTieBreaksPlayed'],
        // match
        matchWonAsLocal = json['matchWonAsLocal'],
        matchLostAsLocal = json['matchLostAsLocal'],
        matchPlayedAsLocal = json['matchPlayedAsLocal'],
        matchWonAsVisitor = json['matchWonAsVisitor'],
        matchLostAsVisitor = json['matchLostAsVisitor'],
        matchPlayedAsVisitor = json['matchPlayedAsVisitor'],
        totalMatchWon = json['totalMatchWon'],
        totalMatchPlayed = json['totalMatchPlayed'],
        // match won with first set won
        matchsWonWithFirstSetWonAsLocal =
            json['matchsWonWithFirstSetWonAsLocal'],
        matchsPlayedWithFirstSetWonAsLocal =
            json['matchsPlayedWithFirstSetWonAsLocal'],
        matchsWonWithFirstSetWonAsVisitor =
            json['matchsWonWithFirstSetWonAsVisitor'],
        matchsPlayedWithFirstSetWonAsVisitor =
            json['matchsPlayedWithFirstSetWonAsVisitor'],
        totalMatchsWonWithFirstSetWon = json['totalMatchsWonWithFirstSetWon'],
        totalMatchsPlayedWithFirstSetWon =
            json['totalMatchsPlayedWithFirstSetWon'],
        // clash won
        clashWonAsLocal = json['clashWonAsLocal'],
        clashPlayedAsLocal = json['clashPlayedAsLocal'],
        clashWonAsVisitor = json['clashWonAsVisitor'],
        clashPlayedAsVisitor = json['clashPlayedAsVisitor'],
        totalClashWon = json['totalClashWon'],
        totalClashPlayed = json['totalClashPlayed'];
}
