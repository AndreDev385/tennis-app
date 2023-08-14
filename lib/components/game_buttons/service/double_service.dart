import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/service/double_service_buttons/select_player_returning.dart';
import 'package:tennis_app/components/game_buttons/service/double_service_buttons/select_player_serving.dart';
import 'package:tennis_app/components/game_buttons/service/double_service_buttons/select_team_buttons.dart';
import 'package:tennis_app/domain/game_rules.dart';

class SetDoubleService extends StatefulWidget {
  SetDoubleService({
    super.key,
    required this.initialStep,
  });

  int initialStep;

  @override
  State<SetDoubleService> createState() => _SetDoubleServiceState();
}

class _SetDoubleServiceState extends State<SetDoubleService> {
  int step = 0;
  int? initialTeam;

  int? playerServing;
  int? playerReturning;

  @override
  void initState() {
    super.initState();
    step = widget.initialStep;
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    if (gameProvider.match?.doubleServeFlow?.setNextFlow == true) {
      initialTeam = gameProvider.match?.doubleServeFlow?.initialTeam;
    }

    String title() {
      if (step == 0) {
        return "Equipo que saca";
      }
      if (step == 1) {
        return "Jugador que saca";
      }
      if (step == 2) {
        return "Jugador que devuelve";
      }
      return "";
    }

    int initialTeamSelected() {
      // first flow selection
      if (widget.initialStep == 0) {
        return initialTeam!;
      }
      // second set flow selection
      if (widget.initialStep == 1) {
        if (gameProvider.match?.doubleServeFlow?.setNextFlow == true) {
          return gameProvider.match!.doubleServeFlow!.initialTeam;
        }
      }
      // first flow second step selection
      return gameProvider.match!.doubleServeFlow!.initialTeam == 0 ? 1 : 0;
    }

    void setInitialTeam(int team) {
      setState(() {
        initialTeam = team;
        step++;
      });
    }

    void setPlayerServing(int player) {
      setState(() {
        playerServing = player;
        step++;
      });
    }

    void setPlayerReturning(int player) {
      setState(() {
        playerReturning = player;
      });
      gameProvider.setDoubleService(
        initialTeamSelected(),
        playerServing!,
        playerReturning!,
      );
    }

    showButtons() {
      if (step == 0) {
        return SelectTeamButtons(setInitialTeam: setInitialTeam);
      }
      if (step == 1) {
        return SelectPlayerServingButtons(
          setPlayerServing: setPlayerServing,
          initialTeam: initialTeamSelected(),
        );
      }
      if (step == 2) {
        return SelectPlayerReturningButtons(
          setPlayerReturning: setPlayerReturning,
          initialTeam: initialTeamSelected(),
        );
      }
      return SelectTeamButtons(setInitialTeam: setInitialTeam);
    }

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Title(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: Text(
                      title(),
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: showButtons(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
