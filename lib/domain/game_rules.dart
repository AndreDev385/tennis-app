import 'dart:convert';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/domain/statistics.dart';
import 'package:tennis_app/dtos/match_dtos.dart';

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

  void resumePausedMatch(Match match) {
    this.match = match;
    this.stack = MatchStack();
    notifyListeners();
  }

  void finishMatch() {
    this.match = null;
    this.stack = null;
  }

  void createClubMatch({
    required MatchDto matchDto,
  }) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    match = Match(
      mode: matchDto.mode,
      setsQuantity: matchDto.setsQuantity,
      surface: matchDto.surface,
      gamesPerSet: matchDto.gamesPerSet,
      currentGame: Game(),
    );
    match?.setStatistics(Statistics.advanced);
    match?.player1 = matchDto.player1.firstName;
    match?.player2 = matchDto.player2;
    if (matchDto.mode == GameMode.double) {
      match?.player3 = matchDto.player3!.firstName;
      match?.player4 = matchDto.player4!;
    }

    notifyListeners();
  }

  void createStorageMatch(MatchDto matchDto) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    storage.setString(
      "live",
      jsonEncode(
        match?.toJson(
          matchId: matchDto.matchId,
          trackerId: matchDto.tracker?.trackerId,
          player1Id: matchDto.player1.playerId,
          player1TrackerId: matchDto.tracker?.me.playerTrackerId,
          player2Id: matchDto.player3?.playerId,
          player2TrackerId: matchDto.tracker?.partner?.playerTrackerId,
        ),
      ),
    );
  }

  void updateStorageMatch() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String? stringMatch = storage.getString('live');

    if (stringMatch == null) {
      return;
    }

    final matchObj = jsonDecode(stringMatch);

    print(matchObj);

    storage.setString(
      "live",
      jsonEncode(
        this.match?.toJson(
              matchId: matchObj['tracker']['matchId'],
              trackerId: matchObj['tracker']?['trackerId'],
              player1Id: matchObj['tracker']?['me']['playerId'],
              player1TrackerId: matchObj['tracker']?['me']['playerTrackerId'],
              player2Id: matchObj['tracker']?['partner']?['playerId'],
              player2TrackerId: matchObj['tracker']?['partner']
                  ?['playerTrackerId'],
            ),
      ),
    );
  }

  Future<void> restorePendingMatch() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String? stringMatch = storage.getString('live');

    if (stringMatch == null) {
      return;
    }

    final matchObj = jsonDecode(stringMatch);

    this.match = Match.fromJson(matchObj);
  }

  Future<void> removePendingMatch() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    await storage.remove("live");
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
      gamesPerSet: setType,
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
    updateStorageMatch();
    notifyListeners();
  }

  void doubleFault() {
    match?.tracker?.winRally(0, match?.servingTeam != Team.we);
    match?.doubleFault();
    stack?.push(match!.clone());
    updateStorageMatch();
    notifyListeners();
  }

  void servicePoint({required bool isFirstServe}) {
    match?.tracker?.winRally(0, match?.servingTeam == Team.we);
    match?.servicePoint(isFirstServe: isFirstServe);
    stack?.push(match!.clone());
    updateStorageMatch();
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
      match?.returnWon(
        noForcedError: noForcedError,
        isFirstServe: isFirstServe,
        winPoint: true,
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
