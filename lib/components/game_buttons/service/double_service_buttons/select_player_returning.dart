import 'package:flutter/material.dart';

import '../../../../domain/shared/serve_flow.dart';
import '../../../../utils/format_player_name.dart';

class SelectPlayerReturningButtons extends StatefulWidget {
  final void Function(int team) setPlayerReturning;
  final String p1Name;
  final String p2Name;
  final String p3Name;
  final String p4Name;

  final int initialTeam;
  const SelectPlayerReturningButtons({
    super.key,
    required this.setPlayerReturning,
    required this.initialTeam,
    required this.p1Name,
    required this.p2Name,
    required this.p3Name,
    required this.p4Name,
  });

  @override
  State<SelectPlayerReturningButtons> createState() =>
      _SelectPlayerReturningButtonsState();
}

class _SelectPlayerReturningButtonsState
    extends State<SelectPlayerReturningButtons> {
  int? selectedPlayer;

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
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        backgroundColor: selectedPlayer == PlayersIdx.me ||
                                selectedPlayer == PlayersIdx.rival
                            ? Colors.blue[900]
                            : Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setPlayer(
                          widget.initialTeam != 0
                              ? PlayersIdx.me
                              : PlayersIdx.rival,
                        );
                      },
                      child: Text(
                        "${widget.initialTeam == 0 ? formatPlayerName(widget.p2Name) : formatPlayerName(widget.p1Name)}",
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
                    padding: const EdgeInsets.only(left: 8.0),
                    height: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        backgroundColor: selectedPlayer == PlayersIdx.partner ||
                                selectedPlayer == PlayersIdx.rival2
                            ? Colors.blue[900]
                            : Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setPlayer(
                          widget.initialTeam != 0
                              ? PlayersIdx.partner
                              : PlayersIdx.rival2,
                        );
                      },
                      child: Text(
                        "${widget.initialTeam == 0 ? formatPlayerName(widget.p4Name) : formatPlayerName(widget.p3Name)}",
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
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
    if (selectedPlayer == null) {
      return;
    }
    widget.setPlayerReturning(selectedPlayer!);
  }

  void setPlayer(int player) {
    setState(() {
      selectedPlayer = player;
    });
  }
}
