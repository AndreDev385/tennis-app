import 'package:flutter/material.dart';
import 'package:tennis_app/utils/chart_colors.dart';

class VerticalBarChart extends StatelessWidget {
  const VerticalBarChart({
    super.key,
    required this.percent,
    required this.fraction,
    required this.title,
    this.type = 0,
  });

  final int percent;
  final String fraction;
  final String title;
  final int type;

  @override
  Widget build(BuildContext context) {
    int calculateBarWidth(int percent) {
      if (percent == 0) {
        return 0;
      }
      return (120 * percent) ~/ 100;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "$percent%",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              fraction,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 4)),
        Row(
          children: [
            Container(
              height: 120,
              width: 30,
              decoration: BoxDecoration(
                color: barBackgroundColor(type), //Theme.of(context).colorScheme.surfaceTint,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: calculateBarWidth(percent).toDouble(),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: barColorByType(type),
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 8)),
        FittedBox(
          child: Text(
            title,
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
