import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';

class TournamentMatchCardScoreRow extends StatelessWidget {
  final bool hasWon;
  final int? number;
  final String name;

  const TournamentMatchCardScoreRow({
    super.key,
    required this.hasWon,
    required this.name,
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
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    if (number != null)
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text("$number"),
                      ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(name),
                    ),
                    if (hasWon) Icon(Icons.check, color: MyTheme.green),
                  ],
                ),
              ],
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
                                "1",
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
