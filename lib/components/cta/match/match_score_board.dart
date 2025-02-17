import 'package:flutter/material.dart';

import '../../../domain/shared/serve_flow.dart';
import '../../../domain/shared/utils.dart';
import '../../../dtos/game_dto.dart';
import '../../../dtos/match_dtos.dart';
import '../../../dtos/sets_dto.dart';
import '../../../styles.dart';
import '../../../utils/format_player_name.dart';

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
      if (match.status == MatchStatuses.Finished.index) {
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
          playerName: formatPlayerName(match.player1.name),
          showMine: true,
          partnerName: formatPlayerName(match.player3?.name),
          playerServing: playerServing,
          servingTeam: isTeamServing(Team.we),
          points: match.status == MatchStatuses.Finished.index
              ? null
              : getPoints(Team.we),
          renderWinGame:
              match.matchWon != null ? match.matchWon == true : false,
        ),
        ScoreRow(
          sets: match.sets,
          mode: match.mode,
          playerName: formatPlayerName(match.player2),
          partnerName: formatPlayerName(match.player4),
          showMine: false,
          playerServing: playerServing,
          servingTeam: isTeamServing(Team.their),
          points: match.status == MatchStatuses.Finished.index
              ? null
              : getPoints(Team.their),
          renderWinGame:
              match.matchWon != null ? match.matchWon == false : false,
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
      margin: const EdgeInsets.only(bottom: 8),
      height: 24,
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
                        showMine ? PlayersIdx.me : PlayersIdx.rival,
                      )
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                      color: isPlayerServing(
                        showMine ? PlayersIdx.me : PlayersIdx.rival,
                      )
                          ? MyTheme.green
                          : Theme.of(context).colorScheme.onPrimary,
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
              SetDto currSet = sets.list[index];
              int mySets = currSet.myGames;
              int rivalSets = currSet.rivalGames;

              if (mySets == 0 && rivalSets == 0 && index != 0) {
                return SizedBox();
              }

              final showColor = showMine
                  ? (currSet.setWon == true)
                  : (currSet.setWon == false);

              return SizedBox(
                width: 28,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${showMine ? mySets : rivalSets}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: showColor
                              ? MyTheme.green
                              : Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      if (currSet.tiebreak)
                        Padding(
                          padding: EdgeInsets.only(left: 1),
                          child: Text(
                            "${showMine ? currSet.myTiebreakPoints : currSet.rivalTiebreakPoints}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        )
                    ],
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
