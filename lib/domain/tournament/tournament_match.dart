import '../shared/game.dart';
import '../shared/serve_flow.dart';
import '../shared/set.dart';
import '../shared/utils.dart';
import 'tournament_match_stats.dart';
import 'participant.dart';

class TournamentMatch {
  final String tournamentId;
  final String mode;
  final int setsQuantity;
  final String surface;
  final int gamesPerSet;
  bool? superTiebreak;
  TournamentMatchStats tracker;

  Participant participant1;
  Participant participant2;
  Participant? participant3;
  Participant? participant4;

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

  TournamentMatch({
    required this.tournamentId,
    required this.mode,
    required this.setsQuantity,
    required this.surface,
    required this.gamesPerSet,
    required this.participant1,
    required this.participant2,
    required this.participant3,
    required this.participant4,
    required this.currentGame,
    required this.tracker,
    this.superTiebreak,
    this.currentSetIdx = 0,
    this.setsWon = 0,
    this.setsLost = 0,
    this.matchWon,
    this.matchFinish = false,
    this.initialTeam,
    this.doubleServeFlow,
    this.singleServeFlow,
    sets,
  }) : sets = sets ??
            List.generate(setsQuantity, (index) => Set(setType: gamesPerSet)) {
    if (setsQuantity == 1) {
      superTiebreak = false;
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

  get returningPlayer {
    if (mode == GameMode.double) {
      return doubleServeFlow?.getPlayerReturning(currentGame.totalPoints);
    }
    if (mode == GameMode.single) {
      return singleServeFlow?.playerReturning;
    }
  }

  get servingTeam {
    if (mode == GameMode.single) {
      return singleServeFlow?.servingPlayer;
    }
    if (mode == GameMode.double) {
      return doubleServeFlow?.servingTeam;
    }
  }

  bool isPlayerReturning(int player) {
    if (mode == GameMode.single) {
      return singleServeFlow!.isPlayerReturning(player);
    } else {
      bool isReturning = doubleServeFlow!.isPlayerReturning(
        player,
        currentGame.myPoints + currentGame.rivalPoints,
        currentGame.isSuperTieBreak(),
      );
      return isReturning;
    }
  }

  bool isPlayerServing(int player) {
    if (mode == GameMode.single) {
      return singleServeFlow!.isPlayerServing(player);
    } else {
      return doubleServeFlow!.isPlayerServing(player);
    }
  }

  void ace(bool isFirstServe) {
    int playerServing = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.getPlayerServing();

    int playerReturning = mode == GameMode.single
        ? singleServeFlow!.playerReturning
        : doubleServeFlow!.getPlayerReturning(currentGame.totalPoints);

    tracker.rallyPoint(
      playerWonSelected: playerServing,
      playerLostSelected: playerReturning,
      rally: 0,
    );

    tracker.ace(
      playerServing: playerServing,
      playerReturning: playerReturning,
      isFirstServe: isFirstServe,
    );

    if (servingTeam == Team.we) return score();
    return rivalScore();
  }

  void doubleFault() {
    int playerServing = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;
    tracker.doubleFault(playerServing: playerServing);
    if (servingTeam == Team.we) {
      return rivalScore();
    } else {
      return score();
    }
  }

  void bckgPoint({
    required int selectedPlayer,
    required bool winPoint,
    required bool noForcedError,
    required bool winner,
    required bool isFirstServe,
    required bool t1Score,
  }) {
    tracker.bckgPoint(
      selectedPlayer: selectedPlayer,
      winPoint: winPoint,
      winner: winner,
      error: noForcedError,
    );

    // it must be call just one for point //
    if (winPoint)
      playerWithAction(
        isFirstServe: isFirstServe,
        winPoint: t1Score,
      );

    if (t1Score && winPoint) {
      return score();
    }

    if (!t1Score && winPoint) return rivalScore();
    // end it must be call just one for point //
  }

  void meshPoint({
    required int selectedPlayer,
    required bool winPoint,
    required bool noForcedError,
    required bool isFirstServe,
    required bool winner,
    required bool t1Score,
  }) {
    tracker.meshPoint(
      selectedPlayer: selectedPlayer,
      winPoint: winPoint,
      error: noForcedError,
      winner: winner,
    );

    // it must be call just once for point //
    if (winPoint)
      playerWithAction(
        isFirstServe: isFirstServe,
        winPoint: t1Score,
      );

    if (t1Score && winPoint) {
      return score();
    }

    if (!t1Score && winPoint) return rivalScore();
    // end it must be call just once for point //
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

    tracker.regularPoint(
      firstServe: isFirstServe,
      t1WinPoint: winPoint,
      playerServing: playerServing,
      playerReturning: playerReturning,
      action: true,
    );
  }

  void returnWon({
    // devolucion ganada
    required bool isFirstServe,
    required bool winner,
    required bool noForcedError,
  }) {
    int playerServing = mode == GameMode.double
        ? doubleServeFlow!.servingPlayer
        : singleServeFlow!.servingPlayer;

    int playerReturning = mode == GameMode.double
        ? doubleServeFlow!.getPlayerReturning(currentGame.totalPoints)
        : PlayersIdx.me;

    tracker.returnWon(
      winner: winner,
      playerReturning: playerReturning,
      isFirstServe: isFirstServe,
    );

    tracker.regularPoint(
      firstServe: isFirstServe,
      playerServing: playerServing,
      playerReturning: playerReturning,
      t1WinPoint:
          playerServing == PlayersIdx.me || playerServing == PlayersIdx.partner,
    );

    if (playerServing == PlayersIdx.me || playerServing == PlayersIdx.partner) {
      score();
      return;
    }
    rivalScore();
  }

  void breakPts() {
    int servingPlayer = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;

    // break points
    tracker.chanceToBreakPt(game: currentGame, servingPlayer: servingPlayer);
    tracker.breakPt(game: currentGame, playerServing: servingPlayer);
    tracker.saveBreakPt(game: currentGame, playerServing: servingPlayer);
  }

  void rivalScore() {
    if (matchFinish) return;

    currentGame.rivalScore();

    int servingPlayer = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;

    breakPts();

    int points = currentGame.myPoints + currentGame.rivalPoints;

    tracker.gameEnd(
      isTieBreak: currentGame.isTiebreak(),
      servingPlayer: servingPlayer,
      gameEnd: currentGame.winGame || currentGame.loseGame,
    );

    // if tie-break, set first point done to change returning player for second serv
    doubleServeFlow?.tiebreakPoint();

    bool gameOver = currentGame.loseGame;
    bool tiebreakServeChange =
        (currentGame.tiebreak || currentGame.superTiebreak) &&
            (points % 2 != 0);

    if (gameOver || tiebreakServeChange) {
      singleServeFlow?.changeOrder();
      doubleServeFlow?.changeOrder();
    }

    if (currentGame.loseGame) {
      // final game
      if (currentGame.superTiebreak) {
        sets[currentSetIdx].setSuperTieBreakResult(
          currentGame.myPoints,
          currentGame.rivalPoints,
          currentGame.winGame,
        );
      }
      if (currentGame.tiebreak) {
        sets[currentSetIdx].setTiebreakPoints(
          myPoints: currentGame.myPoints,
          rivalPoints: currentGame.rivalPoints,
        );
      }
      sets[currentSetIdx].loseGameInCurrentSet();
      _setTiebreaks();
    }

    if (sets[currentSetIdx].loseSet) {
      sets[currentSetIdx].addMatchState(tracker.clone());
      singleServeFlow?.setOrder(tracker.gamesPlayed);
      doubleServeFlow?.setOrder(tracker.gamesPlayed, initialTeam!);
      _gameLostSet();
      if (matchFinish == false) {
        singleServeFlow = null;
        doubleServeFlow?.setNextSetFlow();
      }
    }
  }

  void score() {
    if (matchFinish) return;

    currentGame.score();

    int servingPlayer = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;

    // break points
    breakPts();

    int points = currentGame.myPoints + currentGame.rivalPoints;

    tracker.gameEnd(
      servingPlayer: servingPlayer,
      isTieBreak: currentGame.isTiebreak(),
      gameEnd: currentGame.winGame || currentGame.loseGame,
    );

    // if tie-break, set first point done to change returning player for second serv
    doubleServeFlow?.tiebreakPoint();

    bool gameOver = currentGame.winGame;

    bool tiebreakServeChange =
        (currentGame.tiebreak || currentGame.superTiebreak) &&
            (points % 2 != 0);

    if (gameOver || tiebreakServeChange) {
      singleServeFlow?.changeOrder();
      doubleServeFlow?.changeOrder();
    }

    if (currentGame.winGame) {
      // final game
      if (currentGame.superTiebreak) {
        sets[currentSetIdx].setSuperTieBreakResult(
          currentGame.myPoints,
          currentGame.rivalPoints,
          currentGame.winGame,
        );
      }
      if (currentGame.tiebreak) {
        sets[currentSetIdx].setTiebreakPoints(
          myPoints: currentGame.myPoints,
          rivalPoints: currentGame.rivalPoints,
        );
      }
      sets[currentSetIdx].winGameInCurrentSet();
      _setTiebreaks();
    }

    if (sets[currentSetIdx].winSet) {
      sets[currentSetIdx].addMatchState(this.tracker.clone());
      singleServeFlow?.setOrder(tracker.gamesPlayed);
      doubleServeFlow?.setOrder(tracker.gamesPlayed, initialTeam!);
      _gameWinsSet();
      if (matchFinish == false) {
        singleServeFlow = null;
        doubleServeFlow?.setNextSetFlow();
      }
    }
  }

  void servicePoint({required bool isFirstServe}) {
    // saque no devuelto
    int playerServing = mode == GameMode.double
        ? doubleServeFlow!.servingPlayer
        : singleServeFlow!.servingPlayer;

    int playerReturning = mode == GameMode.single
        ? PlayersIdx.me
        : doubleServeFlow!.getPlayerReturning(currentGame.totalPoints);

    tracker.servWon(
      playerServing: playerServing,
      isFirstServe: isFirstServe,
    );

    tracker.regularPoint(
      firstServe: isFirstServe,
      playerReturning: playerReturning,
      playerServing: playerServing,
      t1WinPoint: servingTeam == Team.we,
    );

    return servingTeam == Team.we ? score() : rivalScore();
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

  void setSuperTieBreak(bool value) {
    superTiebreak = value;
    sets[currentSetIdx].superTiebreak = value;
    if (value) {
      currentGame.setSuperTiebreakGame();
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

  // end serving config for single and double games

  // tiebreak config
  void _setTiebreaks() {
    bool tiebreakForRegularSet = gamesPerSet == GamesPerSet.regular &&
        sets[currentSetIdx].myGames == gamesPerSet &&
        sets[currentSetIdx].rivalGames == gamesPerSet;

    if (tiebreakForRegularSet) {
      currentGame.setTiebreakGame();
      return;
    }

    bool tiebreakForProAndShortSet =
        (gamesPerSet == GamesPerSet.pro || gamesPerSet == GamesPerSet.short) &&
            sets[currentSetIdx].myGames == gamesPerSet - 1 &&
            sets[currentSetIdx].rivalGames == gamesPerSet - 1;

    if (tiebreakForProAndShortSet) {
      currentGame.setTiebreakGame();
      return;
    }
    currentGame.resetRegularGame();
  }

  TournamentMatch clone() {
    List<Set> setListClone = [];

    for (Set s in sets) {
      setListClone.add(s.clone());
    }

    TournamentMatch match = TournamentMatch(
      tournamentId: tournamentId,
      mode: mode,
      setsQuantity: setsQuantity,
      surface: surface,
      gamesPerSet: gamesPerSet,
      superTiebreak: superTiebreak,
      sets: setListClone,
      setsWon: setsWon,
      setsLost: setsLost,
      currentGame: currentGame.clone(),
      currentSetIdx: currentSetIdx,
      participant1: participant1,
      participant2: participant2,
      participant3: participant3,
      participant4: participant4,
      tracker: tracker.clone(),
      matchWon: matchWon,
      initialTeam: initialTeam,
      doubleServeFlow: doubleServeFlow?.clone(),
      singleServeFlow: singleServeFlow?.clone(),
    );

    return match;
  }

  TournamentMatch.fromJson(Map<String, dynamic> json)
      : tournamentId = json['tournamentId'],
        mode = json['mode'],
        surface = json['surface'],
        //rules
        gamesPerSet = json['rules']['gamesPerSet'],
        setsQuantity = json['rules']['setsQuantity'],
        //
        participant1 = Participant.fromJson(json['participant1']),
        participant2 = Participant.fromJson(json['participant2']),
        participant3 = json['participant3'] != null
            ? Participant.fromJson(json['participant3'])
            : null,
        participant4 = json['participant4'] != null
            ? Participant.fromJson(json['participant4'])
            : null,
        tracker = BuildTournamentStats(json['tracker']) as TournamentMatchStats,
        matchWon = json['matchWon'],
        sets = setsFromJson(json['sets'], BuildTournamentStats),
        // match indo
        currentSetIdx = json['matchInfo']['currentSetIdx'] = 0,
        currentGame = json['matchInfo']['currentGame'],
        setsWon = json['matchInfo']['setsWon'] = 0,
        setsLost = json['matchInfo']['setsLost'] = 0,
        matchFinish = json['matchInfo']['matchFinish'] = false,
        superTiebreak = json['matchInfo']['superTiebreak'],
        initialTeam = json['matchInfo']['initialTeam'],
        doubleServeFlow = json['matchInfo']['doubleServeFlow'],
        singleServeFlow = json['matchInfo']['singleServeFlow'];
}
