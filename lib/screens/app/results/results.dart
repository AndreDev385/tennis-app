import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/components/results/render_result.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  static const route = "/result";

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);
    Match match = gameProvider.match!;

    return PopScope(
      onPopInvoked: (bool value) async {
        gameProvider.finishMatch();
        Navigator.of(context).pushNamed("/home");
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/home");
            },
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Resultado",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        body: ListView(children: [
          ResultTable(
            match: match,
          )
        ]),
      ),
    );
  }
}
