import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';

import '../../../providers/game_rules.dart';

class SetSingleService extends StatefulWidget {
  final bool isTournamentProvider;

  const SetSingleService({
    super.key,
    required this.isTournamentProvider,
  });

  @override
  State<SetSingleService> createState() => _SetSingleServiceState();
}

class _SetSingleServiceState extends State<SetSingleService> {
  bool me = true;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);
    final tournamentProvider = Provider.of<TournamentMatchProvider>(context);

    String p1Name = widget.isTournamentProvider
        ? tournamentProvider.match!.participant1.firstName
        : gameProvider.match!.player1;

    String p2Name = widget.isTournamentProvider
        ? tournamentProvider.match!.participant2.firstName
        : gameProvider.match!.player1;

    setServe() {
      if (widget.isTournamentProvider) {
        tournamentProvider.setSingleService(me ? 0 : 1);
        return;
      }
      gameProvider.setSingleService(me ? 0 : 1);
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: me
                                ? Colors.blue[900]
                                : Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            setState(() {
                              me = true;
                            });
                          },
                          child: Text(
                            "${p1Name}",
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: !me
                                ? Colors.blue[900]
                                : Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {
                            setState(() {
                              me = false;
                            });
                          },
                          child: Text(
                            "${p2Name}",
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => setServe(),
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
