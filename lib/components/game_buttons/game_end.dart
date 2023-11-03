import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/screens/app/results/results.dart';
import 'package:tennis_app/services/finish_match.dart';

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
          Navigator.of(context).pushNamed(CtaHomePage.route);
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
        gameProvider.finishMatch();
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
            ),
            child: const Text("Partido terminado"),
          )
        ],
      ),
    );
  }
}
