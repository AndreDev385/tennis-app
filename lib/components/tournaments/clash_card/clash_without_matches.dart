import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/dtos/tournaments/contest_clash.dart';
import 'package:tennis_app/providers/curr_tournament_provider.dart';
import 'package:tennis_app/screens/tournaments/create_clash_matches.dart';

import '../../shared/button.dart';

class ClashWithoutTournamentMatches extends StatelessWidget {
  final bool canTrack;
  final ContestClash clash;

  const ClashWithoutTournamentMatches({
    super.key,
    required this.canTrack,
    required this.clash,
  });

  @override
  Widget build(BuildContext context) {
    final tournamentProvider = context.watch<CurrentTournamentProvider>();

    return SizedBox(
      height: 80,
      child: Center(
        child: canTrack
            ? Container(
                margin: const EdgeInsets.all(16),
                child: MyButton(
                  text: "Crear partidos",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateClashMatches(
                          clash: clash,
                          matchesPerClash: tournamentProvider
                              .tournament!.rules.matchesPerClash!,
                          tournamentProvider: tournamentProvider,
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Text(
                "Se están configurando los partidos",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }
}
