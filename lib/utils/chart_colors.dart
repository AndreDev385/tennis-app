import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';

List<Color> barColorByType(int type) {
  switch (type) {
    case 0:
      return [
        Color(0xffFAFF00),
        Color(0xff00E19B),
      ];
    case 1:
      return [
        Color(0xff315FD9),
        Color(0xffFF00B8),
      ];
    case 2:
      return [
        Color(0xFFd63031),
        MyTheme.yellow,
      ];
    default:
      return [
        Color(0xffFAFF00),
        Color(0xff00E19B),
      ];
  }
}

Color barBackgroundColor(int type) {
  switch (type) {
    case 0:
      return Color(0xaaABFFE5);
    case 1:
      return Color(0xaa8FA6E2);
    case 2:
      return Color(0xaaFDE8BE);
    default:
      return Color(0xaa00E19B);
  }
}
