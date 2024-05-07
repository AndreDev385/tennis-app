import 'package:flutter/material.dart';

@immutable
class MyTheme {
  static const yellow = Color(0xFFFABE4B);
  static const cian = Color(0xFF3F88C5);
  static const green = Color(0xFF00E19B);

  static const buttonBorderRadius = 16.0;

  // theme purple
  static const int _purple = 0xFF001242;
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

  // dark theme
  static const int _darkPrimary = 0xff0a3d62;
  static const MaterialColor darkPrimary =
      MaterialColor(_darkPrimary, <int, Color>{
    50: Color(0xFFF3F6F8),
    100: Color(0xFFE7ECF0),
    200: Color(0xFFC2CFD8),
    300: Color(0xFF9BB0BF),
    400: Color(0xFF547892),
    500: Color(_darkPrimary),
    600: Color(0xFF093758),
    700: Color(0xFF06253B),
    800: Color(0xFF051C2D),
    900: Color(0xFF03121D),
  });
}

ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: MyTheme.purple,
  fontFamily: "Poppins",
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: MyTheme.purple, //MyTheme.purple, // #1273EA
    primaryContainer: Color(0xffE9F5FE), // azul clarito E9F5FE
    onPrimary: Colors.white, // grey #F5F8FC
    secondary: Color(0xffe2e2e2), // azul 3387ED
    onSecondary: Colors.grey,
    secondaryContainer: Color(0xff3387ED),
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.grey,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceTint: Color(0xffeeeeee),
    tertiary: MyTheme.yellow,
  ),
  brightness: Brightness.light,
);

ThemeData darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: MyTheme.darkPrimary,
  fontFamily: "Poppins",
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.lightBlueAccent[700]!, // from page0a3d62 FF00141E
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF323232), // from page
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFd63031),
    onError: Color(0xFFffffff),
    background: Color(0xff111113),
    onBackground: Color(0xFFffffff),
    surface: Color(0xff19191c),
    onSurface: Colors.grey[200]!,
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
