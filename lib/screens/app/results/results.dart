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

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed("/home");
        gameProvider.finishMatch();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.of(context).pushNamed("/home");
          }),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Resultado"),
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
