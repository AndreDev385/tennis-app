import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/tournaments/contest_clash.dart';

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
    return SizedBox(
      height: 80,
      child: Center(
        child: canTrack
            ? Container(
                margin: const EdgeInsets.all(16),
                child: MyButton(
                  text: "Crear partidos",
                  onPress: () {
                    //TODO navigate to page where matches are created
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
