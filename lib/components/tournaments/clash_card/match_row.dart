import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/tournament/tournament_match.dart';
import '../../../dtos/match_dtos.dart';
import '../../../providers/tournament_match_provider.dart';
import '../../../providers/user_state.dart';
import '../../../screens/tournaments/track_tournament_match.dart';
import '../../../services/tournaments/match/get_match.dart';
import '../../../services/tournaments/match/update_match.dart';
import '../match_card/score_row.dart';
import '../match_utils.dart';

class MatchRow extends StatelessWidget {
  final TournamentMatch match;

  const MatchRow({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    final tProvider = Provider.of<TournamentMatchProvider>(context);

    goLive() async {
      Navigator.pop(context);
      final updateResult = await updateMatch(match, MatchStatuses.Live);

      if (updateResult.isFailure) {
        return;
      }

      final getResult = await getMatch({'matchId': match.matchId});

      if (getResult.isFailure) {
        return;
      }

      final matchD = getResult.getValue();

      print("TRACKER ${matchD.tracker}");

      tProvider.startTrackingMatch(matchD, true);

      //Navigate
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TournamentMatchTracker()),
      );
    }

    modalBuilder() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Empezar a trasmitir partido"),
              content:
                  const Text("Quieres dar inicio al partido seleccionado?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => goLive(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Aceptar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    final SHOW_SETS = match.status != MatchStatuses.Waiting.index &&
        match.status != MatchStatuses.Live.index;

    return InkWell(
      onTap: () => matchActions(
        context: context,
        matchId: match.matchId,
        matchStatus: match.status,
        askToTrackMatch: modalBuilder,
        userCanTrack: userState.user!.canTrack,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        width: double.maxFinite,
        child: Column(
          children: [
            matchStatusLine(context, match.status),
            TournamentMatchCardScoreRow(
              hasWon: match.matchWon != null ? match.matchWon! : false,
              name: buildRowName(match.participant1, match.participant3),
              sets: match.sets,
              showRival: false,
              showSets: SHOW_SETS,
            ),
            TournamentMatchCardScoreRow(
              hasWon: match.matchWon != null ? !match.matchWon! : false,
              name: buildRowName(match.participant2, match.participant4),
              sets: match.sets,
              showRival: true,
              showSets: SHOW_SETS,
            ),
          ],
        ),
      ),
    );
  }
}
