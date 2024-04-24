import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/game_rules.dart';
import '../../styles.dart';

class ChooseSuperTieBreak extends StatefulWidget {
  const ChooseSuperTieBreak({super.key});

  @override
  State<ChooseSuperTieBreak> createState() => _ChooseSuperTieBreak();
}

class _ChooseSuperTieBreak extends State<ChooseSuperTieBreak> {
  bool superTiebreak = false;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    void setSuperTiebreak() {
      gameProvider.setSuperTieBreak(superTiebreak);
    }

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        height: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: superTiebreak
                                ? Colors.blue[900]
                                : Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                MyTheme.buttonBorderRadius,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              superTiebreak = true;
                            });
                          },
                          child: Text(
                            "Super Tie-break",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        height: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !superTiebreak
                                ? Colors.blue[900]
                                : Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                MyTheme.buttonBorderRadius,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              superTiebreak = false;
                            });
                          },
                          child: Text(
                            "Set Regular",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () => setSuperTiebreak(),
              child: Text(
                "Continuar",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
