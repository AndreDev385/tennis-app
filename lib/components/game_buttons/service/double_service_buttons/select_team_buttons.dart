import 'package:flutter/material.dart';

import '../../../../domain/shared/serve_flow.dart';
import '../../../../styles.dart';
import '../../../../utils/format_player_name.dart';

class SelectTeamButtons extends StatefulWidget {
  final void Function(int team) setInitialTeam;
  final String p1Name;
  final String p2Name;
  final String p3Name;
  final String p4Name;

  const SelectTeamButtons({
    super.key,
    required this.setInitialTeam,
    required this.p1Name,
    required this.p2Name,
    required this.p3Name,
    required this.p4Name,
  });

  @override
  State<SelectTeamButtons> createState() => _SelectTeamButtonsState();
}

class _SelectTeamButtonsState extends State<SelectTeamButtons> {
  int selectedTeam = Team.we;

  @override
  Widget build(BuildContext context) {
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
                        "${formatPlayerName(widget.p1Name)} / ${formatPlayerName(widget.p3Name)}",
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
                        "${formatPlayerName(widget.p2Name)} / ${formatPlayerName(widget.p4Name)}",
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

  void nextStep() {
    widget.setInitialTeam(selectedTeam);
  }

  void setTeam(int team) {
    setState(() {
      selectedTeam = team;
    });
  }
}
