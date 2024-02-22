import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tennis_app/domain/game_rules.dart";
import "package:tennis_app/domain/match.dart";
import "package:tennis_app/styles.dart";
import 'sets_squares.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    Match match = gameProvider.match!;

    bool getServingPlayer(int player) {
      if (match.mode == GameMode.double) {
        if (match.doubleServeFlow == null) {
          return true;
        }
        return match.doubleServeFlow!.isPlayerServing(player);
      }
      if (match.singleServeFlow == null) {
        return true;
      }
      return match.singleServeFlow!.isPlayerServing(player);
    }

    Widget renderServingIcon(int? currentTeamServing, int? componentTeam) {
      if (currentTeamServing == componentTeam &&
          !gameProvider.match!.matchFinish) {
        return Container(
          width: 32,
          child: Icon(
            Icons.sports_baseball,
            color: Colors.lightGreenAccent.shade700,
          ),
        );
      }
      return const SizedBox(width: 32);
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          match.player1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: getServingPlayer(PlayersIdx.me)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: getServingPlayer(PlayersIdx.me)
                                ? MyTheme.green
                                : null,
                          ),
                        ),
                      ),
                      if (match.mode == GameMode.double)
                        const Text(
                          " / ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          match.player3,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: getServingPlayer(PlayersIdx.partner)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: getServingPlayer(PlayersIdx.partner)
                                ? MyTheme.green
                                : null,
                          ),
                        ),
                      ),
                      renderServingIcon(
                        gameProvider.match?.servingTeam,
                        Team.we,
                      ),
                    ],
                  ),
                ),
                const SetsSquares(showMySets: true),
                Container(
                  decoration: const BoxDecoration(color: Colors.white12),
                  width: 32,
                  child: Center(
                    child: Text(
                      "${gameProvider.getMyPoints}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          match.player2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: getServingPlayer(PlayersIdx.rival)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: getServingPlayer(PlayersIdx.rival)
                                ? MyTheme.green
                                : null,
                          ),
                        ),
                      ),
                      if (match.mode == GameMode.double)
                        const Text(
                          " / ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          match.player4,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: getServingPlayer(PlayersIdx.rival2)
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: getServingPlayer(PlayersIdx.rival2)
                                ? MyTheme.green
                                : null,
                          ),
                        ),
                      ),
                      renderServingIcon(
                        gameProvider.match?.servingTeam,
                        Team.their,
                      ),
                    ],
                  ),
                ),
                const SetsSquares(showMySets: false),
                Container(
                  decoration: const BoxDecoration(color: Colors.white12),
                  width: 32,
                  child: Center(
                    child: Text(
                      "${gameProvider.getRivalPoints}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
