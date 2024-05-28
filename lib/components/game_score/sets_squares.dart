import 'package:flutter/material.dart';

import '../../domain/shared/set.dart';
import '../../styles.dart';

class SetsSquares extends StatelessWidget {
  final bool showMySets;
  final bool showAll;
  final int idx;
  final List<Set> sets;
  final bool darkBackground;

  const SetsSquares({
    super.key,
    required this.showMySets,
    required this.idx,
    required this.sets,
    required this.showAll,
    this.darkBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    int count = this.idx + 1;

    textColor() {
      return darkBackground
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.onSurface;
    }

    return ListView.builder(
      itemCount: showAll ? sets.length : count,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int mySets = sets[index].myGames;
        int rivalSets = sets[index].rivalGames;

        if (mySets == 0 && rivalSets == 0 && index != idx) {
          return SizedBox();
        }

        bool setWon() {
          if (showMySets) {
            return sets[index].winSet;
          }
          return sets[index].loseSet;
        }

        return SizedBox(
          width: 24,
          child: Center(
            child: Text(
              "${showMySets ? (mySets) : (rivalSets)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: setWon() ? MyTheme.green : textColor(),
              ),
            ),
          ),
        );
      },
    );
  }
}
