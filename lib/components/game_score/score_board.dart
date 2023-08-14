import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tennis_app/domain/game_rules.dart";
import "package:tennis_app/domain/match.dart";
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
          margin: const EdgeInsets.only(right: 8, left: 8),
          child: const Icon(Icons.sports_baseball),
        );
      }
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
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
                      Row(
                        children: [
                          Text(
                            match.player1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: getServingPlayer(PlayersIdx.me)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (match.mode == GameMode.double)
                            const Text(
                              " / ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Text(
                            match.player3,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: getServingPlayer(PlayersIdx.partner)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      renderServingIcon(
                          gameProvider.match?.servingTeam, Team.we),
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
                          fontSize: 16, fontWeight: FontWeight.bold),
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
                      Row(
                        children: [
                          Text(
                            match.player2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: getServingPlayer(PlayersIdx.rival)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (match.mode == GameMode.double)
                            const Text(
                              " / ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Text(
                            match.player4,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: getServingPlayer(PlayersIdx.rival2)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      renderServingIcon(
                          gameProvider.match?.servingTeam, Team.their),
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
                          fontSize: 16, fontWeight: FontWeight.bold),
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
