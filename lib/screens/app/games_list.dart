import 'package:flutter/material.dart';
import '../../components/game_card.dart';
import "package:tennis_app/domain/match.dart";

class GameList extends StatelessWidget {
  const GameList({super.key, required this.games});

  final List<Match> games;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: games.length,
          itemBuilder: (BuildContext context, int index) {
            print("INDEX $index");
            return GameCard(match: games[index]);
          },
        ),
      ],
    );
  }
}
