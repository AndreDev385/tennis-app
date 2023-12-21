import 'package:flutter/material.dart';
import 'package:tennis_app/components/game_buttons/advanced/advanced_buttons.dart';

class WinLosePoint extends StatelessWidget {
  const WinLosePoint(
      {super.key, required this.setStep, required this.setWinPoint});

  final void Function(Steps value) setStep;
  final void Function(bool win) setWinPoint;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    setStep(Steps.place);
                    setWinPoint(true);
                  },
                  child: const Text(
                    "Ganó",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
            ),
            Expanded(
              child: Container(
                height: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    setStep(Steps.place);
                    setWinPoint(false);
                  },
                  child: const Text(
                    "Perdió",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
