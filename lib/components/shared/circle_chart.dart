import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/utils/calculate_percent.dart';
//import 'package:pie_chart/pie_chart.dart';

class Sector {
  final Color color;
  final double value;
  final bool isValue;

  const Sector(
      {required this.color, required this.value, required this.isValue});
}

class CircularChart extends StatelessWidget {
  const CircularChart({
    super.key,
    required this.value,
    required this.total,
  });

  final int value;
  final int total;

  @override
  Widget build(BuildContext context) {
    int percent = calculatePercent(value, total);
    List<Sector> sectors = [
      Sector(
        value: percent.toDouble(),
        color: Theme.of(context).colorScheme.tertiary,
        isValue: true,
      ),
      Sector(
        color: Theme.of(context).colorScheme.primary,
        value: (100 - percent).toDouble(),
        isValue: false,
      ),
    ];

    Map<String, double> dataMap = {
      "Food Items": 18.47,
      "Clothes": 17.70,
      "Technology": 4.25,
      "Cosmetics": 3.51,
      "Other": 2.83,
    };

    List<Color> colorList = [
      const Color(0xffD95AF3),
      const Color(0xff3EE094),
      const Color(0xff3398F6),
      const Color(0xffFA4A42),
      const Color(0xffFE9539)
    ];

    final gradientList = <List<Color>>[
      [
        Color.fromRGBO(223, 250, 92, 1),
        Color.fromRGBO(129, 250, 112, 1),
      ],
      [
        Color.fromRGBO(129, 182, 205, 1),
        Color.fromRGBO(91, 253, 199, 1),
      ],
      [
        Color.fromRGBO(175, 63, 62, 1.0),
        Color.fromRGBO(254, 154, 92, 1),
      ]
    ];

    return /*PieChart(
          dataMap: dataMap,
          colorList: colorList,
          chartRadius: MediaQuery.of(context).size.width / 2,
          centerText: "Budget",
          ringStrokeWidth: 24,
          animationDuration: const Duration(seconds: 3),
          chartValuesOptions: const ChartValuesOptions(
              showChartValues: true,
              showChartValuesOutside: true,
              showChartValuesInPercentage: true,
              showChartValueBackground: false),
          legendOptions: const LegendOptions(
              showLegends: true,
              legendShape: BoxShape.rectangle,
              legendTextStyle: TextStyle(fontSize: 15),
              legendPosition: LegendPosition.bottom,
              showLegendsInRow: true),
          gradientList: gradientList,
        );*/
        PieChart(
      PieChartData(
        sections: _chartSections(sectors),
        centerSpaceRadius: 0,
        sectionsSpace: 0,
      ),
    );
  }

  List<PieChartSectionData> _chartSections(List<Sector> sectors) {
    return sectors
        .map(
          (e) => PieChartSectionData(
            value: e.value,
            color: e.color,
            radius: e.isValue ? 50 : 40,
            title: formatPercent(e.value.toInt()),
            titleStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.black, blurRadius: 2)],
            ),
          ),
        )
        .toList();
  }
}

String formatPercent(int value) {
  return "$value%";
}
