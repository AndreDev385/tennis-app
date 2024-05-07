import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tennis_app/domain/shared/serve_flow.dart';

import '../domain/league/statistics.dart';
import '../domain/shared/utils.dart';
import '../domain/tournament/tournament_match.dart';
import '../domain/tournament/tournament_match_stack.dart';
import '../services/storage.dart';

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

  void resumePausedMatch(TournamentMatch match) {
    this.match = match;
    this.stack = TournamentMatchStack();
    notifyListeners();
  }

  void finishMatch() {
    this.match = null;
    this.stack = null;
  }

  Future<void> createStorageMatch(TournamentMatch match) async {
    StorageHandler st = await createStorageHandler();

    //st.saveTennisLiveMatch(jsonEncode());
  }

  void updateStorageMatch() async {
    StorageHandler st = await createStorageHandler();

    String? stringMatch = st.getTennisLiveMatch();

    if (stringMatch == null) {
      return;
    }

    final matchObj = jsonDecode(stringMatch);

    /*st.saveTennisLiveMatch(
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
    );*/
  }

  Future<void> restorePendingMatch() async {
    StorageHandler st = await createStorageHandler();

    //String? stringMatch = st.getTennisLiveMatch();

    //if (stringMatch == null) {
    //  return;
    //}

    //final matchObj = jsonDecode(stringMatch);

    //this.match = Match.fromJson(matchObj);
  }

  Future<void> removePendingMatch() async {
    StorageHandler st = await createStorageHandler();

    st.removeTennisLiveMatch();
  }

  void startTrackingMatch(TournamentMatch match) {
    this.match = match;
    stack = TournamentMatchStack();
    stack?.push(match.clone());
    notifyListeners();
  }

  //void setSingleGamePlayers(String me, String rival) {
  //  match?.player1 = me;
  //  match?.player2 = rival;
  //  notifyListeners();
  //}

  //void setDoubleGamePlayers(
  //  String me,
  //  String partner,
  //  String rival1,
  //  String rival2,
  //) {
  //  match?.player1 = me;
  //  match?.player2 = rival1;
  //  match?.player3 = partner;
  //  match?.player4 = rival2;
  //  notifyListeners();
  //}

  void setDoubleService(
      int initialTeam, int playerServing, int playerReturning) {
    match?.setDoubleServing(initialTeam, playerServing, playerReturning);
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

    print("""
    place1: $place1,
    place2: $place2,
    p1: $selectedPlayer1,
    p2: $selectedPlayer2,
    """);
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
