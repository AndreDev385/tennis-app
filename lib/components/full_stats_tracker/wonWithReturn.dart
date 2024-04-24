import 'package:flutter/material.dart';

import '../../styles.dart';
import 'full_stats_tracker.dart';
import 'helpText.dart';

class WonWithReturn extends StatelessWidget {
  final Function(Steps value) setStep;
  final Function(bool value) setWinner;

  const WonWithReturn({
    super.key,
    required this.setStep,
    required this.setWinner,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 8)),
            HelpText(
              text: "Winner?",
            ),
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
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setWinner(true);
                          setStep(Steps.whoLost);
                        },
                        child: Text(
                          "Si",
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
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setStep(Steps.whoLost);
                        },
                        child: Text(
                          "No",
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
          ],
        ),
      ),
    );
  }
}
