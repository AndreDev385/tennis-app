abstract class Stats {
  Map<String, dynamic> toJson();
}

dynamic statsFromJson<T extends Stats>(
  Map<String, dynamic> json,
  Stats factory(Map<String, dynamic> value),
) {
  return factory(json);
}

class Set<T extends Stats> {
  int _myGames = 0;
  int _rivalGames = 0;

  bool _winSet = false;
  bool _loseSet = false;

  int _myTiebreakPoints = 0;
  int _rivalTiebreakPoints = 0;

  dynamic _stats;

  final int setType;
  bool superTiebreak;
  bool tiebreak;

  Set({
    required this.setType,
    this.superTiebreak = false,
    this.tiebreak = false,
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
    superTiebreak = true;
    _loseSet = true;
  }

  void setTiebreakPoints({required int myPoints, required int rivalPoints}) {
    _myTiebreakPoints = myPoints;
    _rivalTiebreakPoints = rivalPoints;
    tiebreak = true;
  }

  void winGameInCurrentSet() {
    // win game with 2 or more games of difference
    if ((_myGames + 1) == setType && (_myGames + 1) - _rivalGames >= 2) {
      _winSet = true;
    }
    // win tiebreak
    if (myGames + 1 == setType + 1) {
      _winSet = true;
    }
    // win shorts and pro sets case
    if (superTiebreak) {
      return;
    }
    _myGames++;
  }

  void loseGameInCurrentSet() {
    // win 6 games with 2 or more games of difference
    if ((_rivalGames + 1) == setType && (_rivalGames + 1) - _myGames >= 2) {
      _loseSet = true;
    }
    // win tiebreak
    if (_rivalGames + 1 == setType + 1) {
      _loseSet = true;
    }
    // win shorts and pro sets case
    if (superTiebreak) {
      return;
    }
    _rivalGames++;
  }

  void addMatchState(dynamic stats) {
    this._stats = stats;
  }

  Set clone() {
    Set currSet = Set(setType: setType, superTiebreak: superTiebreak);
    currSet._myGames = _myGames;
    currSet._rivalGames = rivalGames;
    currSet._winSet = winSet;
    currSet._loseSet = loseSet;
    currSet._stats = _stats;
    currSet.tiebreak = tiebreak;
    currSet.superTiebreak = superTiebreak;
    currSet._myTiebreakPoints = _myTiebreakPoints;
    currSet._rivalTiebreakPoints = _rivalTiebreakPoints;
    return currSet;
  }

  Set.fromJson(
    Map<String, dynamic> json,
    Stats factory(Map<String, dynamic> value),
  )   : _myGames = json['myGames'],
        _rivalGames = json['rivalGames'],
        _winSet = json['setWon'] ?? false,
        _loseSet = json['setWon'] != null ? !json['setWon'] : false,
        setType = json['setType'] ?? 6,
        superTiebreak = json['superTiebreak'] ?? false,
        _myTiebreakPoints = json['myTiebreakPoints'] ?? 0,
        _rivalTiebreakPoints = json['_rivalTiebreakPoints'] ?? 0,
        tiebreak = json['tiebreak'] ?? false,
        _stats = json['stats'] != null
            ? statsFromJson(json['stats'], factory)
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
      'tiebreak': tiebreak,
      'myTiebreakPoints': _myTiebreakPoints,
      'rivalTiebreakPoints': _rivalTiebreakPoints,
      'stats': _stats?.toJson(),
    };
  }
}

List<Set> setsFromJson<T extends Stats>(
  List<dynamic> json,
  Stats factory(Map<String, dynamic> json),
) {
  return json.map((e) => Set.fromJson(e, factory)).toList();
}
