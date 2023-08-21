import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.title,
    required this.division,
    required this.rivalDivision,
    required this.percent,
    required this.rivalPercent,
    required this.showPercent,
  });

  final String title;
  final String division;
  final String rivalDivision;

  final bool showPercent;

  final int percent;
  final int rivalPercent;

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
                Text(
                  title,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
                  division: division,
                  barPercent: calculateBarWidth(percent),
                  percent: showPercent ? "$percent" : null,
                ),
                BarSquare(
                  division: rivalDivision,
                  barPercent: calculateBarWidth(rivalPercent),
                  percent: showPercent ? "$rivalPercent" : null,
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
  const BarSquare({
    super.key,
    required this.division,
    required this.barPercent,
    this.percent,
  });

  final int barPercent;
  final String division;
  final String? percent;

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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (percent != null)
                Text(
                  "($percent%)",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          Container(
            height: 20,
            width: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceTint,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: barPercent.toDouble(),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.error,
                        Theme.of(context).colorScheme.tertiary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
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
