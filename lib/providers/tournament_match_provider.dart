import 'dart:convert';

import 'package:flutter/material.dart';

import '../domain/league/statistics.dart';
import '../domain/shared/serve_flow.dart';
import '../domain/shared/utils.dart';
import '../domain/tournament/tournament_match.dart';
import '../domain/tournament/tournament_match_stack.dart';
import '../services/storage.dart';
import '../services/utils.dart';

class TournamentMatchProvider with ChangeNotifier {
  TournamentMatch? match;
  TournamentMatchStack? stack;

  String get getMyPoints {
    if (!match!.currentGame.superTiebreak && !match!.currentGame.tiebreak) {
      return normalPoints[match!.currentGame.myPoints];
    }
    return "${match!.currentGame.myPoints}";
  }

  String get getRivalPoints {
    if (!match!.currentGame.superTiebreak && !match!.currentGame.tiebreak) {
      return normalPoints[match!.currentGame.rivalPoints];
    }

    return "${match?.currentGame.rivalPoints}";
  }

  get canGoBack {
    if (stack == null) {
      return false;
    }
    return stack?.canGoBack();
  }

  int getGamesWonAtSet(int idx) {
    return match?.sets[idx].myGames;
  }

  int getGamesLostAtSet(int idx) {
    return match?.sets[idx].rivalGames;
  }

  void finishMatch() {
    this.match = null;
    this.stack = null;
    this.removePendingMatch();
  }

  Future<void> createStorageMatch(TournamentMatch match) async {
    StorageHandler st = await createStorageHandler();

    st.saveTournamentMatch(jsonEncode(match.toJson()));
  }

  void updateStorageMatch() async {
    StorageHandler st = await createStorageHandler();

    st.saveTournamentMatch(jsonEncode(this.match!.toJson()));
  }

  /*
    Restore de match that is still live
    in the last state that was saved
  */
  Future<Result<void>> restorePendingMatch() async {
    StorageHandler st = await createStorageHandler();

    String? stringMatch = st.getTournamentMatch();

    if (stringMatch == null) {
      return Result.fail("Sin respaldo del partido");
    }

    final matchObj = jsonDecode(stringMatch);

    print(matchObj);

    match = TournamentMatch.fromJson(matchObj);

    this.match = match;
    stack = TournamentMatchStack();
    stack?.push(this.match!.clone());
    notifyListeners();

    return Result.ok(this.match!.matchId);
  }

  Future<void> removePendingMatch() async {
    StorageHandler st = await createStorageHandler();

    st.removeTournamentMatch();
  }

  void startTrackingMatch(TournamentMatch match, bool backup) {
    this.match = match;
    if (backup) {
      this.createStorageMatch(match);
    }
    stack = TournamentMatchStack();
    stack?.push(match.clone());
    notifyListeners();
  }

  void setDoubleService(
    int initialTeam,
    int playerServing,
    int playerReturning,
  ) {
    match?.setDoubleServing(
      initialTeam,
      playerServing,
      playerReturning,
    );
    stack?.push(match!.clone());
    notifyListeners();
  }

  void setSingleService(int initialPlayer) {
    match?.setSingleServe(initialPlayer);
    stack?.push(match!.clone());
    notifyListeners();
  }

  void setSuperTieBreak(bool value) {
    match?.setSuperTieBreak(value);
    notifyListeners();
  }

  void ace(bool isFirstServe) {
    int playerServing = match?.servingPlayer;
    int playerReturning = match?.returningPlayer;
    match?.tracker?.rallyPoint(
      rally: 0,
      playerWonSelected: playerServing,
      playerLostSelected: playerReturning,
    );
    match?.ace(isFirstServe);
    stack?.push(match!.clone());
    updateStorageMatch();
    notifyListeners();
  }

  void doubleFault() {
    int playerServing = match?.servingPlayer;
    int playerReturning = match?.returningPlayer;
    match?.tracker?.rallyPoint(
      rally: 0,
      playerWonSelected: playerReturning,
      playerLostSelected: playerServing,
    );
    match?.doubleFault();
    stack?.push(match!.clone());
    updateStorageMatch();
    notifyListeners();
  }

  // Saque no devuelto
  void servicePoint({required bool isFirstServe}) {
    int playerServing = match?.servingPlayer;
    int playerReturning = match?.returningPlayer;
    match?.tracker?.rallyPoint(
      rally: 0,
      playerWonSelected: playerServing,
      playerLostSelected: playerReturning,
    );
    match?.servicePoint(isFirstServe: isFirstServe);
    stack?.push(match!.clone());
    updateStorageMatch();
    notifyListeners();
  }

  void placePoint({
    required int place1,
    required int selectedPlayer1,
    required int place2,
    required int selectedPlayer2,
    required bool isFirstServe,
    required bool noForcedError,
    required bool winner,
    required int rally,
  }) {
    match?.tracker?.rallyPoint(
      rally: rally,
      playerWonSelected: selectedPlayer1,
      playerLostSelected: selectedPlayer2,
    );
    if (place1 == PlacePoint.mesh) {
      print("mesh place 1");
      match?.meshPoint(
        selectedPlayer: selectedPlayer1,
        winPoint: true,
        isFirstServe: isFirstServe,
        noForcedError: noForcedError,
        winner: winner,
        t1Score: selectedPlayer1 == PlayersIdx.me ||
            selectedPlayer1 == PlayersIdx.partner,
      );
    }
    if (place1 == PlacePoint.bckg) {
      print("bckg place 1");
      match?.bckgPoint(
        selectedPlayer: selectedPlayer1,
        winPoint: true,
        noForcedError: noForcedError,
        isFirstServe: isFirstServe,
        winner: winner,
        t1Score: selectedPlayer1 == PlayersIdx.me ||
            selectedPlayer1 == PlayersIdx.partner,
      );
    }
    if (place1 == PlacePoint.wonReturn) {
      print("returnWon place 1");
      match?.returnWon(
        winner: winner,
        isFirstServe: isFirstServe,
        noForcedError: noForcedError,
      );
    }

    if (place2 == PlacePoint.mesh) {
      print("mesh place 2");
      match?.meshPoint(
        selectedPlayer: selectedPlayer2,
        winPoint: false,
        isFirstServe: isFirstServe,
        noForcedError: noForcedError,
        winner: winner,
        t1Score: selectedPlayer1 == PlayersIdx.me ||
            selectedPlayer1 == PlayersIdx.partner,
      );
    }
    if (place2 == PlacePoint.bckg) {
      print("bckg place 2");
      match?.bckgPoint(
        selectedPlayer: selectedPlayer2,
        winPoint: false,
        noForcedError: noForcedError,
        isFirstServe: isFirstServe,
        winner: winner,
        t1Score: selectedPlayer1 == PlayersIdx.me ||
            selectedPlayer1 == PlayersIdx.partner,
      );
    }
    stack?.push(match!.clone());
    updateStorageMatch();
    notifyListeners();
  }

  void goBack() {
    stack?.pop();
    var head = stack?.peek();
    match = head?.clone();
    notifyListeners();
  }
}
