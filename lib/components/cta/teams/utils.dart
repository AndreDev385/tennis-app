import 'package:flutter/material.dart';

Color positionColor(int idx) {
  if (idx == 1) {
    return Colors.amber.shade400;
  }
  if (idx == 2) {
    return Colors.blueGrey.shade100;
  }
  if (idx == 3) {
    return Colors.amber.shade900;
  }

  return Colors.white10;
}

Color backgroundColor(int idx, BuildContext context) {
  if (Theme.of(context).brightness == Brightness.light) {
    return idx % 2 == 0 ? Colors.black12 : Colors.white;
  }
  return idx % 2 == 0
      ? Theme.of(context).colorScheme.surface
      : Theme.of(context).colorScheme.background;
}
