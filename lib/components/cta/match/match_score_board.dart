import 'package:flutter/material.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/styles.dart';

class MatchScoreBoard extends StatelessWidget {
  const MatchScoreBoard({
    super.key,
    required this.match,
    this.playerServing,
    this.currentGame,
  });

  final GameDto? currentGame;
  final int? playerServing;
  final MatchDto match;

  @override
  Widget build(BuildContext context) {
    bool isTeamServing(int team) {
      if (match.isFinish) {
        return false;
      }
      if (playerServing == null) {
        return false;
      }
      if (team == Team.we) {
        return playerServing! == PlayersIdx.me ||
            playerServing! == PlayersIdx.partner;
      }
      return playerServing! == PlayersIdx.rival ||
          playerServing! == PlayersIdx.rival2;
    }

    getPoints(int team) {
      if (currentGame != null) {
        if (team == Team.we) {
          return currentGame!.isTieBreak
              ? currentGame!.myPoints
              : normalPoints[currentGame!.myPoints];
        }
        return currentGame!.isTieBreak
            ? currentGame!.rivalPoints
            : normalPoints[currentGame!.rivalPoints];
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ScoreRow(
          sets: match.sets,
          mode: match.mode,
          playerName: match.player1.firstName,
          showMine: true,
          partnerName: match.player3?.firstName,
          playerServing: playerServing,
          servingTeam: isTeamServing(Team.we),
          points: match.isFinish ? null : getPoints(Team.we),
          renderWinGame:
              match.matchWon != null ? match.matchWon == true : false,
        ),
        ScoreRow(
          sets: match.sets,
          mode: match.mode,
          playerName: match.player2,
          showMine: false,
          partnerName: match.player4,
          playerServing: playerServing,
          servingTeam: isTeamServing(Team.their),
          points: match.isFinish ? null : getPoints(Team.their),
          renderWinGame: match.matchWon != null
              ? match.matchWon == false &&
                  match.matchCancelled == false &&
                  match.isFinish == true
              : false,
        ),
      ],
    );
  }
}

class ScoreRow extends StatelessWidget {
  const ScoreRow({
    super.key,
    required this.sets,
    required this.mode,
    required this.playerName,
    required this.showMine,
    required this.servingTeam,
    required this.renderWinGame,
    this.partnerName,
    this.playerServing,
    this.points,
  });

  final dynamic points;
  final Sets sets;
  final String playerName;
  final String? partnerName;
  final String mode;
  final bool showMine;
  final bool servingTeam;
  final int? playerServing;
  final bool renderWinGame;

  Widget renderServingIcon() {
    if (servingTeam) {
      return Container(
        width: 32,
        child: const Icon(
          Icons.sports_baseball,
          color: MyTheme.green,
        ),
      );
    }
    return const SizedBox(width: 32);
  }

  bool isPlayerServing(int player) {
    if (playerServing == null) {
      return false;
    }
    return playerServing == player;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    playerName,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: isPlayerServing(
                              showMine ? PlayersIdx.me : PlayersIdx.rival)
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                if (mode == GameMode.double)
                  Text(
                    " / ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                if (mode == GameMode.double)
                  Expanded(
                    child: Text(
                      partnerName!,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: isPlayerServing(showMine
                                ? PlayersIdx.partner
                                : PlayersIdx.rival2)
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                renderServingIcon(),
              ],
            ),
          ),
          ListView.builder(
            itemCount: sets.list.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              int mySets;
              if (showMine) {
                mySets = sets.list[index].myGames;
              } else {
                mySets = sets.list[index].rivalGames;
              }

              return SizedBox(
                width: 24,
                child: Center(
                  child: Text(
                    "$mySets",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              );
            },
          ),
          if (renderWinGame)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: MyTheme.yellow,
                shape: BoxShape.circle,
              ),
            )
          else
            const Padding(padding: EdgeInsets.only(right: 10)),
          if (points != null)
            Container(
              decoration: const BoxDecoration(color: Colors.white12),
              width: 32,
              child: Center(
                child: Text(
                  "$points",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
