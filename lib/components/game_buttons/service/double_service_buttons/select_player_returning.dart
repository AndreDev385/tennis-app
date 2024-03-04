import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/utils/format_player_name.dart';

class SelectPlayerReturningButtons extends StatefulWidget {
  const SelectPlayerReturningButtons(
      {super.key, required this.setPlayerReturning, required this.initialTeam});

  final void Function(int team) setPlayerReturning;
  final int initialTeam;

  @override
  State<SelectPlayerReturningButtons> createState() =>
      _SelectPlayerReturningButtonsState();
}

class _SelectPlayerReturningButtonsState
    extends State<SelectPlayerReturningButtons> {
  int? selectedPlayer;

  void setPlayer(int player) {
    setState(() {
      selectedPlayer = player;
    });
  }

  void nextStep() {
    if (selectedPlayer == null) {
      return;
    }
    widget.setPlayerReturning(selectedPlayer!);
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
                        "${widget.initialTeam == 0 ? formatPlayerName(gameProvider.match?.player2) : formatPlayerName(gameProvider.match?.player1)}",
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
                        "${widget.initialTeam == 0 ? formatPlayerName(gameProvider.match?.player4) : formatPlayerName(gameProvider.match?.player3)}",
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
}
