import '../shared/game.dart';
import '../shared/serve_flow.dart';
import '../shared/set.dart';
import '../shared/utils.dart';
import 'tournament_match_stats.dart';
import 'participant.dart';

class TournamentMatch {
  final String matchId;
  final String tournamentId;
  final String mode;
  final String surface;

  // rules
  final int gamesPerSet;
  final int setsQuantity;
  final bool goldenPoint;

  bool? superTiebreak;
  TournamentMatchStats? tracker;

  Participant participant1;
  Participant participant2;
  Participant? participant3;
  Participant? participant4;

  int? initialTeam;
  DoubleServeFlow? doubleServeFlow;
  SingleServeFlow? singleServeFlow;

  late List<Set> sets;
  int currentSetIdx;
  Game currentGame;

  int setsWon;
  int setsLost;

  bool? matchWon;
  bool matchFinish = false;

  int status;

  TournamentMatch({
    required this.matchId,
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
    required this.goldenPoint,
    this.status = 0,
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
  }) {
    (sets as List<Set>).length == 0
        ? this.sets =
            List.generate(setsQuantity, (index) => Set(setType: gamesPerSet))
        : this.sets = sets;
    if (setsQuantity == 1) {
      superTiebreak = false;
    }
  }

  get servingPlayer {
    print(mode);
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

    tracker?.ace(
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
        : doubleServeFlow!.getPlayerServing();

    tracker?.doubleFault(playerServing: playerServing);
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
    tracker?.bckgPoint(
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
    tracker?.meshPoint(
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
    int playerServing = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.getPlayerServing();

    int playerReturning = mode == GameMode.single
        ? singleServeFlow!.playerReturning
        : doubleServeFlow!.getPlayerReturning(currentGame.totalPoints);

    tracker?.regularPoint(
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
    print("ISFIRST SERV: $isFirstServe");

    int playerServing = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.getPlayerServing();

    int playerReturning = mode == GameMode.single
        ? singleServeFlow!.playerReturning
        : doubleServeFlow!.getPlayerReturning(currentGame.totalPoints);

    tracker?.returnWon(
      winner: winner,
      playerReturning: playerReturning,
      isFirstServe: isFirstServe,
    );

    tracker?.regularPoint(
      firstServe: isFirstServe,
      playerServing: playerServing,
      playerReturning: playerReturning,
      t1WinPoint: playerReturning == PlayersIdx.me ||
          playerReturning == PlayersIdx.partner,
    );

    if (playerServing == PlayersIdx.me || playerServing == PlayersIdx.partner) {
      rivalScore();
      return;
    }
    score();
  }

  void breakPts(bool t1Score) {
    int servingPlayer = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;

    // break points
    tracker?.chanceToBreakPt(game: currentGame, servingPlayer: servingPlayer);
    tracker?.breakPt(game: currentGame, playerServing: servingPlayer);
    tracker?.saveBreakPt(
      game: currentGame,
      playerServing: servingPlayer,
      t1Score: t1Score,
    );
  }

  void rivalScore() {
    if (matchFinish) return;

    currentGame.rivalScore();

    int servingPlayer = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.servingPlayer;

    breakPts(false);

    int points = currentGame.myPoints + currentGame.rivalPoints;

    tracker?.gameEnd(
      isTieBreak: currentGame.isTiebreak(),
      servingPlayer: servingPlayer,
      gameEnd: currentGame.winGame || currentGame.loseGame,
      t1WinGame: currentGame.winGame,
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
      sets[currentSetIdx].addMatchState(tracker?.clone());
      singleServeFlow?.setOrder(tracker?.gamesPlayed);
      doubleServeFlow?.setOrder(tracker?.gamesPlayed, initialTeam!);
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
    breakPts(true);

    int points = currentGame.myPoints + currentGame.rivalPoints;

    tracker?.gameEnd(
      servingPlayer: servingPlayer,
      isTieBreak: currentGame.isTiebreak(),
      gameEnd: currentGame.winGame || currentGame.loseGame,
      t1WinGame: currentGame.winGame,
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
      sets[currentSetIdx].addMatchState(this.tracker?.clone());
      singleServeFlow?.setOrder(tracker?.gamesPlayed);
      doubleServeFlow?.setOrder(tracker?.gamesPlayed, initialTeam!);
      _gameWinsSet();
      if (matchFinish == false) {
        singleServeFlow = null;
        doubleServeFlow?.setNextSetFlow();
      }
    }
  }

  void servicePoint({required bool isFirstServe}) {
    // saque no devuelto
    int playerServing = mode == GameMode.single
        ? singleServeFlow!.servingPlayer
        : doubleServeFlow!.getPlayerServing();

    int playerReturning = mode == GameMode.single
        ? singleServeFlow!.playerReturning
        : doubleServeFlow!.getPlayerReturning(currentGame.totalPoints);

    tracker?.servWon(
      playerServing: playerServing,
      playerReturning: playerReturning,
      isFirstServe: isFirstServe,
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
      matchId: matchId,
      tournamentId: tournamentId,
      mode: mode,
      setsQuantity: setsQuantity,
      surface: surface,
      gamesPerSet: gamesPerSet,
      superTiebreak: superTiebreak,
      goldenPoint: goldenPoint,
      sets: setListClone,
      setsWon: setsWon,
      setsLost: setsLost,
      currentGame: currentGame.clone(),
      currentSetIdx: currentSetIdx,
      participant1: participant1,
      participant2: participant2,
      participant3: participant3,
      participant4: participant4,
      tracker: tracker?.clone(),
      matchWon: matchWon,
      initialTeam: initialTeam,
      doubleServeFlow: doubleServeFlow?.clone(),
      singleServeFlow: singleServeFlow?.clone(),
    );

    return match;
  }

  TournamentMatch.skeleton()
      : tournamentId = "",
        matchId = "",
        mode = GameMode.single,
        surface = Surfaces.grass,
        //rules
        gamesPerSet = GamesPerSet.regular,
        setsQuantity = 3,
        //
        participant1 = Participant.skeleton(),
        participant2 = Participant.skeleton(),
        participant3 = null,
        participant4 = null,
        goldenPoint = false,
        tracker = TournamentMatchStats.skeleton(),
        matchWon = null,
        sets = setsSkeleton(),
        // match info
        currentSetIdx = 0,
        currentGame = Game.skeleton(),
        setsWon = 0,
        setsLost = 0,
        matchFinish = false,
        superTiebreak = false,
        initialTeam = 0,
        status = 3,
        doubleServeFlow = null,
        singleServeFlow = null;

  TournamentMatch.fromJson(Map<String, dynamic> json)
      : matchId = json['matchId'],
        tournamentId = json['tournamentId'],
        mode = json['mode'],
        status = json['status'],
        surface = json['surface'],
        //rules
        gamesPerSet = json['rules']['gamesPerSet'],
        setsQuantity = json['rules']['setsQuantity'],
        goldenPoint = json['rules']['goldenPoint'],
        //
        participant1 = Participant.fromJson(json['participant1']),
        participant2 = Participant.fromJson(json['participant2']),
        participant3 = json['participant3'] != null
            ? Participant.fromJson(json['participant3'])
            : null,
        participant4 = json['participant4'] != null
            ? Participant.fromJson(json['participant4'])
            : null,
        tracker = json['tracker'] != null
            ? BuildTournamentStats(json['tracker']) as TournamentMatchStats
            : null,
        matchWon = json['matchWon'],
        sets = setsFromJson(
          json['sets'],
          BuildTournamentStats,
          json['rules']['setsQuantity'],
          json['rules']['gamesPerSet'],
        ),
        // match info
        currentSetIdx = json['matchInfo']['currentSetIdx'] ?? 0,
        currentGame = json['matchInfo']['currentGame'] != null
            ? Game.fromJson(json['matchInfo']['currentGame'])
            : Game(
                tiebreak: false,
                superTiebreak: false,
                goldenPoint: json['rules']['goldenPoint'],
              ),
        setsWon = json['matchInfo']['setsWon'] ?? 0,
        setsLost = json['matchInfo']['setsLost'] ?? 0,
        matchFinish = json['matchInfo']['matchFinish'] ?? false,
        superTiebreak = json['matchInfo']['superTiebreak'],
        initialTeam = json['matchInfo']['initialTeam'],
        doubleServeFlow = json['matchInfo']['doubleServeFlow'] != null
            ? DoubleServeFlow.fromJson(json['matchInfo']['doubleServeFlow'])
            : null,
        singleServeFlow = json['matchInfo']['singleServeFlow'] != null
            ? SingleServeFlow.fromJson(json['matchInfo']['singleServeFlow'])
            : null;

  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'tournamentId': tournamentId,
      'mode': mode,
      'status': status,
      'surface': surface,
      //rules
      'rules': {
        'gamesPerSet': gamesPerSet,
        'setsQuantity': setsQuantity,
        'goldenPoint': goldenPoint,
      },
      //
      'participant1': participant1.toJson(),
      'participant2': participant2.toJson(),
      'participant3': participant3?.toJson(),
      'participant4': participant4?.toJson(),
      'tracker': tracker?.toJson(),
      'matchWon': matchWon,
      'sets': sets,
      // match info
      'matchInfo': {
        'currentSetIdx': currentSetIdx,
        'currentGame': currentGame.toJson(),
        'setsWon': setsWon,
        'setsLost': setsLost,
        'matchFinish': matchFinish,
        'superTiebreak': superTiebreak,
        'initialTeam': initialTeam,
        'doubleServeFlow': doubleServeFlow?.toJson(),
        'singleServeFlow': singleServeFlow?.toJson(),
      }
    };
  }
}
