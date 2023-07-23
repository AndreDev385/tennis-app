import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/game_end.dart';
import 'package:tennis_app/components/game_buttons/service/double_service.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/components/game_buttons/super_tiebreak.dart';
import '../../domain/match.dart';

import 'service/single_service.dart';

class BasicButtons extends StatelessWidget {
  const BasicButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);
    Match? match = gameProvider.match;

    bool setSingleService =
        match?.singleServeFlow == null && match?.mode == GameMode.single;

    bool doubleServicecFirstStep =
        match?.doubleServeFlow == null && match?.mode == GameMode.double;

    bool doubleServiceSecondStep =
        match?.doubleServeFlow?.isFlowComplete == false &&
            match?.doubleServeFlow?.actualSetOrder == 1;

    bool doubleNextSetFlow = match?.doubleServeFlow?.setNextFlow == true;

    if ((match!.currentSetIdx + 1) == match.setsQuantity &&
        match.superTiebreak == null) {
      return const ChooseSuperTieBreak();
    }

    if (match.matchFinish == true) {
      return const GameEnd();
    }

    if (setSingleService) {
      return const SetSingleService();
    }

    if (doubleServicecFirstStep) {
      return SetDoubleService(
        initialStep: 0,
      );
    }

    if (doubleServiceSecondStep || doubleNextSetFlow) {
      return SetDoubleService(
        initialStep: 1,
      );
    }

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    gameProvider.score();
                  },
                  child: const Text(
                    "Gano",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                height: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600]),
                  onPressed: () {
                    gameProvider.rivalScore();
                  },
                  child: const Text(
                    "Perdió",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
