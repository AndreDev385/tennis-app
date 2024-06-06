import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';

import '../../components/tournaments/match_page/result_container.dart';
import '../../domain/tournament/tournament_match.dart';
import '../../services/tournaments/match/get_match.dart';
import '../../utils/state_keys.dart';

class TournamentMatchDetail extends StatefulWidget {
  static const route = "/tournament-match-detail";

  final String matchId;

  const TournamentMatchDetail({
    super.key,
    required this.matchId,
  });

  @override
  State<TournamentMatchDetail> createState() => _TournamentMatchDetailState();
}

class _TournamentMatchDetailState extends State<TournamentMatchDetail> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };

  late TournamentMatch match;
  bool showMore = false;

  _toggleTable() {
    setState(() {
      showMore = !showMore;
    });
  }

  _getMatch() async {
    setState(() {
      state[StateKeys.loading] = true;
    });
    final result = await getMatch({"matchId": widget.matchId});

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error;
        state[StateKeys.loading] = false;
      });
      return;
    }

    setState(() {
      match = result.getValue();
      state[StateKeys.loading] = false;
    });
  }

  @override
  void initState() {
    _getMatch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    render() {
      if (state[StateKeys.loading]) {
        return Skeletonizer(
          child: TournamentMatchResult(
            match: TournamentMatch.skeleton(),
            showMore: showMore,
          ),
        );
      }
      if ((state[StateKeys.error] as String).length > 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  state[StateKeys.error],
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FilledButton(
                child: Text("Reintentar"),
                onPressed: () => _getMatch(),
              )
            ],
          ),
        );
      }
      return TournamentMatchResult(
        match: match,
        showMore: showMore,
      );
    }

    return Scaffold(
      /*backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.primary
          : null,*/
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTitle(
          title: "Detalle de partido",
          icon: Icons.sports_tennis,
        ),
      ),
      body: render(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(
          showMore ? Icons.remove : Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        label: Text(
          showMore ? "Menos" : "Más",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: () => _toggleTable(),
      ),
    );
  }
}
