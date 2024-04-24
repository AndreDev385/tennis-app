import "package:flutter/material.dart";

import "../../domain/shared/set.dart";
import "../../domain/shared/serve_flow.dart";
import "../../domain/shared/utils.dart";
import "../../styles.dart";
import "../../utils/format_player_name.dart";
import "sets_squares.dart";

class ScoreBoard extends StatelessWidget {
  final String mode;

  final SingleServeFlow? singleServeFlow;
  final DoubleServeFlow? doubleServeFlow;
  final int? servingTeam;

  final String player1Name;
  final String? player2Name;
  final String player3Name;
  final String? player4Name;

  final String? points1;
  final String? points2;

  final List<Set> sets;
  final int currentSetIdx;

  final bool matchFinish;

  const ScoreBoard({
    super.key,
    required this.mode,
    required this.singleServeFlow,
    required this.doubleServeFlow,
    required this.servingTeam,
    required this.player1Name,
    required this.player2Name,
    required this.player3Name,
    required this.player4Name,
    required this.points1,
    required this.points2,
    required this.matchFinish,
    required this.sets,
    required this.currentSetIdx,
  });

  @override
  Widget build(BuildContext context) {
    //Match match = gameProvider.match!;

    bool getServingPlayer(int player) {
      if (this.mode == GameMode.double) {
        if (this.doubleServeFlow == null) {
          return true;
        }
        return this.doubleServeFlow!.isPlayerServing(player);
      }
      if (this.singleServeFlow == null) {
        return true;
      }
      return this.singleServeFlow!.isPlayerServing(player);
    }

    Widget renderServingIcon(int? currentTeamServing, int? componentTeam) {
      if (currentTeamServing == componentTeam && !this.matchFinish) {
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
                          formatPlayerName(this.player1Name),
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
                      if (this.mode == GameMode.double)
                        const Text(
                          " / ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          formatPlayerName(this.player3Name),
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
                        this.servingTeam,
                        Team.we,
                      ),
                    ],
                  ),
                ),
                SetsSquares(
                  showMySets: true,
                  sets: this.sets,
                  idx: this.currentSetIdx,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white12),
                  width: 32,
                  child: Center(
                    child: Text(
                      "${points1}",
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
                          formatPlayerName(this.player2Name),
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
                      if (this.mode == GameMode.double)
                        const Text(
                          " / ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          formatPlayerName(this.player4Name),
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
                        this.servingTeam,
                        Team.their,
                      ),
                    ],
                  ),
                ),
                SetsSquares(
                  showMySets: false,
                  sets: this.sets,
                  idx: this.currentSetIdx,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white12),
                  width: 32,
                  child: Center(
                    child: Text(
                      "${this.points2}",
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
