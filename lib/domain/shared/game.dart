class Game {
  int _myPoints = 0;
  int _rivalPoints = 0;

  bool _winGame = false;
  bool _loseGame = false;

  bool _tiebreak;
  bool _superTiebreak;
  bool _goldenPoint;

  late int _pointsToWin;
  late int _deucePoints;

  Game({
    bool tiebreak = false,
    bool superTiebreak = false,
    bool goldenPoint = false,
  })  : _superTiebreak = superTiebreak,
        _tiebreak = tiebreak,
        _goldenPoint = goldenPoint {
    if (_tiebreak) {
      _pointsToWin = 7;
      _deucePoints = 6;
    } else if (_superTiebreak) {
      _pointsToWin = 10;
      _deucePoints = 9;
    } else {
      _pointsToWin = 4;
      _deucePoints = 3;
    }
  }

  int get myPoints {
    return _myPoints;
  }

  int get rivalPoints {
    return _rivalPoints;
  }

  int get totalPoints {
    return _rivalPoints + _myPoints;
  }

  bool get winGame {
    return _winGame;
  }

  bool get loseGame {
    return _loseGame;
  }

  bool get tiebreak {
    return _tiebreak;
  }

  bool get superTiebreak {
    return _superTiebreak;
  }

  set _setMyPoints(int points) {
    _myPoints = points;
  }

  set _setRivalPoints(int points) {
    _rivalPoints = points;
  }

  set _setWinGame(bool value) {
    _winGame = value;
  }

  set _setLoseGame(bool value) {
    _loseGame = value;
  }

  bool isBreakPtsChance(int team1, int team2) {
    return pointWinGame(team1, team2) || pointWinGame(team2, team1);
  }

  bool pointWinGame(int team1, int team2) {
    if (_goldenPoint && !this.isTiebreak()) {
      return team1 + 1 == _pointsToWin;
    }
    return (team1 + 1) - team2 > 1 && (team1 + 1) >= _pointsToWin;
  }

  bool isDeuce(int team1, int team2) {
    return team1 == _deucePoints && team2 == _deucePoints;
  }

  bool isTiebreak() {
    return _tiebreak || _superTiebreak;
  }

  bool isSuperTieBreak() {
    return _superTiebreak;
  }

  void score() {
    // Win game
    if (pointWinGame(_myPoints, _rivalPoints)) {
      _winGame = true;
    }

    // regular game deuce logic
    if (!_superTiebreak && !_tiebreak) {
      if (_rivalPoints == _pointsToWin && _myPoints == _deucePoints) {
        _rivalPoints = _deucePoints;
        _myPoints = _deucePoints;
        return;
      }
    }

    _myPoints++;
  }

  void rivalScore() {
    // Lose game
    if (pointWinGame(_rivalPoints, _myPoints)) {
      _loseGame = true;
    }

    // regular game deuce logic
    if (!_superTiebreak && !_tiebreak) {
      if (_myPoints == _pointsToWin && _rivalPoints == _deucePoints) {
        _rivalPoints = _deucePoints;
        _myPoints = _deucePoints;
        return;
      }
    }

    _rivalPoints++;
  }

  void _reset() {
    _myPoints = 0;
    _rivalPoints = 0;

    _winGame = false;
    _loseGame = false;
  }

  void resetRegularGame() {
    _tiebreak = false;
    _superTiebreak = false;

    _pointsToWin = 4;
    _deucePoints = 3;

    _reset();
  }

  void setTiebreakGame() {
    _superTiebreak = false;
    _tiebreak = true;

    _pointsToWin = 7;
    _deucePoints = 6;

    _reset();
  }

  void setSuperTiebreakGame() {
    _tiebreak = false;
    _superTiebreak = true;

    _pointsToWin = 10;
    _deucePoints = 9;

    _reset();
  }

  Game clone() {
    Game game = Game(tiebreak: tiebreak, superTiebreak: superTiebreak);
    game._setMyPoints = _myPoints;
    game._setRivalPoints = _rivalPoints;
    game._setWinGame = _winGame;
    game._setLoseGame = _loseGame;
    game._goldenPoint = _goldenPoint;
    return game;
  }

  Game.skeleton()
      : _tiebreak = false,
        _superTiebreak = false,
        _goldenPoint = false;

  Game.fromJson(Map<String, dynamic> json)
      : _myPoints = json['myPoints'],
        _rivalPoints = json['rivalPoints'],
        _winGame = json['winGame'],
        _loseGame = json['loseGame'],
        _tiebreak = json['tieBreak'],
        _superTiebreak = json['superTiebreak'],
        _pointsToWin = json['pointsToWin'],
        _goldenPoint = json['goldenPoint'],
        _deucePoints = json['deucePoints'];

  Map<String, dynamic> toJson() => {
        'myPoints': myPoints,
        'rivalPoints': rivalPoints,
        'isTieBreak': _superTiebreak || _tiebreak,
        'tieBreak': tiebreak,
        'superTiebreak': superTiebreak,
        'winGame': _winGame,
        'loseGame': _loseGame,
        'pointsToWin': _pointsToWin,
        'deucePoints': _deucePoints,
        'goldenPoint': _goldenPoint,
      };

  @override
  String toString() {
    return """
        'myPoints': $myPoints,
        'rivalPoints': $rivalPoints,
        'tieBreak': $tiebreak,
        'superTiebreak': $superTiebreak,
        'winGame': $_winGame,
        'loseGame': $_loseGame,
        'pointsToWin': $_pointsToWin,
        'deucePoints': $_deucePoints,
        'goldenPoint': $_goldenPoint,
            """;
  }
}
