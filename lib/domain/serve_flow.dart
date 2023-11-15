part of "./match.dart";

class PlayersIdx {
  static int me = 0;
  static int rival = 1;
  static int partner = 2;
  static int rival2 = 3;
}

class Serve {
  static int none = 0;
  static int serving = 1;
  static int returning = 2;
}

class Team {
  static int we = 0;
  static int their = 1;
}

class SingleServeFlow {
  int initialPlayer;
  int servingPlayer;

  SingleServeFlow({required this.initialPlayer})
      : servingPlayer = initialPlayer;

  get playerReturning {
    return servingPlayer == Team.we ? Team.their : Team.we;
  }

  void setServingPlayer(int player) {
    servingPlayer = player;
  }

  bool isPlayerServing(int player) {
    return servingPlayer == player;
  }

  bool isPlayerReturning(int player) {
    return servingPlayer != player;
  }

  void changeOrder() {
    servingPlayer =
        servingPlayer == PlayersIdx.me ? PlayersIdx.rival : PlayersIdx.me;
  }

  void setOrder(int totalGames) {
    if (initialPlayer == Team.we) {
      servingPlayer = totalGames % 2 == 0 ? initialPlayer : Team.their;
    }
    if (initialPlayer == Team.their) {
      servingPlayer = totalGames % 2 == 0 ? initialPlayer : Team.we;
    }
  }

  SingleServeFlow clone() {
    SingleServeFlow flow = SingleServeFlow(initialPlayer: initialPlayer);
    flow.setServingPlayer(servingPlayer);
    return flow;
  }

  SingleServeFlow.fromJson(Map<String, dynamic> json)
      : initialPlayer = json["initialPlayer"],
        servingPlayer = json["servingPlayer"];

  Map<String, dynamic> toJson() => {
        'initialPlayer': initialPlayer,
        'servingPlayer': servingPlayer,
      };
}

class DoubleServeFlow {
  int initialTeam;
  bool isFlowComplete = false;
  int actualSetOrder = 0;
  int servingTeam;
  late int servingPlayer;
  late int returningPlayer;

  late int _initialServingPlayer;
  late int _initialReturningPlayer;

  bool setNextFlow = false;

  List<int> firstGameFlow = [0, 0, 0, 0];
  List<int> secondGameFlow = [0, 0, 0, 0];
  List<int> thirdGameFlow = [0, 0, 0, 0];
  List<int> fourGameFlow = [0, 0, 0, 0];

  List<List<int>> order = [];

  // when tiebreak, to know who's returning
  bool tiebreakFirstPointDone;

  DoubleServeFlow({
    required this.initialTeam,
    required playerServing,
    required playerReturning,
    this.tiebreakFirstPointDone = false,
  }) : servingTeam = initialTeam {
    // for clone
    servingPlayer = playerServing;
    returningPlayer = playerReturning;
    _initialServingPlayer = playerServing;
    _initialReturningPlayer = playerReturning;

    // flow
    firstGameFlow[playerServing] = Serve.serving;
    firstGameFlow[playerReturning] = Serve.returning;

    thirdGameFlow[playerServing >= 2 ? playerServing - 2 : playerServing + 2] =
        Serve.serving;

    thirdGameFlow[playerReturning] = Serve.returning;

    order = [firstGameFlow, secondGameFlow, thirdGameFlow, fourGameFlow];
  }

  void tiebreakPoint() {
    this.tiebreakFirstPointDone = true;
  }

  bool isPlayerServing(int player) {
    int playerAction = order[actualSetOrder][player];
    return playerAction == Serve.serving;
  }

  /// player: selected player
  /// game: current game
  ///
  /// if the the total points in the game are even the player returning
  /// is the one that was selected in the flow, if not, his partner
  bool isPlayerReturning(int player, int points, bool superTiebreak) {
    int playerAction = order[actualSetOrder][player];
    int partnerAction =
        order[actualSetOrder][player >= 2 ? player - 2 : player + 2];

    bool evenPoints = points == 0 || points % 2 == 0;

    if (superTiebreak) {
      if (playerAction == Serve.returning) {
        return !tiebreakFirstPointDone;
      }
      if (partnerAction == Serve.returning) {
        return tiebreakFirstPointDone;
      }
      return false;
    }

    if (playerAction == Serve.returning) {
      return evenPoints;
    }

    if (partnerAction == Serve.returning) {
      return !evenPoints;
    }

    return false;
  }

  int getPlayerServing() {
    return servingPlayer;
  }

  int getPlayerReturning(int points) {
    int partner =
        returningPlayer >= 2 ? returningPlayer - 2 : returningPlayer + 2;

    return points % 2 == 0 ? returningPlayer : partner;
  }

  void setNextSetFlow() {
    setNextFlow = true;
    initialTeam = servingTeam;
  }

  void setSecondServe(int playerServing, int playerReturning) {
    isFlowComplete = true;
    secondGameFlow[playerServing] = Serve.serving;
    secondGameFlow[playerReturning] = Serve.returning;

    fourGameFlow[playerServing >= 2 ? playerServing - 2 : playerServing + 2] =
        Serve.serving;
    fourGameFlow[playerReturning] = Serve.returning;
    servingPlayer = playerServing;
    returningPlayer = playerReturning;

    order = [firstGameFlow, secondGameFlow, thirdGameFlow, fourGameFlow];
  }

  void setOrder(int totalGames, int initialTeam) {
    if (initialTeam == Team.we) {
      servingTeam = totalGames % 2 == 0 ? initialTeam : Team.their;
    }
    if (initialTeam == Team.their) {
      servingTeam = totalGames % 2 == 0 ? initialTeam : Team.we;
    }
  }

  void changeOrder() {
    servingTeam = servingTeam == Team.we ? Team.their : Team.we;
    if (actualSetOrder == 3) {
      actualSetOrder = 0;
    } else {
      actualSetOrder++;
    }
    if (isFlowComplete) {
      servingPlayer = order[actualSetOrder].indexOf(Serve.serving);
      returningPlayer = order[actualSetOrder].indexOf(Serve.returning);
    }
    tiebreakFirstPointDone = false;
  }

  DoubleServeFlow clone() {
    DoubleServeFlow flow = DoubleServeFlow(
        initialTeam: initialTeam,
        playerServing: _initialServingPlayer,
        playerReturning: _initialReturningPlayer);

    // serving flow
    flow.firstGameFlow = firstGameFlow;
    flow.secondGameFlow = secondGameFlow;
    flow.thirdGameFlow = thirdGameFlow;
    flow.fourGameFlow = fourGameFlow;
    flow.order = order;

    flow.isFlowComplete = isFlowComplete;
    flow.setNextFlow = setNextFlow;
    flow.actualSetOrder = actualSetOrder;
    flow.servingTeam = servingTeam;
    flow.servingPlayer = servingPlayer;
    flow.returningPlayer = returningPlayer;
    flow.tiebreakFirstPointDone = tiebreakFirstPointDone;
    return flow;
  }

  DoubleServeFlow.fromJson(Map<String, dynamic> json)
      : initialTeam = json["initialTeam"],
        _initialServingPlayer = json["initialServingPlayer"],
        _initialReturningPlayer = json["initialReturningPlayer"],
        order = orderFromJson(json['order']),
        firstGameFlow = List<int>.from(json["firstGameFlow"]),
        secondGameFlow = List<int>.from(json["secondGameFlow"]),
        thirdGameFlow = List<int>.from(json["thirdGameFlow"]),
        fourGameFlow = List<int>.from(json["fourGameFlow"]),
        isFlowComplete = json["isFlowComplete"],
        setNextFlow = json["setNextFlow"],
        actualSetOrder = json["actualSetOrder"],
        servingTeam = json["servingTeam"],
        servingPlayer = json["servingPlayer"],
        returningPlayer = json["returningPlayer"],
        tiebreakFirstPointDone = json['tiebreakFirstPointDone'] ?? false;

  Map<String, dynamic> toJson() => {
        "initialTeam": initialTeam,
        "initialServingPlayer": _initialServingPlayer,
        "initialReturningPlayer": _initialReturningPlayer,
        "order": order,
        "firstGameFlow": firstGameFlow,
        "secondGameFlow": secondGameFlow,
        "thirdGameFlow": thirdGameFlow,
        "fourGameFlow": fourGameFlow,
        "isFlowComplete": isFlowComplete,
        "setNextFlow": setNextFlow,
        "actualSetOrder": actualSetOrder,
        "servingTeam": servingTeam,
        "servingPlayer": servingPlayer,
        "returningPlayer": returningPlayer,
        "tiebreakFirstPointDone": tiebreakFirstPointDone,
      };

  @override
  String toString() {
    return """
        "initialTeam": $initialTeam,
        "initialServingPlayer": $_initialServingPlayer,
        "initialReturningPlayer": $_initialReturningPlayer,
        "order": $order,
        "firstGameFlow": $firstGameFlow,
        "secondGameFlow": $secondGameFlow,
        "thirdGameFlow": $thirdGameFlow,
        "fourGameFlow": $fourGameFlow,
        "isFlowComplete": $isFlowComplete,
        "setNextFlow": $setNextFlow,
        "actualSetOrder": $actualSetOrder,
        "servingTeam": $servingTeam,
        "servingPlayer": $servingPlayer,
        "returningPlayer": $returningPlayer,
            """;
  }
}

List<List<int>> orderFromJson(List<dynamic> json) {
  return json.map((e) => List<int>.from(e)).toList();
}
