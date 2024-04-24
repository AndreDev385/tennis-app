import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/tournaments/inscribed.dart';
import 'package:tennis_app/utils/format_player_name.dart';

class ParticipantCard extends StatelessWidget {
  final InscribedParticipant inscribed;

  const ParticipantCard({
    super.key,
    required this.inscribed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.maxFinite,
        height: 80,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${formatName(inscribed.participant.firstName, inscribed.participant.lastName)}",
                    ),
                    if (inscribed.position != null)
                      Text(
                        "Nro. ${inscribed.position}",
                        style: TextStyle(fontSize: 11),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
