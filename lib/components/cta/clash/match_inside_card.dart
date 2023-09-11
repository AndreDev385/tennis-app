import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/cta/clash/match_card_score.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/components/cta/match/match_result.dart';
import 'package:tennis_app/components/cta/live/watch_live.dart';
import 'package:tennis_app/screens/app/cta/track_match.dart';
import 'package:tennis_app/services/go_live.dart';

class MatchInsideClashCard extends StatelessWidget {
  const MatchInsideClashCard({
    super.key,
    required this.match,
    required this.isLast,
    required this.userCanTrack,
  });

  final MatchDto match;
  final bool isLast;
  final bool userCanTrack;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameRules>(context);

    void handleGoLive() {
      EasyLoading.show();
      provider.createClubMatch(
        mode: match.mode,
        setsQuantity: match.setsQuantity,
        surface: match.surface,
        setType: match.gamesPerSet,
        direction: match.address,
        statistics: Statistics.advanced,
        p1: match.player1.firstName,
        p2: match.player2,
        p3: match.player3?.firstName,
        p4: match.player4,
      );
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
        if (match.isFinish) {
          Navigator.of(context).pushNamed(
            MatchResult.route,
            arguments: MatchResultArgs(match.matchId),
          );
          return;
        }
        if (match.isLive) {
          Navigator.of(context).pushNamed(
            WatchLive.route,
            arguments: WatchLiveArgs(match.matchId),
          );
          return;
        }
        if (!match.isLive && !match.isLive && userCanTrack) {
          modalBuilder(context);
        }
      },
      child: Container(
        height: 112,
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
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
        child: MatchCardScore(match: match),
      ),
    );
  }
}
