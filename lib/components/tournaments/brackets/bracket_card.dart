import 'package:flutter/material.dart';
import 'package:tennis_app/utils/format_player_name.dart';

import '../../../domain/tournament/bracket.dart';
import '../../../styles.dart';

class BracketCard extends StatelessWidget {
  final Place rightPlace;
  final Place leftPlace;

  const BracketCard({
    super.key,
    required this.rightPlace,
    required this.leftPlace,
  });

  @override
  Widget build(BuildContext context) {
    _buildNameForDisplay(Place place) {
      if (place.couple != null) {
        return "${shortNameFormat(place.couple!.p1.firstName, place.couple!.p1.lastName)}/${formatName(place.couple!.p2.firstName, place.couple!.p2.lastName)}";
      }
      if (place.participant != null) {
        return "${formatName(place.participant!.firstName, place.participant!.lastName)}";
      }
      return "";
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          BracketRow(
            isTop: true,
            hasWon: false,
            name: _buildNameForDisplay(rightPlace),
            number: rightPlace.value,
          ),
          Divider(color: Theme.of(context).colorScheme.secondary, height: .1),
          BracketRow(
            isTop: false,
            hasWon: false,
            name: _buildNameForDisplay(leftPlace),
            number: leftPlace.value,
          ),
        ],
      ),
    );
  }
}

class BracketRow extends StatelessWidget {
  final bool isTop;
  final bool hasWon;
  final int? number;
  final String name;

  const BracketRow({
    super.key,
    required this.hasWon,
    required this.name,
    required this.isTop,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: this.hasWon
              ? Theme.of(context).brightness == Brightness.light
                  ? Colors.green[100]
                  : Colors.green[900]
              : null,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isTop ? 16 : 0),
            topRight: Radius.circular(isTop ? 16 : 0),
            bottomLeft: Radius.circular(isTop ? 0 : 16),
            bottomRight: Radius.circular(isTop ? 0 : 16),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  if (number != null)
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text("$number"),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        name,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (hasWon) Icon(Icons.check, color: MyTheme.green),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 84),
              child: Row(
                children: [
                  ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      return SizedBox(
                        width: 28,
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "x",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
