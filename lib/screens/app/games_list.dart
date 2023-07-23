import 'package:flutter/material.dart';
import '../../components/game_card.dart';

class GameList extends StatelessWidget {
  const GameList({super.key, required this.games});

  final List<String> games;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: games.length,
          itemBuilder: (BuildContext context, int index) {
            final name = games[index];
            return GameCard(
              title: name,
              index: index,
            );
          },
        ),
      ],
    );
  }
}
