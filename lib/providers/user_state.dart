import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/user_dto.dart';

class UserState with ChangeNotifier {
  UserDto? user;

  void setCurrentUser(UserDto user) {
    this.user = user;
    notifyListeners();
  }
}
