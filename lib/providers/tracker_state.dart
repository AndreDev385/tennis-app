import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/club_dto.dart';

class TrackerState with ChangeNotifier {
  ClubDto? currentClub;

  void setCurrentClub(ClubDto club) {
    currentClub = club;
    notifyListeners();
  }
}
