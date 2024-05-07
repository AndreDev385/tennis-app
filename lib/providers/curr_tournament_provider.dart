import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/tournaments/tournament.dart';

class CurrentTournamentProvider with ChangeNotifier {
  Tournament? currT;

  void setCurrTournament(Tournament t) {
    currT = t;
    notifyListeners();
  }
}
