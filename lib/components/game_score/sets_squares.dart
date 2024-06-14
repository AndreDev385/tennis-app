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
        final currSet = sets[index];
        int mySets = currSet.myGames;
        int rivalSets = currSet.rivalGames;

        if (mySets == 0 && rivalSets == 0 && index != idx) {
          return SizedBox();
        }

        bool setWon() {
          if (showMySets) {
            return currSet.winSet;
          }
          return currSet.loseSet;
        }

        final tiebreakPts =
            showMySets ? currSet.myTiebreakPoints : currSet.rivalTiebreakPoints;

        return SizedBox(
          width: 28,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${showMySets ? (mySets) : (rivalSets)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: setWon() ? MyTheme.green : textColor(),
                  ),
                ),
                if (currSet.tiebreak)
                  Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      "${tiebreakPts}",
                      style: TextStyle(
                        fontSize: 11,
                        color: setWon() ? MyTheme.green : textColor(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
