import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/styles.dart';

class SetsSquares extends StatelessWidget {
  const SetsSquares({super.key, required this.showMySets});

  final bool showMySets;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    int idx = gameProvider.match!.currentSetIdx;
    int count = idx + 1;

    return ListView.builder(
      itemCount: count,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int mySets = gameProvider.getGamesWonAtSet(index);
        int rivalSets = gameProvider.getGamesLostAtSet(index);

        if (mySets == 0 && rivalSets == 0) {
          return SizedBox();
        }

        bool setWon() {
          if (showMySets) {
            return gameProvider.match!.sets[index].winSet;
          }
          return gameProvider.match!.sets[index].loseSet;
        }

        return SizedBox(
          width: 24,
          child: Center(
            child: Text(
              "${showMySets ? (mySets) : (rivalSets)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: setWon() ? MyTheme.green : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
