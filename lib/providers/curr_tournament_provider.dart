import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/tournaments/contest.dart';
import 'package:tennis_app/dtos/tournaments/tournament.dart';

class CurrentTournamentProvider with ChangeNotifier {
  Tournament? tournament;
  Contest? contest;
  int selectedIdx = 0;

  void setCurrTournament(Tournament t) {
    tournament = t;
    notifyListeners();
  }

  void setContest(Contest c) {
    contest = c;
    notifyListeners();
  }

  void setIdx(int number) {
    selectedIdx = number;
    notifyListeners();
  }
}
