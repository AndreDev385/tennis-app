import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/tournaments/inscribed.dart';
import 'package:tennis_app/utils/format_player_name.dart';

class CoupleCard extends StatelessWidget {
  final InscribedCouple inscribed;

  const CoupleCard({
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${formatName(inscribed.couple.p1.firstName, inscribed.couple.p1.lastName)} / ${formatName(inscribed.couple.p2.firstName, inscribed.couple.p2.lastName)}",
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
