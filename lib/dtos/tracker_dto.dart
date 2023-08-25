import 'package:tennis_app/dtos/player_tracker_dto.dart';

class TrackerDto {
  String trackerId;
  String matchId;
  PlayerTrackerDto me;
  PlayerTrackerDto? partner;
  int gamesLostReturning;
  int gamesWonReturning;
  int winBreakPtsChances;
  int breakPtsWinned;
  int rivalAces;
  int longRallyWon;
  int rivalWinners;
  int longRallyLost;
  int shortRallyWon;
  int mediumRallyWon;
  int shortRallyLost;
  int mediumRallyLost;
  int rivalDobleFault;
  int rivalFirstServIn;
  int rivalSecondServIn;
  int rivalFirstReturnIn;
  int rivalNoForcedErrors;
  int rivalSecondReturnIn;
  int rivalPointsWinnedFirstServ;
  int rivalPointsWinnedSecondServ;
  int rivalPointsWinnedFirstReturn;
  int rivalPointsWinnedSecondReturn;

  TrackerDto({
    required this.trackerId,
    required this.matchId,
    required this.me,
    required this.partner,
    required this.gamesWonReturning,
    required this.gamesLostReturning,
    required this.winBreakPtsChances,
    required this.breakPtsWinned,
    required this.rivalAces,
    required this.longRallyWon,
    required this.rivalWinners,
    required this.longRallyLost,
    required this.shortRallyWon,
    required this.mediumRallyWon,
    required this.shortRallyLost,
    required this.mediumRallyLost,
    required this.rivalDobleFault,
    required this.rivalFirstServIn,
    required this.rivalSecondServIn,
    required this.rivalFirstReturnIn,
    required this.rivalNoForcedErrors,
    required this.rivalSecondReturnIn,
    required this.rivalPointsWinnedFirstServ,
    required this.rivalPointsWinnedSecondServ,
    required this.rivalPointsWinnedFirstReturn,
    required this.rivalPointsWinnedSecondReturn,
  });

  toJson() => {
        'trackerId': trackerId,
        'matchId': matchId,
        'me': me.toJson(),
        'partner': partner != null ? partner!.toJson() : null,
        'gamesWonReturning': gamesWonReturning,
        'gamesLostReturning': gamesLostReturning,
        'winBreakPtsChances': winBreakPtsChances,
        'breakPtsWinned': breakPtsWinned,
        'rivalAces': rivalAces,
        'longRallyWon': longRallyWon,
        'rivalWinners': rivalWinners,
        'longRallyLost': longRallyLost,
        'shortRallyWon': shortRallyWon,
        'mediumRallyWon': mediumRallyWon,
        'shortRallyLost': shortRallyLost,
        'mediumRallyLost': mediumRallyLost,
        'rivalDobleFault': rivalDobleFault,
        'rivalFirstServIn': rivalFirstServIn,
        'rivalSecondServIn': rivalSecondServIn,
        'rivalFirstReturnIn': rivalFirstReturnIn,
        'rivalNoForcedErrors': rivalNoForcedErrors,
        'rivalSecondReturnIn': rivalSecondReturnIn,
        'rivalPointsWinnedFirstServ': rivalPointsWinnedFirstServ,
        'rivalPointsWinnedSecondServ': rivalPointsWinnedSecondServ,
        'rivalPointsWinnedFirstReturn': rivalPointsWinnedFirstReturn,
        'rivalPointsWinnedSecondReturn': rivalPointsWinnedSecondReturn,
      };

  TrackerDto.fromJson(Map<String, dynamic> json)
      : trackerId = json['trackerId'] ?? "",
        matchId = json['matchId'] ?? "",
        me = PlayerTrackerDto.fromJson(json['me']),
        partner = json['partner'] != null
            ? PlayerTrackerDto.fromJson(json['partner'])
            : null,
        gamesWonReturning = json['gamesWonReturning'],
        gamesLostReturning = json['gamesLostReturning'],
        winBreakPtsChances = json['winBreakPtsChances'],
        breakPtsWinned = json['breakPtsWinned'],
        rivalAces = json['rivalAces'],
        longRallyWon = json['longRallyWon'],
        rivalWinners = json['rivalWinners'],
        longRallyLost = json['longRallyLost'],
        shortRallyWon = json['shortRallyWon'],
        mediumRallyWon = json['mediumRallyWon'],
        shortRallyLost = json['shortRallyLost'],
        mediumRallyLost = json['mediumRallyLost'],
        rivalDobleFault = json['rivalDobleFault'],
        rivalFirstServIn = json['rivalFirstServIn'],
        rivalSecondServIn = json['rivalSecondServIn'],
        rivalFirstReturnIn = json['rivalFirstReturnIn'],
        rivalNoForcedErrors = json['rivalNoForcedErrors'],
        rivalSecondReturnIn = json['rivalSecondReturnIn'],
        rivalPointsWinnedFirstServ = json['rivalPointsWinnedFirstServ'],
        rivalPointsWinnedSecondServ = json['rivalPointsWinnedSecondServ'],
        rivalPointsWinnedFirstReturn = json['rivalPointsWinnedFirstReturn'],
        rivalPointsWinnedSecondReturn = json['rivalPointsWinnedSecondReturn'];

  int get totalPtsServ {
    if (partner != null) {
      return me.pointsWonServing + partner!.pointsWonServing;
    }
    return me.pointsWonServing;
  }

  int get totalPtsServLost {
    if (partner != null) {
      return me.pointsLostServing + partner!.pointsLostServing;
    }
    return me.pointsLostServing;
  }

  int get totalPtsRet {
    if (partner != null) {
      return me.pointsWonReturning + partner!.pointsWonReturning;
    }
    return me.pointsWonReturning;
  }

  int get totalPtsRetLost {
    if (partner != null) {
      return me.pointsLostReturning + partner!.pointsLostReturning;
    }
    return me.pointsLostReturning;
  }

  int get totalPts {
    return totalPtsServ + totalPtsRet;
  }

  int get totalPtsLost {
    return totalPtsServLost + totalPtsRetLost;
  }

  get gamesWonServing {
    if (partner != null) {
      return me.gamesWonServing + partner!.gamesWonServing;
    }
    return me.gamesWonServing;
  }

  get gamesLostServing {
    if (partner != null) {
      return me.gamesLostServing + partner!.gamesLostServing;
    }
    return me.gamesLostServing;
  }

  get totalGamesWon {
    return gamesWonServing + gamesLostServing;
  }

  int get totalGamesLost {
    return gamesLostServing + gamesLostReturning;
  }

  int get gamesPlayed {
    return totalGamesWon + totalGamesLost;
  }

  int get firstServIn {
    if (partner != null) {
      return me.firstServIn + partner!.firstServIn;
    }
    return me.firstServIn;
  }

  int get secondServIn {
    if (partner != null) {
      return me.secondServIn + partner!.secondServIn;
    }
    return me.secondServIn;
  }

  int get pointsWon1Serv {
    int pointsWon = me.pointsWinnedFirstServ;
    if (partner != null) {
      pointsWon += partner!.pointsWinnedFirstServ;
    }
    return pointsWon;
  }

  int get pointsWon2Serv {
    int pointsWon = me.pointsWinnedSecondServ;
    if (partner != null) {
      pointsWon += partner!.pointsWinnedSecondServ;
    }
    return pointsWon;
  }

  int get firstRetIn {
    int returnsIn = me.firstReturnIn;
    if (partner != null) {
      returnsIn += partner!.firstReturnIn;
    }
    return returnsIn;
  }

  int get secondRetIn {
    int returnsIn = me.secondReturnIn;
    if (partner != null) {
      returnsIn += partner!.secondReturnIn;
    }
    return returnsIn;
  }

  int get pointsWon1Ret {
    int pointsWon = me.pointsWinnedFirstReturn;
    if (partner != null) {
      pointsWon += partner!.pointsWinnedFirstReturn;
    }
    return pointsWon;
  }

  int get pointsWon2Ret {
    int pointsWon = me.pointsWinnedSecondReturn;
    if (partner != null) {
      pointsWon += partner!.pointsWinnedSecondReturn;
    }
    return pointsWon;
  }

  int get aces {
    int points = me.aces;
    if (partner != null) {
      points += partner!.aces;
    }
    return points;
  }

  int get dobleFault {
    if (partner != null) {
      return me.dobleFaults + partner!.dobleFaults;
    }
    return me.dobleFaults;
  }

  int get meshPontsWon {
    int points = me.meshPointsWon;
    if (partner != null) {
      points += partner!.meshPointsWon;
    }
    return points;
  }

  int get meshPontsLost {
    int points = me.meshPointsLost;
    if (partner != null) {
      points += partner!.meshPointsLost;
    }
    return points;
  }

  int get bckgPontsWon {
    int points = me.bckgPointsWon;
    if (partner != null) {
      points += partner!.bckgPointsWon;
    }
    return points;
  }

  int get bckgPontsLost {
    int points = me.bckgPointsLost;
    if (partner != null) {
      points += partner!.bckgPointsLost;
    }
    return points;
  }

  int get winners {
    int points = me.winners;
    if (partner != null) {
      points += partner!.winners;
    }
    return points;
  }

  int get noForcedErrors {
    int errors = me.noForcedErrors;
    if (partner != null) {
      errors += partner!.noForcedErrors;
    }
    return errors;
  }
}
