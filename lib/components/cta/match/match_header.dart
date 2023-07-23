import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/match_score_board.dart';
import 'package:tennis_app/dtos/match_dtos.dart';

class MatchHeader extends StatelessWidget {
  const MatchHeader({
    super.key,
    required this.matchState,
    this.servingPlayer,
    this.currentGame,
  });

  final MatchDto matchState;
  final int? servingPlayer;
  final GameDto? currentGame;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              const Text(
                "Sede: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(matchState.address),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 16)),
        MatchScoreBoard(
          match: matchState,
          playerServing: servingPlayer,
          currentGame: currentGame,
        ),
      ]),
    );
  }
}
