import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/chart_colors.dart';

class BarChart extends StatelessWidget {
  final String title;
  final String division1;
  final String division2;
  final bool showPercent;
  final int percent1;
  final int percent2;
  final int type;

  const BarChart({
    super.key,
    required this.title,
    required this.division1,
    required this.division2,
    required this.percent1,
    required this.percent2,
    required this.showPercent,
    this.type = 0,
  });

  @override
  Widget build(BuildContext context) {
    int calculateBarWidth(int percent) {
      if (percent == 0) {
        return 0;
      }
      return (120 * percent) ~/ 100;
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //title
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                )
              ],
            ),
          ),
          // squares
          Container(
            height: 50,
            margin:
                const EdgeInsets.only(top: 8, left: 32, right: 32, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BarSquare(
                  division: division1,
                  barPercent: calculateBarWidth(percent1),
                  percent: showPercent ? "$percent1" : null,
                  type: type,
                ),
                BarSquare(
                  division: division2,
                  barPercent: calculateBarWidth(percent2),
                  percent: showPercent ? "$percent2" : null,
                  type: type,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarSquare extends StatelessWidget {
  final int barPercent;

  final String division;
  final String? percent;
  final int type;
  const BarSquare({
    super.key,
    required this.division,
    required this.barPercent,
    this.percent,
    this.type = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                division,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (percent != null)
                Text(
                  "($percent%)",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          Container(
            height: 20,
            width: 120,
            decoration: BoxDecoration(
              color: barBackgroundColor(type),
              borderRadius: BorderRadius.circular(MyTheme.regularBorderRadius),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: barPercent.toDouble(),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: barColorByType(type),
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      MyTheme.regularBorderRadius,
                    ),
                  ),
                ),
              ],
            ),
            //child: Container(),
          ),
        ],
      ),
    );
  }
}
