import "package:tennis_app/domain/statistics.dart";

import "./game_rules.dart";

import 'game.dart';
import "./set.dart";

part "serve_flow.dart";

class Match {
  // Data to create the match
  final String mode;
  final int setsQuantity;
  final String surface;
  final int gamePerSet;
  bool? superTiebreak;
  final String direction;
  String? statistics;
  StatisticsTracker? tracker;

  //players names
  String player1 = "";
  String player2 = "";
  String player3 = "";
  String player4 = "";

  // Match flow
  // serving
  int? initialTeam;
  DoubleServeFlow? doubleServeFlow;
  SingleServeFlow? singleServeFlow;

  List<Set> sets;
  int currentSetIdx;
  Game currentGame;

  int setsWon;
  int setsLost;

  bool? matchWon;
  bool matchFinish = false;

  Match({
    required this.mode,
    required this.setsQuantity,
    required this.surface,
    required this.gamePerSet,
    required this.currentGame,
    this.direction = "",
    this.currentSetIdx = 0,
    this.setsWon = 0,
    this.setsLost = 0,
    this.superTiebreak,
    this.tracker,
    sets,
  }) : sets = sets ??
            List.generate(setsQuantity, (index) => Set(setType: gamePerSet)) {
    tracker ??= mode == GameMode.single
        ? StatisticsTracker.singleGame()
        : StatisticsTracker.doubleGame();
    if (setsQuantity == 1) {
      superTiebreak = false;
    }
  }

  factory Match.defaultMatch() {
    return Match(
      mode: GameMode.single,
      surface: Surfaces.hard,
      gamePerSet: GamesPerSet.regular,
      direction: "",
      currentSetIdx: 0,
      currentGame: Game(),
      setsQuantity: 3,
      superTiebreak: false,
    );
  }

  get servingTeam {
    if (mode == GameMode.single) {
      return singleServeFlow?.servingPlayer;
    }
    if (mode == GameMode.double) {
      return doubleServeFlow?.servingTeam;
    }
  }

  get servingPlayer {
    if (mode == GameMode.double) {
      return doubleServeFlow?.getPlayerServing();
    }
    if (mode == GameMode.single) {
      return singleServeFlow?.servingPlayer;
    }
  }

  bool isPlayerServing(int player) {
    if (mode == GameMode.single) {
      return singleServeFlow!.isPlayerServing(player);
    } else {
      return doubleServeFlow!.isPlayerServing(player);
    }
  }

  bool isPlayerReturning(int player) {
    if (mode == GameMode.single) {
      return singleServeFlow!.isPlayerReturning(player);
    } else {
      return doubleServeFlow!.isPlayerReturning(
          player, currentGame.myPoints + currentGame.rivalPoints);
    }
  }

  void setStatistics(String value) {
    statistics = value;
  }

  // serving config for single and double games
  void setDoubleServing(
    int initialTeam,
    int playerServing,
    int playerReturning,
  ) {
    if (this.initialTeam == null) {
      this.initialTeam = initialTeam;
    }
    if (doubleServeFlow != null && doubleServeFlow!.isFlowComplete == false) {
      setSecondServing(playerServing, playerReturning);
      return;
    }
    if (doubleServeFlow == null || doubleServeFlow?.setNextFlow == true) {
      doubleServeFlow = DoubleServeFlow(
        initialTeam: initialTeam,
        playerServing: playerServing,
        playerReturning: playerReturning,
      );
      return;
    }
    doubleServeFlow!.changeOrder();
  }

  void setSecondServing(int playerServing, int playerReturning) {
    doubleServeFlow!.setSecondServe(playerServing, playerReturning);
  }

  void setSingleServe(int initialPlayer) {
    singleServeFlow = SingleServeFlow(initialPlayer: initialPlayer);
  }
  // end serving config for single and double games

  // tiebreak config
  void _setTiebreaks() {
    // set tie-break for regular set
    if (gamePerSet == GamesPerSet.regular &&
        sets[currentSetIdx].myGames == gamePerSet &&
        sets[currentSetIdx].rivalGames == gamePerSet) {
      currentGame.setTiebreakGame();

      // set tie-break for pro and short set
    } else if ((gamePerSet == GamesPerSet.pro ||
            gamePerSet == GamesPerSet.short) &&
        sets[currentSetIdx].myGames == gamePerSet - 1 &&
        sets[currentSetIdx].rivalGames == gamePerSet - 1) {
      currentGame.setTiebreakGame();
      // new game
    } else {
      currentGame.resetRegularGame();
    }
  }

  void setSuperTieBreak(bool value) {
    superTiebreak = value;
    if (value) {
      currentGame.setSuperTiebreakGame();
    }
  }

  // score logic basic //
  void _gameWinsSet() {
    setsWon++;
    // check if the match is over and the main player/team won
    if (setsQuantity == SetsQuantity.singleSet ||
        setsWon == (setsQuantity ~/ 2) + 1) {
      matchFinish = true;
      matchWon = true;
      return;
    }
    currentSetIdx++;
  }

  void teamBreakPoints() {
    int servingPlayer = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;

    // break points
    tracker?.rivalBreakPoint(game: currentGame, playerServing: servingPlayer);
    tracker?.breakPoint(game: currentGame, playerServing: servingPlayer);
    tracker?.winBreakPt(game: currentGame, playerServing: servingPlayer);
    tracker?.saveBreakPt(game: currentGame, playerServing: servingPlayer);
  }

  void _basicStatistic(bool winPoint) {
    // statistics
    int player;
    if (servingTeam == Team.we) {
      player = mode == GameMode.double
          ? doubleServeFlow!.servingPlayer
          : PlayersIdx.me;
    } else {
      player = mode == GameMode.double
          ? doubleServeFlow!.getPlayerReturning(
              currentGame.totalPoints,
            )
          : PlayersIdx.me;
    }

    bool isServing = isPlayerServing(player);
    bool isReturning = isPlayerReturning(player);

    tracker?.simplePoint(
      winPoint: winPoint,
      selectedPlayer: player,
      isServing: isServing,
      isReturning: isReturning,
    );
  }

  void score() {
    if (matchFinish) return;

    _basicStatistic(true);

    currentGame.score();

    int servingPlayer = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;

    // break points
    tracker?.rivalBreakPoint(game: currentGame, playerServing: servingPlayer);
    tracker?.breakPoint(game: currentGame, playerServing: servingPlayer);
    tracker?.winBreakPt(game: currentGame, playerServing: servingPlayer);
    tracker?.saveBreakPt(game: currentGame, playerServing: servingPlayer);

    int points = currentGame.myPoints + currentGame.rivalPoints;

    tracker?.winGame(
      servingTeam: servingTeam,
      winGame: currentGame.winGame,
    );

    if (currentGame.winGame ||
        ((currentGame.tiebreak || currentGame.superTiebreak) &&
            (points % 2 != 0))) {
      singleServeFlow?.changeOrder();
      doubleServeFlow?.changeOrder();
    }

    if (currentGame.winGame) {
      // final game
      if (currentGame.superTiebreak) {
        sets[currentSetIdx].setSuperTieBreakResult(
            currentGame.myPoints, currentGame.rivalPoints, currentGame.winGame);
      }
      sets[currentSetIdx].winGameInCurrentSet();
      _setTiebreaks();
    }

    if (sets[currentSetIdx].winSet) {
      singleServeFlow?.setOrder(tracker?.gamesPlayed);
      doubleServeFlow?.setOrder(tracker?.gamesPlayed, initialTeam!);
      _gameWinsSet();
      if (matchFinish == false) {
        doubleServeFlow?.setNextSetFlow();
      }
    }
  }

  void _gameLostSet() {
    setsLost++;
    // check if the match is over and the main player/team lost
    if (setsQuantity == SetsQuantity.singleSet ||
        setsLost == (setsQuantity ~/ 2) + 1) {
      matchFinish = true;
      matchWon = false;
      return;
    }
    currentSetIdx++;
  }

  void rivalBreakPoints() {
    int servingPlayer = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;

    // break points
    tracker?.rivalBreakPoint(game: currentGame, playerServing: servingPlayer);
    tracker?.breakPoint(game: currentGame, playerServing: servingPlayer);
  }

  void rivalScore() {
    if (matchFinish) return;

    _basicStatistic(false);

    currentGame.rivalScore();

    rivalBreakPoints();

    int points = currentGame.myPoints + currentGame.rivalPoints;

    tracker?.lostGame(lostGame: currentGame.loseGame, servingTeam: servingTeam);

    if (currentGame.loseGame ||
        ((currentGame.tiebreak || currentGame.superTiebreak) &&
            (points % 2 != 0))) {
      singleServeFlow?.changeOrder();
      doubleServeFlow?.changeOrder();
    }

    if (currentGame.loseGame) {
      // final game
      if (currentGame.superTiebreak) {
        sets[currentSetIdx].setSuperTieBreakResult(
            currentGame.myPoints, currentGame.rivalPoints, currentGame.winGame);
      }
      sets[currentSetIdx].loseGameInCurrentSet();
      _setTiebreaks();
    }

    if (sets[currentSetIdx].loseSet) {
      singleServeFlow?.setOrder(tracker?.gamesPlayed);
      doubleServeFlow?.setOrder(tracker?.gamesPlayed, initialTeam!);
      _gameLostSet();
      if (matchFinish == false) {
        doubleServeFlow?.setNextSetFlow();
      }
    }
  }
  // End score logic basic //

  // intermediate //
  void ace(bool isFirstServe) {
    int playerServing;
    if (servingTeam == Team.we) {
      playerServing = mode == GameMode.single
          ? PlayersIdx.me
          : doubleServeFlow!.servingPlayer;

      tracker?.ace(
        playerServing: playerServing,
        isFirstServe: isFirstServe,
        winPoint: true,
      );
      return score();
    }
    playerServing = mode == GameMode.single
        ? PlayersIdx.rival
        : doubleServeFlow!.servingPlayer;
    tracker?.ace(
      playerServing: playerServing,
      isFirstServe: isFirstServe,
      winPoint: false,
    );
    return rivalScore();
  }

  void doubleFault() {
    int playerServing = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;
    tracker?.doubleFault(playerServing: playerServing);
    if (servingTeam == Team.we) {
      return rivalScore();
    } else {
      return score();
    }
  }

  void servicePoint({required bool isFirstServe}) {
    // saque no devuelto
    int playerServing = mode == GameMode.double
        ? doubleServeFlow!.servingPlayer
        : singleServeFlow!.servingPlayer;

    tracker?.servicePoint(
      firstServe: isFirstServe,
      playerServing: playerServing,
      winPoint: servingTeam == Team.we,
    );
    return servingTeam == Team.we ? score() : rivalScore();
  }

  void returnPoint({
    // devolucion ganada
    required bool isFirstServe,
    required bool winPoint,
    required bool noForcedError,
  }) {
    int playerReturning = mode == GameMode.double
        ? doubleServeFlow!.getPlayerReturning(currentGame.totalPoints)
        : PlayersIdx.me;

    if (noForcedError) {
      tracker?.noForcedError(playerReturning, winPoint);
    }
    tracker?.returnPoint(
      isFirstServe: isFirstServe,
      playerReturning: playerReturning,
      winPoint: winPoint,
    );
    score();
  }

  void playerWithAction({
    required bool isFirstServe,
    required bool winPoint,
  }) {
    int playerServing = mode == GameMode.double
        ? doubleServeFlow!.servingPlayer
        : singleServeFlow!.servingPlayer;

    int playerReturning = mode == GameMode.double
        ? doubleServeFlow!.getPlayerReturning(currentGame.totalPoints)
        : singleServeFlow!.playerReturning;
    if (servingTeam == Team.we) {
      tracker?.servicePoint(
        firstServe: isFirstServe,
        playerServing: playerServing,
        winPoint: winPoint,
        action: true,
      );
    } else {
      tracker?.returnPoint(
        isFirstServe: isFirstServe,
        playerReturning: playerReturning,
        winPoint: winPoint,
      );
    }
  }

  void meshPoint({
    required int selectedPlayer,
    required bool winPoint,
    required bool noForcedError,
    required bool isFirstServe,
  }) {
    playerWithAction(isFirstServe: isFirstServe, winPoint: winPoint);
    tracker?.meshPoint(
      selectedPlayer: selectedPlayer,
      winPoint: winPoint,
    );
    if (noForcedError) {
      tracker?.noForcedError(selectedPlayer, winPoint);
    }
    if (winPoint) {
      return score();
    }
    return rivalScore();
  }

  void bckgPoint({
    required int selectedPlayer,
    required bool winPoint,
    required bool noForcedError,
    required bool isFirstServe,
  }) {
    playerWithAction(isFirstServe: isFirstServe, winPoint: winPoint);
    tracker?.bckgPoint(
      selectedPlayer: selectedPlayer,
      winPoint: winPoint,
    );
    if (noForcedError) {
      tracker?.noForcedError(selectedPlayer, winPoint);
    }
    if (winPoint) {
      return score();
    }
    return rivalScore();
  }

  void winner({
    required int selectedPlayer,
    required bool winPoint,
    required bool isFirstServe,
  }) {
    playerWithAction(isFirstServe: isFirstServe, winPoint: winPoint);
    tracker?.winnerPoint(selectedPlayer: selectedPlayer, winPoint: winPoint);
    if (winPoint) {
      return score();
    }
    return rivalScore();
  }

  Match clone() {
    List<Set> setListClone = [];

    for (Set s in sets) {
      setListClone.add(s.clone());
    }

    Match match = Match(
      mode: mode,
      setsQuantity: setsQuantity,
      surface: surface,
      gamePerSet: gamePerSet,
      superTiebreak: superTiebreak,
      direction: direction,
      sets: setListClone,
      setsWon: setsWon,
      setsLost: setsLost,
      currentGame: currentGame.clone(),
      currentSetIdx: currentSetIdx,
    );

    match.player1 = player1;
    match.player2 = player2;
    match.player3 = player3;
    match.player4 = player4;

    match.statistics = statistics;
    match.tracker = tracker?.clone();

    match.initialTeam = initialTeam;

    matchWon = matchWon;
    matchFinish = matchFinish;

    if (doubleServeFlow != null) {
      match.doubleServeFlow = doubleServeFlow!.clone();
    }

    if (singleServeFlow != null) {
      match.singleServeFlow = singleServeFlow!.clone();
    }

    return match;
  }

  Match.fromJson(Map<String, dynamic> json)
      : mode = json["mode"],
        setsQuantity = json["setsQuantity"],
        surface = json["surface"],
        gamePerSet = json["gamePerSet"],
        superTiebreak = json["superTiebreak"],
        direction = json["direction"],
        statistics = json["statistics"],
        tracker = StatisticsTracker.fromJson(json["tracker"]),
        //players names
        player1 = json["player1"],
        player2 = json["player2"],
        player3 = json["player3"],
        player4 = json["player4"],
        // Match flow
        // serving
        initialTeam = json["initialTeam"],
        doubleServeFlow = json["doubleServeFlow"] != null
            ? DoubleServeFlow.fromJson(json['doubleServeFlow'])
            : null,
        singleServeFlow = json["singleServeFlow"] != null
            ? SingleServeFlow.fromJson(json['singleServeFlow'])
            : null,
        sets = setsFromJson(json['sets']),
        currentSetIdx = json["currentSetIdx"],
        currentGame = Game.fromJson(json['currentGame']),
        setsWon = json["setsWon"],
        setsLost = json["setsLost"],
        matchWon = json["matchWon"],
        matchFinish = json["matchFinish"];

  toJson({
    matchId,
    trackerId,
    player1Id,
    player2Id,
    player1TrackerId,
    player2TrackerId,
  }) =>
      {
        "mode": mode,
        "setsQuantity": setsQuantity,
        "surface": surface,
        "gamePerSet": gamePerSet,
        "superTiebreak": superTiebreak,
        "direction": direction,
        "statistics": statistics,
        "tracker": tracker?.toJson(
          matchId: matchId,
          trackerId: trackerId,
          player1Id: player1Id,
          player2Id: player2Id,
          player1TrackerId: player1TrackerId,
          player2TrackerId: player2TrackerId,
        ),
        //players names
        "player1": player1,
        "player2": player2,
        "player3": player3,
        "player4": player4,
        // Match flow
        // serving
        "initialTeam": initialTeam,
        "doubleServeFlow": doubleServeFlow?.toJson(),
        "singleServeFlow": singleServeFlow?.toJson(),

        "sets": sets.map((e) => e.toJson()).toList(),
        "currentSetIdx": currentSetIdx,
        "currentGame": currentGame.toJson(),

        "setsWon": setsWon,
        "setsLost": setsLost,

        "matchWon": matchWon,
        "matchFinish": matchFinish,
      };

  @override
  String toString() {
    return "\nmyPoints: ${currentGame.myPoints}, rivalPoints:${currentGame.rivalPoints}\nmode: $mode";
  }
}
