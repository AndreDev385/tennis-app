import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/tournaments/contest.dart';
import 'package:tennis_app/dtos/tournaments/tournament.dart';

class CurrentTournamentProvider with ChangeNotifier {
  Tournament? currT;
  Contest? contest;

  void setCurrTournament(Tournament t) {
    currT = t;
    notifyListeners();
  }

  void setContest(Contest c) {
    contest = c;
    notifyListeners();
  }
}
