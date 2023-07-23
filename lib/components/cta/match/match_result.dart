import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/results/match_result_container.dart';
import 'package:tennis_app/screens/app/cta/home.dart';

class MatchResultArgs {
  final String matchId;

  const MatchResultArgs(this.matchId);
}

class MatchResult extends StatelessWidget {
  const MatchResult({super.key});

  static const route = "/match-result";

  @override
  Widget build(BuildContext context) {
    final MatchResultArgs args =
        ModalRoute.of(context)!.settings.arguments as MatchResultArgs;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.of(context).pushNamed(CtaHomePage.route);
        }),
        title: const Text("Resultado"),
        centerTitle: true,
      ),
      body: MatchResultContainer(matchId: args.matchId),
    );
  }
}
