import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/tournaments/match_card/match_card.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/services/tournaments/paginate_match.dart';

import '../../../utils/state_keys.dart';

class TournamentMatchesSection extends StatefulWidget {
  final String contestId;
  final bool loading;

  const TournamentMatchesSection({
    super.key,
    required this.loading,
    required this.contestId,
  });

  @override
  State<StatefulWidget> createState() => _TournamentMatches();
}

class _TournamentMatches extends State<TournamentMatchesSection> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
  };

  List<TournamentMatch> matches = [];
  int count = 0;
  int page = 0;

  _paginateMatches() async {
    final result = await paginateMatch({'contestId': widget.contestId});

    if (result.isFailure) {
      return;
    }

    setState(() {
      matches = result.getValue().rows;
      count = result.getValue().count;
      state[StateKeys.loading] = false;
    });
  }

  @override
  void initState() {
    _paginateMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.loading || state[StateKeys.loading],
      child: render(context),
    );
  }

  render(BuildContext context) {
    if (state[StateKeys.loading]) {
      final fakeMatches = List.filled(4, TournamentMatch.skeleton());
      return ListView(
        children: fakeMatches.map((m) {
          return TournamentMatchCard(match: m);
        }).toList(),
      );
    }
    if (matches.length == 0) {
      return Center(
        child: Text(
          "No se han registrado partidos",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return ListView(
      children: matches.map((m) {
        return TournamentMatchCard(match: m);
      }).toList(),
    );
  }
}
