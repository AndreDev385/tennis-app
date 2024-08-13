import 'dart:math';

import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:tennis_app/styles.dart';

List<String> buildDeepFilters(int value) {
  List<String> filters = [];

  for (var i = value; i >= 1; i--) {
    if (i == 1) {
      filters.add("Final");
      continue;
    }
    if (i == 2) {
      filters.add("Semi Final");
      continue;
    }
    if (i == 3) {
      filters.add("4tos Final");
      continue;
    }
    filters.add("${(pow(2, i) / 2).round()}vos");
  }

  return filters;
}

class BracketsFilters extends StatefulWidget {
  final int deep;
  final Function(int value) setDeep;

  const BracketsFilters({
    super.key,
    required this.deep,
    required this.setDeep,
  });

  @override
  State<StatefulWidget> createState() => _BracketsFilters();
}

class _BracketsFilters extends State<BracketsFilters> {
  int? _selected;

  @override
  void initState() {
    setState(() {
      _selected = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = buildDeepFilters(widget.deep);

    return GroupButton(
      controller: GroupButtonController(selectedIndex: _selected),
      options: GroupButtonOptions(
        borderRadius: BorderRadius.circular(MyTheme.regularBorderRadius),
        unselectedColor: Theme.of(context).colorScheme.secondary,
        unselectedTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onSelected: (text, int, bool) {
        setState(() {
          _selected = int;
        });
        widget.setDeep(_calculateDeepByIdx(int));
      },
      buttons: list,
    );
  }

  _calculateDeepByIdx(int value) {
    return (value - widget.deep) * -1;
  }
}
