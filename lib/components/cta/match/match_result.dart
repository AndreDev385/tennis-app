import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/results/match_result_container.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';

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
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const AppBarTitle(
          title: "Detalle de partido",
          icon: Icons.sports_tennis,
        ),
        centerTitle: true,
        elevation: 0,
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
          showMore ? "Mostrar menos" : "Mostrar más",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: () => changeShowMore(),
      ),
    );
  }
}
