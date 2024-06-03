import 'package:flutter/material.dart';
import 'package:tennis_app/components/tournaments/avatar.dart';
import 'package:tennis_app/dtos/tournaments/inscribed.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/format_player_name.dart';

import '../../domain/tournament/participant.dart';

class ParticipantCard extends StatelessWidget {
  final InscribedParticipant inscribed;

  const ParticipantCard({
    super.key,
    required this.inscribed,
  });

  @override
  Widget build(BuildContext context) {
    Participant p = inscribed.participant;

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.maxFinite,
        height: 70,
        child: Row(
          children: [
            Avatar(
              firstName: p.firstName,
              lastName: p.lastName,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${formatName(p.firstName, p.lastName)}",
                      style: TextStyle(fontSize: MyTheme.regularTextSize),
                    ),
                    if (inscribed.position != null)
                      Text(
                        "Nro. ${inscribed.position}",
                        style: TextStyle(fontSize: MyTheme.smallTextSize),
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
