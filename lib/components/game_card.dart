import 'package:flutter/material.dart';
import 'package:tennis_app/domain/game_rules.dart';
import "package:tennis_app/domain/match.dart";
import 'package:tennis_app/styles.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Container(
        height: 112,
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            match.player1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (match.mode == GameMode.double)
                          Expanded(
                            child: Text(
                              match.player3,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    endIndent: 20,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            match.player2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (match.mode == GameMode.double)
                          Expanded(
                            child: Text(
                              match.player4,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 64,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ListView.builder(
                          itemCount: match.sets.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            int value = match.sets[index].myGames;

                            return SizedBox(
                              width: 32,
                              child: Center(
                                child: Text(
                                  "$value",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                        if (match.matchWon == true)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: MyTheme.yellow,
                              shape: BoxShape.circle,
                            ),
                          )
                        else
                          const Padding(padding: EdgeInsets.only(right: 10))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        ListView.builder(
                          itemCount: match.sets.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            int value = match.sets[index].rivalGames;

                            return SizedBox(
                              width: 32,
                              child: Center(
                                child: Text(
                                  "$value",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                        if (match.matchWon == false)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: MyTheme.yellow,
                              shape: BoxShape.circle,
                            ),
                          )
                        else
                          const Padding(padding: EdgeInsets.only(right: 10))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
