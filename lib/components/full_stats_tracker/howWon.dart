import 'package:flutter/material.dart';
import 'package:tennis_app/components/full_stats_tracker/full_stats_tracker.dart';
import 'package:tennis_app/components/full_stats_tracker/helpText.dart';
import 'package:tennis_app/domain/league/statistics.dart';
import 'package:tennis_app/styles.dart';

class HowWon extends StatefulWidget {
  final bool isSingle;

  final Function(bool value) setWinner;
  final Function(Steps value) setStep;
  final Function(int place) setPlace1;

  const HowWon({
    super.key,
    required this.setStep,
    required this.setWinner,
    required this.setPlace1,
    required this.isSingle,
  });

  @override
  State<HowWon> createState() => _HowWonState();
}

class _HowWonState extends State<HowWon> {
  bool winner = false;

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
                          backgroundColor: this.winner
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            winner = true;
                          });
                        },
                        child: Text(
                          "Si",
                          style: TextStyle(
                            fontSize: 18,
                            color: this.winner
                                ? Theme.of(context).colorScheme.onPrimary
                                : Colors.black,
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
                          backgroundColor: !this.winner
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            winner = false;
                          });
                        },
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 18,
                            color: !this.winner
                                ? Theme.of(context).colorScheme.onPrimary
                                : Colors.black,
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
            const HelpText(text: "¿Cómo ganó?"),
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
                          widget.setWinner(winner);
                          widget.setPlace1(PlacePoint.mesh);
                          widget.setStep(
                            this.widget.isSingle
                                ? Steps.howLost
                                : Steps.whoLost,
                          );
                        },
                        child: Text(
                          "Malla",
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
                          widget.setWinner(winner);
                          widget.setPlace1(PlacePoint.bckg);
                          widget.setStep(
                            this.widget.isSingle
                                ? Steps.howLost
                                : Steps.whoLost,
                          );
                        },
                        child: Text(
                          "Fondo / Approach",
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
