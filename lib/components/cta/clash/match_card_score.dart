import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

import '../../../domain/shared/utils.dart';
import '../../../dtos/match_dtos.dart';
import '../../../dtos/sets_dto.dart';
import '../../../styles.dart';
import '../../../utils/format_player_name.dart';

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
                        formatPlayerName(match.player1.name),
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
                          formatPlayerName(match.player3?.name),
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
                        formatPlayerName(match.player2),
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
                          formatPlayerName(match.player4),
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
        if (match.status == MatchStatuses.Finished.index ||
            match.status == MatchStatuses.Canceled.index)
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
                                      color: currSet.setWon == true
                                          ? MyTheme.green
                                          : null,
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
                                      color: currSet.setWon == false
                                          ? MyTheme.green
                                          : null,
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
                ),
              ],
            ),
          )
        else if (match.status == MatchStatuses.Live.index)
          SizedBox(
              height: 64,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: MyTheme.green,
                          borderRadius: BorderRadius.circular(
                            MyTheme.regularBorderRadius,
                          ),
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
                  ),
                  Text(
                    "${format(match.updatedAt, locale: "es")}",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ))
        else if (match.status == MatchStatuses.Paused.index)
          SizedBox(
            height: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Pausado",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                Text(
                  "${format(match.updatedAt, locale: "es")}",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          )
        else
          SizedBox(
            height: 64,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "En espera",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: MyTheme.cian),
                    )
                  ],
                ),
                Text(
                  "${format(match.updatedAt, locale: "es")}",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
      ],
    );
  }
}
