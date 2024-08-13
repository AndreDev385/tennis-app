import 'package:flutter/material.dart';
import 'package:tennis_app/components/tournaments/avatar.dart';
import 'package:tennis_app/dtos/tournaments/inscribed.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/format_player_name.dart';

class CoupleCard extends StatelessWidget {
  final InscribedCouple inscribed;

  const CoupleCard({
    super.key,
    required this.inscribed,
  });

  @override
  Widget build(BuildContext context) {
    var p1 = inscribed.couple.p1;
    var p2 = inscribed.couple.p2;

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
              firstName: p1.firstName,
              lastName: p1.lastName,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      formatName(p1.firstName, p1.lastName),
                      style: TextStyle(
                        fontSize: MyTheme.regularTextSize,
                      ),
                    ),
                    Text(
                      formatName(p2.firstName, p2.lastName),
                      style: TextStyle(
                        fontSize: MyTheme.regularTextSize,
                      ),
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
            Avatar(
              firstName: p2.firstName,
              lastName: p2.lastName,
            )
          ],
        ),
      ),
    );
  }
}
