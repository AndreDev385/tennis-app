import 'game_rules.dart';

class Set {
  int _myGames = 0;
  int _rivalGames = 0;

  bool _winSet = false;
  bool _loseSet = false;

  final int setType;
  final bool superTiebreak;

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

  Set clone() {
    Set currSet = Set(setType: setType, superTiebreak: superTiebreak);
    currSet._myGames = _myGames;
    currSet._rivalGames = rivalGames;
    currSet._winSet = winSet;
    currSet._loseSet = loseSet;
    return currSet;
  }

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
    };
  }
}
