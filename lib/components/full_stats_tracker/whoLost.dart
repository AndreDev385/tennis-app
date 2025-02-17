import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/shared/serve_flow.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/utils/format_player_name.dart';

import '../../domain/tournament/tournament_match.dart';
import '../../styles.dart';
import 'full_stats_tracker.dart';
import 'helpText.dart';

class WhoLost extends StatelessWidget {
  final Function(Steps value) setStep;
  final Function(int player) setPlayerWhoLost;
  final int playerWhoWon;

  const WhoLost({
    super.key,
    required this.playerWhoWon,
    required this.setStep,
    required this.setPlayerWhoLost,
  });

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<TournamentMatchProvider>(context);

    TournamentMatch match = gameProvider.match!;

    bool team1WinPoint =
        playerWhoWon == PlayersIdx.me || playerWhoWon == PlayersIdx.partner;

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 8)),
            HelpText(
              text: "¿Quien perdio el punto?",
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
                          setPlayerWhoLost(
                            team1WinPoint ? PlayersIdx.rival : PlayersIdx.me,
                          );
                          this.setStep(Steps.howLost);
                        }, //widget.rally > 0 ? null : () => widget.ace(),
                        child: Text(
                          team1WinPoint
                              ? shortNameFormat(
                                  match.participant2.firstName,
                                  match.participant2.lastName,
                                )
                              : shortNameFormat(
                                  match.participant1.firstName,
                                  match.participant1.lastName,
                                ),
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
                          setPlayerWhoLost(
                            team1WinPoint
                                ? PlayersIdx.rival2
                                : PlayersIdx.partner,
                          );
                          this.setStep(Steps.howLost);
                        },
                        child: Text(
                          team1WinPoint
                              ? shortNameFormat(
                                  match.participant4!.firstName,
                                  match.participant4!.lastName,
                                )
                              : shortNameFormat(
                                  match.participant3!.firstName,
                                  match.participant3!.lastName,
                                ),
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
