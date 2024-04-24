import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/tournaments/match_card/score_row.dart';
import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/screens/tournaments/match_detail.dart';
import 'package:tennis_app/screens/tournaments/track_tournament_match.dart';

import '../../../styles.dart';

class TournamentMatchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<TournamentMatchProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: BoxConstraints(maxHeight: 200),
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sede del partido",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      "Estado del partido",
                      style: TextStyle(color: MyTheme.green, fontSize: 12),
                    ),
                  ],
                ),
              ),
              TournamentMatchCardScoreRow(hasWon: true, name: "Andre I."),
              TournamentMatchCardScoreRow(
                hasWon: false,
                name: "Jose I.",
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TournamentMatchDetail(
                        matchId: "5",
                      ),
                    ));
                    return;

                    // TODO: remove new game invocation from this function
                    gameProvider.createNewMatch(
                      mode: GameMode.double,
                      surface: Surfaces.hard,
                      gamesPerSet: 6,
                      setsQuantity: 3,
                      setType: 3,
                      direction: "", //TODO: fix direction
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TournamentMatchTracker(),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.insert_chart_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "Ver más",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
