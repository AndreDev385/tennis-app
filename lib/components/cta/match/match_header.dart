import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/match_score_board.dart';
import 'package:tennis_app/dtos/game_dto.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/styles.dart';

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
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        Row(
            children: [
              Icon(
                Icons.location_pin,
                color: MyTheme.green,
              ),
              Padding(padding: EdgeInsets.only(right: 4)),
              Text(
                matchState.address,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
        ),
        Row(
            children: [
              Icon(
                Icons.map,
                color: MyTheme.green,
              ),
              Padding(padding: EdgeInsets.only(right: 4)),
              Text(
                matchState.surface,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 12)),
        MatchScoreBoard(
          match: matchState,
          playerServing: servingPlayer,
          currentGame: currentGame,
        ),
      ]),
    );
  }
}
