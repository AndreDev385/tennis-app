import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/intermediate/intermediate_buttons.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';

class IntermediateInitialButtons extends StatefulWidget {
  const IntermediateInitialButtons({
    super.key,
    required this.setStep,
    required this.selectPlayer,
    required this.setWinPoint,
    required this.serviceNumber,
    required this.firstService,
    required this.secondService,
  });

  final int serviceNumber;
  final Function() firstService;
  final Function() secondService;
  final void Function(Steps value) setStep;
  final void Function(int player) selectPlayer;
  final void Function(bool win) setWinPoint;

  @override
  State<IntermediateInitialButtons> createState() =>
      _IntermediateInitialButtons();
}

class _IntermediateInitialButtons extends State<IntermediateInitialButtons> {
  void selectP1() {
    widget.setStep(Steps.winOrLose);
    widget.selectPlayer(PlayersIdx.me);
  }

  void selectP3() {
    widget.setStep(Steps.winOrLose);
    widget.selectPlayer(PlayersIdx.partner);
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          gameProvider.ace(widget.serviceNumber == 1);
                          widget.firstService();
                        },
                        child: const Text(
                          "Ace",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, bottom: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.serviceNumber == 2) {
                            gameProvider.doubleFault();
                            widget.firstService();
                          } else {
                            widget.secondService();
                          }
                        },
                        child: Text(
                          widget.serviceNumber == 1
                              ? "2do Servicio"
                              : "Doble falta",
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                      margin: const EdgeInsets.only(right: 8, top: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (gameProvider.match?.mode == GameMode.single) {
                            widget.setStep(Steps.place);
                            widget.setWinPoint(true);
                          } else {
                            selectP1();
                          }
                        },
                        child: Text(
                          gameProvider.match?.mode == GameMode.single
                              ? "Gano"
                              : "${gameProvider.match?.player1}",
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
                      margin: const EdgeInsets.only(left: 8, top: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (gameProvider.match?.mode == GameMode.single) {
                            widget.setStep(Steps.place);
                            widget.setWinPoint(false);
                          } else {
                            selectP3();
                          }
                        },
                        child: Text(
                          gameProvider.match?.mode == GameMode.single
                              ? "Perdió"
                              : "${gameProvider.match?.player3}",
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
