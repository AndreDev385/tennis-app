import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/shared/serve_flow.dart';

import '../../domain/tournament/tournament_match.dart';
import '../../providers/tournament_match_provider.dart';
import '../../styles.dart';
import '../../domain/shared/utils.dart';
import 'full_stats_tracker.dart';
import 'helpText.dart';

class InitialButtons extends StatelessWidget {
  final Function(bool value) setReturnWon;
  final Function() secondService;
  final Function() doubleFault;
  final Function(Steps value) setStep;
  final Function(int value) setRally;
  final Function() ace;
  final Function(int player) setPlayerWhoWon;
  final Function() servicePoint;
  final int serviceNumber;
  final int rally;

  const InitialButtons({
    super.key,
    required this.ace,
    required this.servicePoint,
    required this.rally,
    required this.setRally,
    required this.serviceNumber,
    required this.setStep,
    required this.setReturnWon,
    required this.secondService,
    required this.doubleFault,
    required this.setPlayerWhoWon,
  });

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<TournamentMatchProvider>(context);

    TournamentMatch match = gameProvider.match!;

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
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
                        onPressed:
                            this.rally >= Rally.serve ? null : () => this.ace(),
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
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: this.rally >= Rally.serve
                            ? null
                            : () {
                                if (serviceNumber == 1) {
                                  secondService();
                                  return;
                                }
                                doubleFault();
                              },
                        child: Text(
                          serviceNumber == 1 ? "2do servicio" : "Doble falta",
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
                        onPressed: this.rally >= Rally.ret
                            ? null
                            : () => servicePoint(),
                        child: Text(
                          "Saque no devuelto",
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
                        onPressed: this.rally >= Rally.ret
                            ? null
                            : () {
                                this.setReturnWon(true);
                                this.setStep(Steps.wonWithReturn);
                              },
                        child: Text(
                          "Devolución ganadora",
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
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: this.rally == 0
                            ? null
                            : () => this.setRally(this.rally - 1),
                        child: Text(
                          "Rally -\n${this.rally}",
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
                              MyTheme.buttonBorderRadius,
                            ),
                          ),
                        ),
                        onPressed: () {
                          this.setRally(this.rally + 1);
                        },
                        child: Text(
                          "Rally +\n${this.rally}", //${widget.rally}",
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
            const HelpText(text: "¿Quien ganó?"),
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
                          setPlayerWhoWon(PlayersIdx.me);
                          setStep(Steps.howWon);
                          //if (gameProvider.match?.mode == GameMode.single) {
                          //  widget.setStep(Steps.place);
                          //  widget.setWinPoint(true);
                          //} else {
                          //  selectP1();
                          //}
                        },
                        child: Text(
                          match.participant1.firstName
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
                          setPlayerWhoWon(PlayersIdx.rival);
                          setStep(Steps.howWon);
                        },
                        child: Text(
                          match.participant2.firstName,
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
            if (match.mode == GameMode.double)
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
                            setPlayerWhoWon(PlayersIdx.partner);
                            setStep(Steps.howWon);
                            //if (gameProvider.match?.mode == GameMode.single) {
                            //  widget.setStep(Steps.place);
                            //  widget.setWinPoint(true);
                            //} else {
                            //  selectP1();
                            //}
                          },
                          child: Text(
                            match.participant3!.firstName
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
                            setPlayerWhoWon(PlayersIdx.rival);
                            setStep(Steps.howWon);
                            //if (gameProvider.match?.mode == GameMode.single) {
                            //  widget.setStep(Steps.place);
                            //  widget.setWinPoint(false);
                            //} else {
                            //  selectP3();
                            //}
                          },
                          child: Text(
                            match.participant4!.firstName,
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
