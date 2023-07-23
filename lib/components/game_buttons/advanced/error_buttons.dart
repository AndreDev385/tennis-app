import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/intermediate/intermediate_buttons.dart';
import 'package:tennis_app/domain/game_rules.dart';

class AdvancedErrorButtons extends StatelessWidget {
  const AdvancedErrorButtons({
    super.key,
    required this.setStep,
    required this.placePoint,
    this.selectedPlayer = 0,
  });

  final Function({bool forcedError}) placePoint;
  final void Function(Steps value) setStep;
  final int? selectedPlayer;

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
                          placePoint(forcedError: true);
                          setStep(Steps.initial);
                        },
                        child: const Text(
                          "Error forzado",
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
                          placePoint(forcedError: false);
                          setStep(Steps.initial);
                        },
                        child: const Text(
                          "Error no forzado",
                          style: TextStyle(
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
