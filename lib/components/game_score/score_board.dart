import "package:flutter/material.dart";

import "../../domain/shared/set.dart";
import "../../domain/shared/serve_flow.dart";
import "../../domain/shared/utils.dart";
import "../../styles.dart";
import "sets_squares.dart";

class ScoreBoard extends StatelessWidget {
  final String mode;

  final SingleServeFlow? singleServeFlow;
  final DoubleServeFlow? doubleServeFlow;
  final int? servingTeam;

  final String player1Name;
  final String player2Name;
  final String? player3Name;
  final String? player4Name;

  final String? points1;
  final String? points2;

  final List<Set> sets;
  final int currentSetIdx;

  final bool matchFinish;

  final bool darkBackground;

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
    this.darkBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: NamesSection(
                    team: Team.we,
                    mode: mode,
                    playerName: player1Name,
                    partnerName: player3Name,
                    matchFinish: matchFinish,
                    servingTeam: servingTeam,
                    singleServeFlow: singleServeFlow,
                    doubleServeFlow: doubleServeFlow,
                    darkBackground: darkBackground,
                  ),
                ),
                SetsSquares(
                  showMySets: true,
                  sets: this.sets,
                  idx: this.currentSetIdx,
                  showAll: matchFinish,
                  darkBackground: darkBackground,
                ),
                if (points1 != null)
                  Container(
                    decoration: const BoxDecoration(color: Colors.white12),
                    width: 32,
                    child: Center(
                      child: Text(
                        "${points1}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: darkBackground
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
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
                  child: NamesSection(
                    team: Team.their,
                    mode: mode,
                    playerName: player2Name,
                    partnerName: player4Name,
                    matchFinish: matchFinish,
                    servingTeam: servingTeam,
                    singleServeFlow: singleServeFlow,
                    doubleServeFlow: doubleServeFlow,
                    darkBackground: darkBackground,
                  ),
                ),
                SetsSquares(
                  showMySets: false,
                  sets: this.sets,
                  idx: this.currentSetIdx,
                  showAll: matchFinish,
                  darkBackground: darkBackground,
                ),
                if (points2 != null)
                  Container(
                    decoration: const BoxDecoration(color: Colors.white12),
                    width: 32,
                    child: Center(
                      child: Text(
                        "${this.points2}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: darkBackground
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
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

class NamesSection extends StatelessWidget {
  final String playerName;
  final String mode;
  final int team;
  final String? partnerName;
  final int? servingTeam;
  final SingleServeFlow? singleServeFlow;
  final DoubleServeFlow? doubleServeFlow;
  final bool matchFinish;

  final bool darkBackground;

  const NamesSection({
    super.key,
    required this.playerName,
    required this.mode,
    required this.matchFinish,
    required this.team,
    this.servingTeam,
    this.partnerName,
    this.singleServeFlow,
    this.doubleServeFlow,
    this.darkBackground = false,
  });
  @override
  Widget build(BuildContext context) {
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

    textColor() {
      return this.darkBackground
          ? Colors.white
          : Theme.of(context).colorScheme.onSurface;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              this.playerName,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: getServingPlayer(
                          team == Team.we ? PlayersIdx.me : PlayersIdx.rival,
                        ) &&
                        matchFinish == false
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: getServingPlayer(
                          team == Team.we ? PlayersIdx.me : PlayersIdx.rival,
                        ) &&
                        matchFinish == false
                    ? MyTheme.green
                    : textColor(),
              ),
            ),
          ),
        ),
        if (this.mode == GameMode.double)
          Text(
            " / ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor(),
            ),
          ),
        Expanded(
          child: Text(
            partnerName!,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: getServingPlayer(
                        team == Team.we
                            ? PlayersIdx.partner
                            : PlayersIdx.rival2,
                      ) &&
                      matchFinish == false
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: getServingPlayer(
                        team == Team.we
                            ? PlayersIdx.partner
                            : PlayersIdx.rival2,
                      ) &&
                      matchFinish == false
                  ? MyTheme.green
                  : textColor(),
            ),
          ),
        ),
        renderServingIcon(
          this.servingTeam,
          this.team,
        ),
      ],
    );
  }
}
