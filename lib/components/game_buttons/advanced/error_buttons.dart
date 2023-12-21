import 'package:flutter/material.dart';
import 'package:tennis_app/components/game_buttons/advanced/advanced_buttons.dart';

class ErrorButtons extends StatelessWidget {
  const ErrorButtons({
    super.key,
    required this.setStep,
    required this.placePoint,
    this.selectedPlayer = 0,
  });

  final Function({
    required bool noForcedError,
    required bool winner,
  }) placePoint;

  final void Function(Steps value) setStep;
  final int? selectedPlayer;

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {
                          placePoint(noForcedError: false, winner: false);
                          setStep(Steps.initial);
                        },
                        child: const Text(
                          "Error forzado",
                          style: TextStyle(
                            fontSize: 18,
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
                        onPressed: () {
                          placePoint(noForcedError: true, winner: false);
                          setStep(Steps.initial);
                        },
                        child: const Text(
                          "Error no forzado",
                          style: TextStyle(
                            fontSize: 18,
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
                      margin: const EdgeInsets.only(top: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          placePoint(noForcedError: false, winner: true);
                          setStep(Steps.initial);
                        },
                        child: const Text(
                          "Winner",
                          style: TextStyle(
                            fontSize: 18,
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
