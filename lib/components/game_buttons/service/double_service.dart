import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/utils/format_player_name.dart';

import '../../../providers/game_rules.dart';
import 'double_service_buttons/select_player_returning.dart';
import 'double_service_buttons/select_player_serving.dart';
import 'double_service_buttons/select_team_buttons.dart';

class SetDoubleService extends StatefulWidget {
  final int initialStep;
  final bool isTournamentProvider;

  SetDoubleService({
    super.key,
    required this.initialStep,
    required this.isTournamentProvider,
  });

  @override
  State<SetDoubleService> createState() => _SetDoubleServiceState();
}

class _SetDoubleServiceState extends State<SetDoubleService> {
  int step = 0;
  int? initialTeam;

  int? playerServing;
  int? playerReturning;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);
    final tournamentProvider = Provider.of<TournamentMatchProvider>(context);

    String p1Name = widget.isTournamentProvider
        ? formatName(tournamentProvider.match!.participant1.firstName,
            tournamentProvider.match!.participant1.lastName)
        : gameProvider.match!.player1;

    String p2Name = widget.isTournamentProvider
        ? formatName(tournamentProvider.match!.participant2.firstName,
            tournamentProvider.match!.participant2.lastName)
        : gameProvider.match!.player2;

    String p3Name = widget.isTournamentProvider
        ? formatName(tournamentProvider.match!.participant3!.firstName,
            tournamentProvider.match!.participant3!.lastName)
        : gameProvider.match!.player3;

    String p4Name = widget.isTournamentProvider
        ? formatName(tournamentProvider.match!.participant4!.firstName,
            tournamentProvider.match!.participant4!.lastName)
        : gameProvider.match!.player4;

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
      // first flow second step selection
      if (widget.isTournamentProvider) {
        return tournamentProvider.match!.doubleServeFlow!.initialTeam == 0
            ? 1
            : 0;
      }
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
      if (widget.isTournamentProvider) {
        return tournamentProvider.setDoubleService(
          initialTeamSelected(),
          playerServing!,
          playerReturning!,
        );
      }
      gameProvider.setDoubleService(
        initialTeamSelected(),
        playerServing!,
        playerReturning!,
      );
    }

    showButtons() {
      if (step == 1) {
        return SelectPlayerServingButtons(
          setPlayerServing: setPlayerServing,
          initialTeam: initialTeamSelected(),
          p1Name: p1Name,
          p2Name: p2Name,
          p3Name: p3Name,
          p4Name: p4Name,
        );
      }
      if (step == 2) {
        return SelectPlayerReturningButtons(
          setPlayerReturning: setPlayerReturning,
          initialTeam: initialTeamSelected(),
          p1Name: p1Name,
          p2Name: p2Name,
          p3Name: p3Name,
          p4Name: p4Name,
        );
      }
      return SelectTeamButtons(
        setInitialTeam: setInitialTeam,
        p1Name: p1Name,
        p2Name: p2Name,
        p3Name: p3Name,
        p4Name: p4Name,
      );
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
                          fontSize: 18, fontWeight: FontWeight.bold),
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

  @override
  void initState() {
    super.initState();
    step = widget.initialStep;
  }
}
