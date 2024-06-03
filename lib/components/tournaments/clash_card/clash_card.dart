import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/tournaments/clash_card/clash_without_matches.dart';
import 'package:tennis_app/components/tournaments/clash_card/match_row.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/providers/user_state.dart';
import 'package:tennis_app/services/tournaments/match/paginate_match.dart';

import '../../../dtos/tournaments/contest_clash.dart';
import '../../../styles.dart';
import '../../../utils/state_keys.dart';
import '../../shared/loading_ring.dart';

class ContestClashCard extends StatefulWidget {
  final ContestClash clash;

  const ContestClashCard({
    super.key,
    required this.clash,
  });

  @override
  State<StatefulWidget> createState() {
    return _ContestClashCard();
  }
}

class _ContestClashCard extends State<ContestClashCard> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };
  List<TournamentMatch> matches = [];
  bool hasBeenOpen = false;

  _findMatches() async {
    if (widget.clash.matchIds.isEmpty) {
      setState(() {
        state[StateKeys.loading] = false;
        matches = [];
      });
      return;
    }
    final result = await paginateTournamentMatches(
      {"matchId": widget.clash.matchIds},
    );

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error!;
        state[StateKeys.loading] = false;
      });
      return;
    }

    setState(() {
      matches = result.getValue().rows;
      state[StateKeys.loading] = false;
      if (!hasBeenOpen) {
        hasBeenOpen = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserState>();

    List<Widget> renderMatches() {
      if (state[StateKeys.loading]) {
        return [
          Container(
            padding: EdgeInsets.all(16),
            child: LoadingRing(),
          ),
        ];
      }
      if ((state[StateKeys.error] as String).length > 0) {
        return [
          SizedBox(
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      color: Theme.of(context).colorScheme.error),
                  Text(
                    state[StateKeys.error] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  )
                ],
              ),
            ),
          )
        ];
      }
      return matches.isEmpty
          ? [
              ClashWithoutTournamentMatches(
                canTrack: userProvider.user!.canTrack,
                clash: widget.clash,
              )
            ]
          : matches.map(
              (m) {
                return MatchRow(
                  match: m,
                );
              },
            ).toList();
    }

    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
      ),
      elevation: 0,
      child: ExpansionTile(
        onExpansionChanged: (bool value) {
          _findMatches();
        },
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          width: double.maxFinite,
          child: Center(
            child: Text(
              "${widget.clash.team1.name} vs ${widget.clash.team2.name}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MyTheme.largeTextSize,
              ),
            ),
          ),
        ),
        children: renderMatches(),
      ),
    );
  }
}
