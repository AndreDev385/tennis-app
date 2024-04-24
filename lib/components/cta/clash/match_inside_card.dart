import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../dtos/match_dtos.dart';
import '../../../providers/game_rules.dart';
import '../../../screens/cta/track_match.dart';
import '../../../services/match/get_paused_match.dart';
import '../../../services/match/go_live.dart';
import '../../shared/toast.dart';
import '../live/watch_live.dart';
import '../match/match_result.dart';
import 'match_card_score.dart';

class MatchInsideClashCard extends StatelessWidget {
  final MatchDto match;

  final bool isLast;
  final bool userCanTrack;
  const MatchInsideClashCard({
    super.key,
    required this.match,
    required this.isLast,
    required this.userCanTrack,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameRules>(context);

    void handleGoLive() {
      EasyLoading.show();
      getPausedMatch(match.matchId).then((value) {
        if (value.isFailure) {
          provider.createClubMatch(matchDto: match);
        } else {
          provider.resumePausedMatch(value.getValue());
        }
      });
      goLive(GoLiveRequest(matchId: match.matchId)).then((value) {
        EasyLoading.dismiss();
        if (value.isFailure) {
          showMessage(
            context,
            value.error ?? "Ha ocurrido un error",
            ToastType.error,
          );
          return;
        }
        showMessage(
          context,
          value.getValue(),
          ToastType.success,
        );
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(
          TrackMatch.route,
          arguments: TrackMatchArgs(matchId: match.matchId),
        );
      }).catchError((e) {
        EasyLoading.dismiss();
        showMessage(
          context,
          "Ha ocurrido un error",
          ToastType.error,
        );
        Navigator.of(context).pop();
      });
    }

    modalBuilder(BuildContext context) {
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
                  onPressed: () => handleGoLive(),
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

    return InkWell(
      onTap: () {
        if (match.status == MatchStatuses.Finished.index ||
            match.status == MatchStatuses.Canceled.index) {
          Navigator.of(context).pushNamed(
            MatchResult.route,
            arguments: MatchResultArgs(match.matchId),
          );
          return;
        }
        if (match.status == MatchStatuses.Paused.index && !userCanTrack) {
          Navigator.of(context).pushNamed(
            MatchResult.route,
            arguments: MatchResultArgs(match.matchId),
          );
          return;
        }
        if (match.status == MatchStatuses.Live.index) {
          Navigator.of(context).pushNamed(
            WatchLive.route,
            arguments: WatchLiveArgs(match.matchId),
          );
          return;
        }
        if ((match.status == MatchStatuses.Waiting.index ||
                match.status == MatchStatuses.Paused.index) &&
            userCanTrack) {
          modalBuilder(context);
        }
      },
      child: Container(
        height: 120,
        decoration: isLast
            ? null
            : const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
        padding: const EdgeInsets.all(16),
        child: MatchCardScore(match: match),
      ),
    );
  }
}
