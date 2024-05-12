import 'package:flutter/material.dart';
import 'package:tennis_app/components/results/title_row.dart';

class Stat {
  final String name;
  final String firstValue;
  final String secondValue;

  const Stat({
    required this.name,
    required this.firstValue,
    required this.secondValue,
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
                            horizontalInside:
                                BorderSide(width: .5, color: Colors.grey),
                            bottom: BorderSide(width: .5, color: Colors.grey),
                          ),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(),
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
                                          alignment: Alignment.centerLeft,
                                          height: 60,
                                          child: Text(
                                            s.name,
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          alignment: Alignment.centerRight,
                                          height: 60,
                                          child: Text(
                                            s.firstValue,
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          alignment: Alignment.centerRight,
                                          height: 60,
                                          child: Text(
                                            s.secondValue,
                                            style: TextStyle(
                                              fontSize: 13,
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
            .toList()
      ],
    );
  }
}
