import 'package:flutter/material.dart';

class StatsBySet extends StatelessWidget {
  final int setsLength;
  final List<bool> setOptions;
  final Function handleSelectSet;

  const StatsBySet({
    required this.setsLength,
    required this.setOptions,
    required this.handleSelectSet,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> options() {
      if (setsLength == 5) {
        return [
          Text(
            "1er set",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            "2do set",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            "3er set",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            "4to set",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            "5to set",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            "Total",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ];
      }

      return [
        Text(
          "1er set",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          "2do set",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          "3er set",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          "Total",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ];
    }

    return setsLength == 1
        ? Container()
        : Container(
            padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
            color: Theme.of(context).colorScheme.background,
            height: 50,
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  ToggleButtons(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    constraints: const BoxConstraints(
                      minHeight: 30,
                      minWidth: 75,
                      maxWidth: 100,
                    ),
                    onPressed: (index) => handleSelectSet(index),
                    selectedColor: Theme.of(context).colorScheme.primary,
                    isSelected: setOptions,
                    children: options(),
                  ),
                ],
              ),
            ),
          );
  }
}
