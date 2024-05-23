import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/shared/serve_flow.dart';
import '../../../domain/shared/utils.dart';
import '../../../providers/game_rules.dart';
import '../../../styles.dart';
import '../../../utils/format_player_name.dart';
import 'advanced_buttons.dart';

class AdvancedInitialButtons extends StatefulWidget {
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

  @override
  State<AdvancedInitialButtons> createState() => _IntermediateInitialButtons();
}

class _IntermediateInitialButtons extends State<AdvancedInitialButtons> {
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
                      margin: const EdgeInsets.only(right: 4),
                      height: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.regularBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: widget.rally > 0 ? null : () => widget.ace(),
                        child: Text(
                          "Ace",
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
                      margin: const EdgeInsets.only(left: 4),
                      height: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.regularBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: widget.rally > 0
                            ? null
                            : () => widget.secondServiceAndDobleFault(),
                        child: Text(
                          widget.serviceNumber == 1
                              ? "2do Servicio"
                              : "Doble falta",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
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
                      margin: const EdgeInsets.only(right: 4, top: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.regularBorderRadius,
                            ),
                          ),
                        ),
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
                              : "${formatPlayerName(gameProvider.match?.player1)}",
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
                      margin: const EdgeInsets.only(left: 4, top: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.regularBorderRadius,
                            ),
                          ),
                        ),
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
                              : "${formatPlayerName(gameProvider.match?.player3)}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            if (widget.renderRally)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                MyTheme.regularBorderRadius,
                              ),
                            ),
                          ),
                          onPressed: widget.rally == 0
                              ? null
                              : () => widget.decrementRally(),
                          child: Text(
                            "Rally -\n${widget.rally}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 4, right: 4),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                MyTheme.regularBorderRadius,
                              ),
                            ),
                          ),
                          onPressed: () => widget.incrementRally(),
                          child: Text(
                            "Rally +\n${widget.rally}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
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

  void selectP1() {
    widget.setStep(Steps.winOrLose);
    widget.selectPlayer(PlayersIdx.me);
  }

  void selectP3() {
    widget.setStep(Steps.winOrLose);
    widget.selectPlayer(PlayersIdx.partner);
  }
}
