import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/results/match_result_container.dart';
import 'package:tennis_app/screens/app/cta/home.dart';

class MatchResultArgs {
  final String matchId;

  const MatchResultArgs(this.matchId);
}

class MatchResult extends StatefulWidget {
  const MatchResult({super.key});

  static const route = "/match-result";

  @override
  State<MatchResult> createState() => _MatchResultState();
}

class _MatchResultState extends State<MatchResult> {
  bool showMore = false;

  changeShowMore() {
    setState(() {
      showMore = !showMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MatchResultArgs args =
        ModalRoute.of(context)!.settings.arguments as MatchResultArgs;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.of(context).pushNamed(CtaHomePage.route);
        }),
        title: const Text("Resultado"),
        centerTitle: true,
      ),
      body: MatchResultContainer(
        matchId: args.matchId,
        showMore: showMore,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(
          showMore ? Icons.remove : Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        label: Text(
          showMore ? "Mostrar Menos" : "Mostrar Mas",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: () => changeShowMore(),
      ),
    );
  }
}
