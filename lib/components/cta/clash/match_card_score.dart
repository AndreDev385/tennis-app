import 'package:flutter/material.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/styles.dart';

class MatchCardScore extends StatelessWidget {
  const MatchCardScore({super.key, required this.match});

  final MatchDto match;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                        match.player1.firstName,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 4)),
                    if (match.mode == GameMode.double)
                      Expanded(
                        child: Text(
                          "${match.player3?.firstName}",
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
                    const Padding(padding: EdgeInsets.only(right: 4)),
                    if (match.mode == GameMode.double)
                      Expanded(
                        child: Text(
                          "${match.player4}",
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
        if (match.isFinish)
          SizedBox(
            height: 64,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int value = match.sets.list[index].myGames;

                          return SizedBox(
                            width: 24,
                            child: Center(
                              child: Text(
                                "$value",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                        itemCount: match.sets.list.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int value = match.sets.list[index].rivalGames;

                          return SizedBox(
                            width: 24,
                            child: Center(
                              child: Text(
                                "$value",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                      if (match.matchWon == false &&
                          match.matchCancelled != true)
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
        else if (match.isLive)
          SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: MyTheme.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const Text(
                    "Live",
                    style: TextStyle(
                      color: MyTheme.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                ],
              ))
        else
          const SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "En espera",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MyTheme.cian),
                )
              ],
            ),
          ),
      ],
    );
  }
}
