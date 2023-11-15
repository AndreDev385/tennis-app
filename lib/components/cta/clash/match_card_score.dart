import 'package:flutter/material.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/dtos/sets_dto.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        match.player1.firstName,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
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
                            fontSize: 13,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        match.player2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
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
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 4)),
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
                          SetDto currSet = match.sets.list[index];
                          int myGames = currSet.myGames;
                          int rivalGames = currSet.rivalGames;

                          if (myGames == 0 && rivalGames == 0) {
                            return SizedBox();
                          }

                          return SizedBox(
                            width: 28,
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$myGames",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (currSet.tiebreak)
                                    Padding(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Text(
                                        "${currSet.myTiebreakPoints}",
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    )
                                ],
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
                          SetDto currSet = match.sets.list[index];
                          int myGames = currSet.myGames;
                          int rivalGames = currSet.rivalGames;

                          if (myGames == 0 && rivalGames == 0) {
                            return SizedBox();
                          }

                          return SizedBox(
                            width: 28,
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$rivalGames",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (currSet.tiebreak)
                                    Padding(
                                      padding: EdgeInsets.only(left: 1),
                                      child: Text(
                                        "${currSet.rivalTiebreakPoints}",
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                    )
                                ],
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
        else if (match.isPaused)
          const SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pausado",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          )
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
                      fontSize: 13,
                      color: MyTheme.cian),
                )
              ],
            ),
          ),
      ],
    );
  }
}
