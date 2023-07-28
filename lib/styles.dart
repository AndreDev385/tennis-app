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
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff3387ED), //MyTheme.purple, // #1273EA
    primaryContainer: Color(0xffE9F5FE), // azul clarito E9F5FE
    onPrimary: Colors.white, // grey #F5F8FC
    secondary: Color(0xffF5F8FC), // azul 3387ED
    onSecondary: Colors.grey,
    secondaryContainer: Color(0xff3387ED),
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.grey,
    surface: Colors.white,
    onSurface: Color(0xff546e7a),
    surfaceTint: Color(0xffeeeeee),
    tertiary: MyTheme.yellow,

  ),
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF001E28), // from page0a3d62
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF001E28), // from page
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFd63031),
    onError: Color(0xFFffffff),
    background: Color(0xFF010A0F),
    onBackground: Color(0xFFffffff),
    surface: Color(0xFF00141E),
    onSurface: Color(0xFFffffff),
    tertiary: MyTheme.yellow,
    onTertiary: MyTheme.yellow,
  ),
  //primarySwatch: MyTheme.purple,
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
