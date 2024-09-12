import 'dart:convert';

import "package:flutter/material.dart";

import '../domain/league/match.dart';
import '../domain/league/match_stack.dart';
import '../domain/league/statistics.dart';
import '../domain/shared/game.dart';
import '../domain/shared/serve_flow.dart';
import '../domain/shared/utils.dart';
import '../dtos/match_dtos.dart';
import '../services/storage.dart';

class GameRules with ChangeNotifier {
  Match? match;
  MatchStack? stack;

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
    match = Match(
      mode: matchDto.mode,
      setsQuantity: matchDto.setsQuantity,
      surface: matchDto.surface,
      gamesPerSet: matchDto.gamesPerSet,
      currentGame: Game(),
    );
    match?.setStatistics(Statistics.advanced);
    match?.player1 = matchDto.player1.name;
    match?.player2 = matchDto.player2;
    if (matchDto.mode == GameMode.double) {
      match?.player3 = matchDto.player3!.name;
      match?.player4 = matchDto.player4!;
    }
    this.stack = MatchStack();
    stack?.push(match!.clone());

    notifyListeners();
  }

  Future<void> createStorageMatch(MatchDto matchDto) async {
    StorageHandler st = await createStorageHandler();

    st.saveTennisLiveMatch(jsonEncode(
      match?.toJson(
        matchId: matchDto.matchId,
        trackerId: matchDto.tracker?.trackerId,
        player1Id: matchDto.player1.playerId,
        player1TrackerId: matchDto.tracker?.me.playerTrackerId,
        player2Id: matchDto.player3?.playerId,
        player2TrackerId: matchDto.tracker?.partner?.playerTrackerId,
      ),
    ));
  }

  void updateStorageMatch() async {
    StorageHandler st = await createStorageHandler();

    String? stringMatch = st.getTennisLiveMatch();

    if (stringMatch == null) {
      return;
    }

    final matchObj = jsonDecode(stringMatch);

    st.saveTennisLiveMatch(
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
    StorageHandler st = await createStorageHandler();

    String? stringMatch = st.getTennisLiveMatch();

    if (stringMatch == null) {
      return;
    }

    final matchObj = jsonDecode(stringMatch);

    this.stack = MatchStack();
    this.match = Match.fromJson(matchObj);
    this.stack!.push(this.match!.clone());
    notifyListeners();
  }

  Future<void> removePendingMatch() async {
    StorageHandler st = await createStorageHandler();

    st.removeTennisLiveMatch();
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
    stack = MatchStack();
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
    required bool noForcedError,
    required bool winner,
    int? rally,
  }) {
    match?.tracker?.winRally(rally ?? 0, winPoint);
    if (place == PlacePoint.mesh) {
      match?.meshPoint(
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
        isFirstServe: isFirstServe,
        noForcedError: noForcedError,
        winner: winner,
      );
    }
    if (place == PlacePoint.bckg) {
      match?.bckgPoint(
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
        noForcedError: noForcedError,
        isFirstServe: isFirstServe,
        winner: winner,
      );
    }
    if (place == PlacePoint.wonReturn) {
      match?.returnWon(
        winner: winner,
        isFirstServe: isFirstServe,
        winPoint: true,
        noForcedError: noForcedError,
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
