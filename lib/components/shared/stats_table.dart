import 'package:flutter/material.dart';
import 'package:tennis_app/components/results/title_row.dart';
import 'package:tennis_app/styles.dart';

class Stat {
  final String name;
  final String firstValue;
  final String secondValue;
  final int? percentage1;
  final int? percentage2;

  const Stat({
    required this.name,
    required this.firstValue,
    required this.secondValue,
    required this.percentage1,
    required this.percentage2,
  });
}

class Section {
  final String? title;
  final List<Stat> stats;

  const Section({
    required this.title,
    required this.stats,
  });
}

class StatsTable extends StatelessWidget {
  final List<Section> sections;

  const StatsTable({
    super.key,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    mapPercentageToColor(int number) {
      if (number > 85) {
        return Colors.greenAccent.shade700;
      }
      if (number < 15) {
        return Colors.red.shade700;
      }
      return Theme.of(context).colorScheme.onSurface;
    }

    return Column(
      children: [
        ...sections
            .map(
              (e) => (Column(
                children: [
                  Column(
                    children: [
                      if (e.title != null) TitleRow(title: e.title!),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Table(
                          border: const TableBorder(
                            horizontalInside: BorderSide(
                              width: .5,
                              color: Colors.grey,
                            ),
                            bottom: BorderSide(width: .5, color: Colors.grey),
                          ),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(),
                          },
                          children: e.stats
                              .map((s) => (TableRow(
                                    children: [
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          alignment: Alignment.center,
                                          height: 40,
                                          child: Text(
                                            s.firstValue,
                                            style: TextStyle(
                                              fontSize: MyTheme.smallTextSize,
                                              color: s.percentage2 != null
                                                  ? mapPercentageToColor(
                                                      s.percentage1!,
                                                    )
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          //color: Colors.yellow[100],
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          alignment: Alignment.center,
                                          height: 40,
                                          child: Text(
                                            s.name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: MyTheme.smallTextSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          alignment: Alignment.center,
                                          height: 40,
                                          child: Text(
                                            s.secondValue,
                                            style: TextStyle(
                                              fontSize: MyTheme.smallTextSize,
                                              color: s.percentage2 != null
                                                  ? mapPercentageToColor(
                                                      s.percentage2!)
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            )
            .toList(),
        Padding(padding: EdgeInsets.only(bottom: 80))
      ],
    );
  }
}
