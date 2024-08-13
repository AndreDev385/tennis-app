import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../providers/game_rules.dart';
import '../../providers/tracker_state.dart';
import '../../screens/cta/tracker/tracker_cta.dart';
import '../../screens/results/results.dart';
import '../../services/match/finish_match.dart';
import '../shared/toast.dart';

class GameEnd extends StatelessWidget {
  const GameEnd({
    super.key,
    this.finishMatchData,
    this.finishMatchEvent,
  });

  final Function? finishMatchData;
  final Function? finishMatchEvent;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);
    final trackerState = Provider.of<TrackerState>(context);

    toResultPage() {
      Navigator.of(context).pushNamed(ResultPage.route);
    }

    data() async {
      if (finishMatchData != null) {
        EasyLoading.show();
        final data = finishMatchData!();
        finishMatch(data).then((value) {
          EasyLoading.dismiss();
          if (value.isFailure) {
            showMessage(
              context,
              value.error ?? "Ha ocurrido un error",
              ToastType.error,
            );
            return;
          }
          if (finishMatchEvent != null) finishMatchEvent!();
          showMessage(
            context,
            value.getValue(),
            ToastType.success,
          );
          gameProvider.finishMatch();
          gameProvider.removePendingMatch();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TrackerCTA(
                club: trackerState.currentClub!,
              ),
            ),
          );
          return;
        }).catchError((e) {
          EasyLoading.dismiss();
          showMessage(
            context,
            "Ha ocurrido un error",
            ToastType.error,
          );
          return;
        });
      } else {
        toResultPage();
      }
    }

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              data();
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Theme.of(context).colorScheme.primary),
            child: Text(
              "Partido terminado",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
