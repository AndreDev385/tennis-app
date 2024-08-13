import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/results/render_result.dart';
import '../../domain/league/match.dart';
import '../../providers/game_rules.dart';

class ResultPage extends StatelessWidget {
  static const route = "/result";

  const ResultPage({super.key});

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/home");
            },
          ),
          centerTitle: true,
          title: Text("Resultado"),
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
