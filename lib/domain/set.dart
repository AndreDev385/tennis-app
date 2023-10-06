import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/statistics.dart';

class Set {
  int _myGames = 0;
  int _rivalGames = 0;

  bool _winSet = false;
  bool _loseSet = false;

  StatisticsTracker? _stats;

  final int setType;
  bool superTiebreak;

  Set({
    required this.setType,
    this.superTiebreak = false,
  });

  get myGames {
    return _myGames;
  }

  get rivalGames {
    return _rivalGames;
  }

  get winSet {
    return _winSet;
  }

  get loseSet {
    return _loseSet;
  }

  get stats {
    return _stats;
  }

  void setSuperTieBreakResult(int myPoints, int rivalPoints, bool winSet) {
    _myGames = myPoints;
    _rivalGames = rivalPoints;
    if (winSet) {
      _winSet = true;
      return;
    }
    _loseSet = true;
  }

  void winGameInCurrentSet() {
    if (setType == GamesPerSet.regular) {
      // win game with 2 or more games of difference
      if ((_myGames + 1) == setType && (_myGames + 1) - _rivalGames >= 2) {
        _winSet = true;
      }
      // win tiebreak
      if (myGames + 1 == setType + 1) {
        _winSet = true;
      }
      // win shorts and pro sets case
    } else if (setType == GamesPerSet.pro || setType == GamesPerSet.short) {
      if ((_myGames + 1) == setType) {
        _winSet = true;
      }
    }
    _myGames++;
  }

  void loseGameInCurrentSet() {
    if (setType == GamesPerSet.regular) {
      // win 6 games with 2 or more games of difference
      if ((_rivalGames + 1) == setType && (_rivalGames + 1) - _myGames >= 2) {
        _loseSet = true;
      }
      // win tiebreak
      if (_rivalGames + 1 == setType + 1) {
        _loseSet = true;
      }
      // win shorts and pro sets case
    } else if (setType == GamesPerSet.pro || setType == GamesPerSet.short) {
      if ((_rivalGames + 1) == setType) {
        _loseSet = true;
      }
    }
    _rivalGames++;
  }

  void addMatchState(StatisticsTracker stats) {
    this._stats = stats;
  }

  Set clone() {
    Set currSet = Set(setType: setType, superTiebreak: superTiebreak);
    currSet._myGames = _myGames;
    currSet._rivalGames = rivalGames;
    currSet._winSet = winSet;
    currSet._loseSet = loseSet;
    currSet._stats = _stats;
    return currSet;
  }

  Set.fromJson(Map<String, dynamic> json)
      : _myGames = json['myGames'],
        _rivalGames = json['rivalGames'],
        _winSet = json['setWon'] ?? false,
        _loseSet = json['setWon'] != null ? !json['setWon'] : false,
        setType = json['setType'] ?? 6,
        superTiebreak = json['superTiebreak'] ?? false,
        _stats = json['stats'] != null
            ? StatisticsTracker.fromJson(json['stats'])
            : null;

  toJson() {
    bool? setWon;
    if (_loseSet) {
      setWon = false;
    }
    if (_winSet) {
      setWon = true;
    }
    return {
      'myGames': myGames,
      'rivalGames': rivalGames,
      'setWon': setWon,
      'setType': setType,
      'superTiebreak': superTiebreak,
      'stats': _stats?.toJson(),
    };
  }
}

List<Set> setsFromJson(List<dynamic> json) {
  print(json);
  return json.map((e) => Set.fromJson(e)).toList();
}
