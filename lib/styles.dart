import 'package:flutter/material.dart';

@immutable
class MyTheme {
  static const yellow = Color(0xFFFABE4B);
  static const cian = Color(0xFF3F88C5);
  static const green = Color(0xFF00E19B);

  // theme purple
  static const MaterialColor purple = MaterialColor(_purple, <int, Color>{
    50: Color(0xFFE0E3E8),
    100: Color(0xFFB3B8C6),
    200: Color(0xFF8089A1),
    300: Color(0xFF4D597B),
    400: Color(0xFF26365E),
    500: Color(_purple),
    600: Color(0xFF00103C),
    700: Color(0xFF000D33),
    800: Color(0xFF000A2B),
    900: Color(0xFF00051D),
  });

  static const int _purple = 0xFF001242;

  static const MaterialColor mcgpalettAccent =
      MaterialColor(_purple, <int, Color>{
    100: Color(0xFF5B66FF),
    200: Color(_mcgpalettAccentValue),
    400: Color(0xFF0011F4),
    700: Color(0xFF000FDA),
  });
  static const int _mcgpalettAccentValue = 0xFF2837FF;
}

ThemeData lightTheme = ThemeData(
  primarySwatch: MyTheme.purple,
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
