import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/shared/toast.dart';

import 'package:tennis_app/components/tournaments/match_card/score_row.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/providers/user_state.dart';
import 'package:tennis_app/screens/tournaments/track_tournament_match.dart';
import 'package:tennis_app/services/tournaments/match/get_match.dart';
import 'package:tennis_app/services/tournaments/match/update_match.dart';

import '../../../styles.dart';
import '../match_utils.dart';

class TournamentMatchCard extends StatelessWidget {
  final TournamentMatch match;

  const TournamentMatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    final tProvider = Provider.of<TournamentMatchProvider>(context);

    bool CAN_TRACK = userState.user?.canTrack ?? false;

    goLive() async {
      EasyLoading.show();
      final updateResult = await updateMatch(match, MatchStatuses.Live);

      if (updateResult.isFailure) {
        EasyLoading.dismiss();
        // TODO: handle error
        return;
      }

      final getResult = await getMatch({'matchId': match.matchId});

      if (getResult.isFailure) {
        EasyLoading.dismiss();
        // TODO: handle error
        return;
      }

      final matchD = getResult.getValue();

      tProvider.startTrackingMatch(matchD);

      EasyLoading.dismiss();
      showMessage(context, "Partido en vivo", ToastType.success);

      Navigator.pop(context);

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

    String mapStatusToButtonValue() {
      final ASK_TO_TRACK_MATCH =
          MatchStatuses.Waiting.index == match.status && CAN_TRACK;
      final RESUME_MATCH =
          MatchStatuses.Paused.index == match.status && CAN_TRACK;
      final JOIN_LIVE = MatchStatuses.Live.index == match.status;

      if (ASK_TO_TRACK_MATCH) {
        return "Empezar partido";
      }

      if (RESUME_MATCH) {
        return "Reanudar partido";
      }

      if (JOIN_LIVE) {
        return "Unirse";
      }

      return "Ver más";
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
        ),
        child: Container(
          width: double.maxFinite,
          child: Column(
            children: [
              matchStatusLine(context, match.status),
              TournamentMatchCardScoreRow(
                hasWon: match.matchWon != null ? match.matchWon! : false,
                name: buildRowName(match.participant1, match.participant3),
                sets: match.sets,
                showRival: false,
                showSets: match.status != MatchStatuses.Waiting.index &&
                    match.status != MatchStatuses.Live.index,
              ),
              TournamentMatchCardScoreRow(
                hasWon: match.matchWon != null ? !match.matchWon! : false,
                name: buildRowName(match.participant2, match.participant4),
                sets: match.sets,
                showRival: true,
                showSets: match.status != MatchStatuses.Waiting.index &&
                    match.status != MatchStatuses.Live.index,
              ),
              if (CAN_TRACK || match.status != MatchStatuses.Waiting.index)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => matchActions(
                      context: context,
                      matchId: match.matchId,
                      matchStatus: match.status,
                      userCanTrack: userState.user?.canTrack ?? false,
                      askToTrackMatch: modalBuilder,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (match.status != MatchStatuses.Waiting.index)
                          Icon(
                            Icons.insert_chart_outlined,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            mapStatusToButtonValue(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: MyTheme.regularTextSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
