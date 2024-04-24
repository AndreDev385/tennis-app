import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/tournaments/match_card/match_card.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/services/tournaments/paginate_match.dart';
import 'package:tennis_app/services/utils.dart';

import '../../../utils/state_keys.dart';

class TournamentMatchesSection extends StatefulWidget {
  final bool loading;

  const TournamentMatchesSection({
    super.key,
    required this.loading,
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
    final result = await paginateMatch({});

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
    return ListView(
      children: matches.map((m) {
        return TournamentMatchCard();
      }).toList(),
    );
  }
}
