import 'package:tennis_app/dtos/player_tracker_dto.dart';

class TrackerDto {
  String? trackerId;
  String? matchId;

  PlayerTrackerDto me;
  PlayerTrackerDto? partner;

  int gamesWonReturning;
  int gamesLostReturning;
  int winBreakPtsChances;
  int breakPtsWinned;

  int rivalPointsWinnedFirstServ;
  int rivalPointsWinnedSecondServ;
  int rivalFirstServIn;
  int rivalSecondServIn;
  int rivalPointsWinnedFirstReturn;
  int rivalPointsWinnedSecondReturn;
  int rivalFirstReturnIn;
  int rivalSecondReturnIn;
  int rivalFirstServWon;
  int rivalSecondServWon;
  
  int rivalDobleFault;
  int rivalNoForcedErrors;
  int rivalAces;
  int rivalWinners;

  int longRallyWon;
  int longRallyLost;
  int mediumRallyWon;
  int mediumRallyLost;
  int shortRallyWon;
  int shortRallyLost;

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
    required this.rivalFirstServWon,
    required this.rivalSecondServWon,
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
        'rivalFirstServWon': rivalFirstServWon,
        'rivalSecondSerWon': rivalSecondServWon,
        'rivalFirstReturnIn': rivalFirstReturnIn,
        'rivalNoForcedErrors': rivalNoForcedErrors,
        'rivalSecondReturnIn': rivalSecondReturnIn,
        'rivalPointsWinnedFirstServ': rivalPointsWinnedFirstServ,
        'rivalPointsWinnedSecondServ': rivalPointsWinnedSecondServ,
        'rivalPointsWinnedFirstReturn': rivalPointsWinnedFirstReturn,
        'rivalPointsWinnedSecondReturn': rivalPointsWinnedSecondReturn,
      };

  TrackerDto.fromJson(Map<String, dynamic> json)
      : trackerId = json['trackerId'] != null ? json['trackerId'] : "",
        matchId = json['matchId'] != null ? json['matchId'] : "",
        me = PlayerTrackerDto.fromJson(json['me']),
        partner = json['partner'] != null
            ? PlayerTrackerDto.fromJson(json['partner'])
            : null,

        gamesWonReturning = json['gamesWonReturning'],
        gamesLostReturning = json['gamesLostReturning'],
        winBreakPtsChances = json['winBreakPtsChances'],
        breakPtsWinned = json['breakPtsWinned'],

        longRallyWon = json['longRallyWon'],
        longRallyLost = json['longRallyLost'],
        mediumRallyWon = json['mediumRallyWon'],
        mediumRallyLost = json['mediumRallyLost'],
        shortRallyWon = json['shortRallyWon'],
        shortRallyLost = json['shortRallyLost'],

        rivalAces = json['rivalAces'],
        rivalWinners = json['rivalWinners'],
        rivalDobleFault = json['rivalDobleFault'],
        rivalFirstServIn = json['rivalFirstServIn'],
        rivalSecondServIn = json['rivalSecondServIn'],
        rivalFirstServWon = json['rivalFirstServWon'],
        rivalSecondServWon = json['rivalSecondServWon'],
        rivalFirstReturnIn = json['rivalFirstReturnIn'],
        rivalNoForcedErrors = json['rivalNoForcedErrors'],
        rivalSecondReturnIn = json['rivalSecondReturnIn'],
        rivalPointsWinnedFirstServ = json['rivalPointsWinnedFirstServ'],
        rivalPointsWinnedSecondServ = json['rivalPointsWinnedSecondServ'],
        rivalPointsWinnedFirstReturn = json['rivalPointsWinnedFirstReturn'],
        rivalPointsWinnedSecondReturn = json['rivalPointsWinnedSecondReturn'];

  TrackerDto.calculate({required TrackerDto first, required TrackerDto second})
      : trackerId = first.trackerId,
        matchId = first.matchId,
        me = PlayerTrackerDto.calculate(first: first.me, second: second.me),
        partner = first.partner != null
            ? PlayerTrackerDto.calculate(
                first: first.partner!,
                second: second.partner!,
              )
            : null,
        gamesLostReturning =
            first.gamesLostReturning - second.gamesLostReturning,
        gamesWonReturning = first.gamesWonReturning - second.gamesWonReturning,
        winBreakPtsChances =
            first.winBreakPtsChances - second.winBreakPtsChances,
        breakPtsWinned = first.breakPtsWinned - second.breakPtsWinned,
        rivalAces = first.rivalAces - second.rivalAces,
        longRallyWon = first.longRallyWon - second.longRallyWon,
        rivalWinners = first.rivalWinners - second.rivalWinners,
        longRallyLost = first.longRallyLost - second.longRallyLost,
        shortRallyWon = first.shortRallyWon - second.shortRallyWon,
        mediumRallyWon = first.mediumRallyWon - second.mediumRallyWon,
        shortRallyLost = first.shortRallyLost - second.shortRallyLost,
        mediumRallyLost = first.mediumRallyLost - second.mediumRallyLost,
        rivalDobleFault = first.rivalDobleFault - second.rivalDobleFault,
        rivalFirstServIn = first.rivalFirstServIn - second.rivalFirstServIn,
        rivalSecondServIn = first.rivalSecondServIn - second.rivalSecondServIn,
        rivalFirstServWon = first.rivalFirstServWon - second.rivalFirstServWon,
        rivalSecondServWon =
            first.rivalSecondServWon - second.rivalSecondServWon,
        rivalFirstReturnIn =
            first.rivalFirstReturnIn - second.rivalFirstReturnIn,
        rivalNoForcedErrors =
            first.rivalNoForcedErrors - second.rivalNoForcedErrors,
        rivalSecondReturnIn =
            first.rivalSecondReturnIn - second.rivalSecondReturnIn,
        rivalPointsWinnedFirstServ = first.rivalPointsWinnedFirstServ -
            second.rivalPointsWinnedFirstServ,
        rivalPointsWinnedSecondServ = first.rivalPointsWinnedSecondServ -
            second.rivalPointsWinnedSecondServ,
        rivalPointsWinnedFirstReturn = first.rivalPointsWinnedFirstReturn -
            second.rivalPointsWinnedFirstReturn,
        rivalPointsWinnedSecondReturn = first.rivalPointsWinnedSecondReturn -
            second.rivalPointsWinnedSecondReturn;

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
    return gamesWonServing + gamesWonReturning;
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

  int get firstServWon {
    if (partner != null) {
      return me.firstServWon + partner!.firstServWon;
    }
    return me.firstServWon;
  }

  int get secondServWon {
    if (partner != null) {
      return me.secondServWon + partner!.secondServWon;
    }
    return me.secondServWon;
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

  int get firstReturnWon {
    if (partner != null) {
      return me.firstReturnWon + partner!.firstReturnWon;
    }
    return me.firstReturnWon;
  }

  int get secondReturnWon {
    if (partner != null) {
      return me.secondReturnWon + partner!.secondReturnWon;
    }
    return me.secondReturnWon;
  }

  int get firstReturnWinner {
    if (partner != null) {
      return me.firstReturnWinner + partner!.firstReturnWinner;
    }
    return me.firstReturnWinner;
  }

  int get secondReturnWinner {
    if (partner != null) {
      return me.secondReturnWinner + partner!.secondReturnWinner;
    }
    return me.secondReturnWinner;
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

  int get meshPointsWon {
    int points = me.meshPointsWon;
    if (partner != null) {
      points += partner!.meshPointsWon;
    }
    return points;
  }

  int get meshPointsLost {
    int points = me.meshPointsLost;
    if (partner != null) {
      points += partner!.meshPointsLost;
    }
    return points;
  }

  int get meshError {
    if (partner != null) {
      return me.meshError + partner!.meshError;
    }
    return me.meshError;
  }

  int get meshWinner {
    if (partner != null) {
      return me.meshWinner + partner!.meshWinner;
    }
    return me.meshWinner;
  }

  int get bckgPointsWon {
    int points = me.bckgPointsWon;
    if (partner != null) {
      points += partner!.bckgPointsWon;
    }
    return points;
  }

  int get bckgPointsLost {
    int points = me.bckgPointsLost;
    if (partner != null) {
      points += partner!.bckgPointsLost;
    }
    return points;
  }

  int get bckgWinner {
    if (partner != null) {
      return me.bckgWinner + partner!.bckgWinner;
    }
    return me.bckgWinner;
  }

  int get bckgError {
    if (partner != null) {
      return me.bckgError + partner!.bckgError;
    }
    return me.bckgError;
  }

  int get winners {
    if (partner != null) {
      return me.winners + partner!.winners;
    }
    return me.winners;
  }

  int get noForcedErrors {
    if (partner != null) {
      return me.noForcedErrors + partner!.noForcedErrors;
    }
    return me.noForcedErrors;
  }
}
