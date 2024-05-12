import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/providers/curr_tournament_provider.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/screens/tournaments/tournament_page.dart';
import 'package:tennis_app/services/tournaments/match/update_match.dart';

class FinishMatch extends StatelessWidget {
  final Function finishTrasmition;

  const FinishMatch({required this.finishTrasmition});

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<TournamentMatchProvider>(context);
    final currentTournamentProvider =
        Provider.of<CurrentTournamentProvider>(context);

    finish() async {
      EasyLoading.show();

      final result = await updateMatch(
        matchProvider.match!,
        MatchStatuses.Finished,
      );

      if (result.isFailure) {
        EasyLoading.dismiss();
        showMessage(context, result.error!, ToastType.error);
        return;
      }

      matchProvider.finishMatch();

      EasyLoading.dismiss();
      showMessage(context, result.getValue(), ToastType.success);

      navigationKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => TournamentPage(
            tournamentProvider: currentTournamentProvider,
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => finish(),
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
