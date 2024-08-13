import 'package:flutter/material.dart';
import 'package:tennis_app/components/full_stats_tracker/full_stats_tracker.dart';
import 'package:tennis_app/components/full_stats_tracker/helpText.dart';
import 'package:tennis_app/domain/league/statistics.dart';
import 'package:tennis_app/styles.dart';

class HowLost extends StatefulWidget {
  final bool winner;
  final Function(Steps value) setStep;
  final Function(int place2, bool error) placePoint;

  const HowLost({
    super.key,
    required this.setStep,
    required this.winner,
    required this.placePoint,
  });

  @override
  State<HowLost> createState() => _HowLostState();
}

class _HowLostState extends State<HowLost> {
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 8)),
            if (!this.widget.winner)
              HelpText(
                text: "Tipo de error",
              ),
            if (!this.widget.winner)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
                        height: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            backgroundColor: error
                                ? MyTheme.selectedButtonColor
                                : Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                MyTheme.regularBorderRadius,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              error = true;
                            });
                          },
                          child: Text(
                            "No Forzado",
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
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            backgroundColor: !error
                                ? MyTheme.selectedButtonColor
                                : Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                MyTheme.regularBorderRadius,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              error = false;
                            });
                          },
                          child: Text(
                            "Forzado",
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
            const Padding(padding: EdgeInsets.only(top: 8)),
            const HelpText(text: "¿Cómo perdió?"),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      height: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.regularBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          widget.placePoint(PlacePoint.mesh, error);
                          widget.setStep(Steps.initial);
                        },
                        child: Text(
                          "Malla",
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
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.regularBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          widget.placePoint(PlacePoint.bckg, error);
                          widget.setStep(Steps.initial);
                        },
                        child: Text(
                          "Fondo / Approach",
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
