import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/advanced/advanced_buttons.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';

class AdvancedInitialButtons extends StatefulWidget {
  const AdvancedInitialButtons({
    super.key,
    required this.setStep,
    required this.selectPlayer,
    required this.setWinPoint,
    required this.serviceNumber,
    required this.firstService,
    required this.secondService,
    required this.incrementRally,
    required this.decrementRally,
    required this.resetRally,
    required this.rally,
    required this.ace,
    required this.secondServiceAndDobleFault,
    required this.renderRally,
  });

  final bool renderRally;

  final Function ace;
  final Function secondServiceAndDobleFault;
  final int rally;
  final int serviceNumber;
  final Function() resetRally;
  final Function() firstService;
  final Function() secondService;
  final void Function(Steps value) setStep;
  final void Function(int player) selectPlayer;
  final void Function(bool win) setWinPoint;
  final void Function() incrementRally;
  final void Function() decrementRally;

  @override
  State<AdvancedInitialButtons> createState() => _IntermediateInitialButtons();
}

class _IntermediateInitialButtons extends State<AdvancedInitialButtons> {
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
                        onPressed: widget.rally > 0 ? null : () => widget.ace(),
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
                        onPressed: widget.rally > 0
                            ? null
                            : () => widget.secondServiceAndDobleFault(),
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
                              ? "Ganó"
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
            const Padding(padding: EdgeInsets.only(top: 16)),
            if (widget.renderRally)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: widget.rally == 0
                              ? null
                              : () => widget.decrementRally(),
                          child: Text(
                            "Rally -\n${widget.rally}",
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => widget.incrementRally(),
                          child: Text(
                            "Rally +\n${widget.rally}",
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
              )
          ],
        ),
      ),
    );
  }
}
