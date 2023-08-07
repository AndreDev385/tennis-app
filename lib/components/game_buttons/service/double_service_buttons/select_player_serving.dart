import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';

class SelectPlayerServingButtons extends StatefulWidget {
  const SelectPlayerServingButtons({
    super.key,
    required this.setPlayerServing,
    required this.initialTeam,
  });

  final void Function(int team) setPlayerServing;
  final int initialTeam;

  @override
  State<SelectPlayerServingButtons> createState() =>
      _SelectPlayerServingButtonsState();
}

class _SelectPlayerServingButtonsState
    extends State<SelectPlayerServingButtons> {
  int? selectedPlayer;

  void setPlayer(int player) {
    print("$player");
    setState(() {
      selectedPlayer = player;
    });
  }

  void nextStep() {
    if (selectedPlayer == null) {
      return;
    }
    widget.setPlayerServing(selectedPlayer!);
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
                          backgroundColor: selectedPlayer == PlayersIdx.me ||
                                  selectedPlayer == PlayersIdx.rival
                              ? Colors.blue[900]
                              : Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        setPlayer(widget.initialTeam == 0
                            ? PlayersIdx.me
                            : PlayersIdx.rival);
                      },
                      child: Text(
                        "${widget.initialTeam == 0 ? gameProvider.match?.player1 : gameProvider.match?.player2}",
                        style: const TextStyle(
                          fontSize: 24,
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
                          backgroundColor:
                              selectedPlayer == PlayersIdx.partner ||
                                      selectedPlayer == PlayersIdx.rival2
                                  ? Colors.blue[900]
                                  : Theme.of(context).colorScheme.primary),
                      onPressed: () {
                        setPlayer(widget.initialTeam == 0
                            ? PlayersIdx.partner
                            : PlayersIdx.rival2);
                      },
                      child: Text(
                        "${widget.initialTeam == 0 ? gameProvider.match?.player3 : gameProvider.match?.player4}",
                        style: const TextStyle(fontSize: 24),
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
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          child: const Text("Continuar"),
        )
      ],
    );
  }
}
