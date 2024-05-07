import 'package:flutter/material.dart';
import 'package:tennis_app/domain/shared/set.dart';
import 'package:tennis_app/styles.dart';

class TournamentMatchCardScoreRow extends StatelessWidget {
  final bool hasWon;
  final int? number;
  final String name;
  final List<Set<Stats>> sets;
  final bool showRival;

  final bool showSets;

  const TournamentMatchCardScoreRow({
    super.key,
    required this.hasWon,
    required this.name,
    required this.sets,
    required this.showRival,
    required this.showSets,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: this.hasWon
              ? Theme.of(context).brightness == Brightness.light
                  ? Colors.greenAccent[100]
                  : Color(0x9900c853)
              : null,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    if (number != null)
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text("$number"),
                      ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(name),
                    ),
                    if (hasWon) Icon(Icons.check, color: MyTheme.green),
                  ],
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 84),
              child: Row(
                children: [
                  if (showSets)
                    ListView.builder(
                      itemCount: sets.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, idx) {
                        final currSet = sets[idx];

                        int gamesWon;
                        int tiebreakPts;
                        bool wonSet;

                        if (showRival) {
                          gamesWon = currSet.rivalGames;
                          tiebreakPts = currSet.rivalTiebreakPoints;
                          wonSet = currSet.loseSet;
                        } else {
                          gamesWon = currSet.myGames;
                          tiebreakPts = currSet.myTiebreakPoints;
                          wonSet = currSet.winSet;
                        }

                        bool IS_VOID_SET =
                            sets[idx].myGames == 0 && sets[idx].rivalGames == 0;

                        if (IS_VOID_SET) {
                          return SizedBox();
                        }

                        return SizedBox(
                          width: 28,
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$gamesWon",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: wonSet ? FontWeight.bold : null,
                                    color: wonSet
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                                ),
                                if (currSet.tiebreak)
                                  Padding(
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text(
                                      "$tiebreakPts",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
