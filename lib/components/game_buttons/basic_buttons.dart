import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';

class BasicButtons extends StatelessWidget {
  const BasicButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  gameProvider.score();
                },
                child: const Text(
                  "Ganó",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 8.0),
              height: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                ),
                onPressed: () {
                  gameProvider.rivalScore();
                },
                child: const Text(
                  "Perdió",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
