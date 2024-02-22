import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/styles.dart';

class SelectTeamButtons extends StatefulWidget {
  const SelectTeamButtons({super.key, required this.setInitialTeam});

  final void Function(int team) setInitialTeam;

  @override
  State<SelectTeamButtons> createState() => _SelectTeamButtonsState();
}

class _SelectTeamButtonsState extends State<SelectTeamButtons> {
  int selectedTeam = Team.we;

  void setTeam(int team) {
    setState(() {
      selectedTeam = team;
    });
  }

  void nextStep() {
    widget.setInitialTeam(selectedTeam);
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                          backgroundColor: selectedTeam == Team.we
                              ? Colors.blue[900]
                              : Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        setTeam(Team.we);
                      },
                      child: Text(
                        "${gameProvider.match?.player1} / ${gameProvider.match?.player3}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    height: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            MyTheme.buttonBorderRadius,
                          ),
                        ),
                        backgroundColor: selectedTeam == Team.their
                            ? Colors.blue[900]
                            : Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setTeam(Team.their);
                      },
                      child: Text(
                        "${gameProvider.match?.player2} / ${gameProvider.match?.player4}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => nextStep(),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text(
            "Continuar",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        )
      ],
    );
  }
}
