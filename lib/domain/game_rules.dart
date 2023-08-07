import "package:flutter/material.dart";
import 'package:tennis_app/domain/statistics.dart';

import 'game.dart';
import "./match.dart";
import 'match_stack.dart';

part "utils.dart";

class GameRules with ChangeNotifier {
  Match? match;
  MatchStack? stack;
  get getMyPoints {
    if (!match?.currentGame.superTiebreak && !match?.currentGame.tiebreak) {
      return normalPoints[match?.currentGame.myPoints];
    }
    return match?.currentGame.myPoints;
  }

  get getRivalPoints {
    if (!match?.currentGame.superTiebreak && !match?.currentGame.tiebreak) {
      return normalPoints[match?.currentGame.rivalPoints];
    }

    return match?.currentGame.rivalPoints;
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

  void createClubMatch({
    required String mode,
    required int setsQuantity,
    required String surface,
    required int setType,
    required String direction,
    required String statistics,
    required String p1,
    required String p2,
    required String? p3,
    required String? p4,
  }) {
    match = Match(
      mode: mode,
      setsQuantity: setsQuantity,
      surface: surface,
      gamePerSet: setType,
      currentGame: Game(),
    );
    match?.setStatistics(Statistics.advanced);
    match?.player1 = p1;
    match?.player2 = p2;
    if (mode == GameMode.double) {
      match?.player3 = p3!;
      match?.player4 = p4!;
    }
    notifyListeners();
  }

  void createNewMatch(
    String mode,
    int setsQuantity,
    String surface,
    int setType,
    String direction,
  ) {
    match = Match(
      mode: mode,
      setsQuantity: setsQuantity,
      surface: surface,
      gamePerSet: setType,
      currentGame: Game(),
    );
    notifyListeners();
  }

  void setStatistics(String value) {
    match?.setStatistics(value);
    notifyListeners();
  }

  void setSingleGamePlayers(String me, String rival) {
    match?.player1 = me;
    match?.player2 = rival;
    notifyListeners();
  }

  void setDoubleGamePlayers(
    String me,
    String partner,
    String rival1,
    String rival2,
  ) {
    match?.player1 = me;
    match?.player2 = rival1;
    match?.player3 = partner;
    match?.player4 = rival2;
    notifyListeners();
  }

  void setDoubleService(
      int initialTeam, int playerServing, int playerReturning) {
    match?.setDoubleServing(initialTeam, playerServing, playerReturning);
    stack = MatchStack();
    stack?.push(match!.clone());
    notifyListeners();
  }

  void setSingleService(int initialPlayer) {
    match?.setSingleServe(initialPlayer);
    stack = MatchStack();
    stack?.push(match!.clone());
    notifyListeners();
  }

  void setSuperTieBreak(bool value) {
    match?.setSuperTieBreak(value);
    notifyListeners();
  }

  void score() {
    match?.score();
    stack?.push(match!.clone());
    notifyListeners();
  }

  void rivalScore() {
    match?.rivalScore();
    stack?.push(match!.clone());
    notifyListeners();
  }

  void ace(bool isFirstServe) {
    match?.tracker?.winRally(0, match?.servingTeam == Team.we);
    match?.ace(isFirstServe);
    stack?.push(match!.clone());
    notifyListeners();
  }

  void doubleFault() {
    match?.tracker?.winRally(0, match?.servingTeam != Team.we);
    match?.doubleFault();
    stack?.push(match!.clone());
    notifyListeners();
  }

  void servicePoint({required bool isFirstServe}) {
    match?.tracker?.winRally(0, match?.servingTeam == Team.we);
    match?.servicePoint(isFirstServe: isFirstServe);
    stack?.push(match!.clone());
    notifyListeners();
  }

  void placePoint({
    required int place,
    required int selectedPlayer,
    required bool winPoint,
    required bool isFirstServe,
    bool noForcedError = false,
    int? rally,
  }) {
    match?.tracker?.winRally(rally ?? 0, winPoint);
    if (place == PlacePoint.mesh) {
      match?.meshPoint(
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
        noForcedError: noForcedError,
        isFirstServe: isFirstServe,
      );
    }
    if (place == PlacePoint.bckg) {
      match?.bckgPoint(
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
        noForcedError: noForcedError,
        isFirstServe: isFirstServe,
      );
    }
    if (place == PlacePoint.winner) {
      match?.winner(
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
        isFirstServe: isFirstServe,
      );
    }
    if (place == PlacePoint.wonReturn) {
      match?.returnPoint(
        noForcedError: noForcedError,
        isFirstServe: isFirstServe,
        winPoint: true,
      );
    }
    stack?.push(match!.clone());
    notifyListeners();
  }

  void goBack() {
    stack?.pop();
    var head = stack?.peek();
    match = head?.clone();
    notifyListeners();
  }
}
