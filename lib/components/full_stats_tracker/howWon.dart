import 'package:flutter/material.dart';
import 'package:tennis_app/components/full_stats_tracker/full_stats_tracker.dart';
import 'package:tennis_app/components/full_stats_tracker/helpText.dart';
import 'package:tennis_app/domain/league/statistics.dart';
import 'package:tennis_app/styles.dart';

class HowWon extends StatelessWidget {
  final bool winner;

  final Function(bool value) setWinner;
  final Function(Steps value) setStep;
  final Function(int place) setPlace1;

  const HowWon({
    super.key,
    required this.setStep,
    required this.winner,
    required this.setWinner,
    required this.setPlace1,
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
                          backgroundColor: winner
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setWinner(true);
                        }, //widget.rally > 0 ? null : () => widget.ace(),
                        child: Text(
                          "Si",
                          style: TextStyle(
                            fontSize: 18,
                            color: winner
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
                          backgroundColor: !winner
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setWinner(false);
                        },
                        /*widget.rally > 0
                            ? null
                            : () => widget.secondServiceAndDobleFault(),*/
                        child: Text(
                          "No" /*
                          widget.serviceNumber == 1
                              ? "2do Servicio"
                              : "Doble falta"*/
                          ,
                          style: TextStyle(
                            fontSize: 18,
                            color: !winner
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
                          setPlace1(PlacePoint.mesh);
                          setStep(Steps.whoLost);
                          //if (gameProvider.match?.mode == GameMode.single) {
                          //  widget.setStep(Steps.place);
                          //  widget.setWinPoint(true);
                          //} else {
                          //  selectP1();
                          //}
                        },
                        child: Text(
                          "Malla"
                          /*gameProvider.match?.mode == GameMode.single
                              ? "Ganó"
                              : "${formatPlayerName(gameProvider.match?.player1)}"*/
                          ,
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
                          setPlace1(PlacePoint.bckg);
                          setStep(Steps.whoLost);
                          //if (gameProvider.match?.mode == GameMode.single) {
                          //  widget.setStep(Steps.place);
                          //  widget.setWinPoint(false);
                          //} else {
                          //  selectP3();
                          //}
                        },
                        child: Text(
                          "Fondo / Approach",
                          //gameProvider.match?.mode == GameMode.single
                          //    ? "Perdió"
                          //    : "${formatPlayerName(gameProvider.match?.player3)}",
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
