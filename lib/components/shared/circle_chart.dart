// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/utils/calculate_percent.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tennis_app/utils/chart_colors.dart';

class Sector {
  final Color color;
  final double value;
  final bool isValue;

  const Sector({
    required this.color,
    required this.value,
    required this.isValue,
  });
}

class CircularChart extends StatelessWidget {
  const CircularChart({
    super.key,
    required this.value,
    required this.total,
    this.type = 0,
  });

  final int value;
  final int total;
  final int type;

  @override
  Widget build(BuildContext context) {
    int percent = calculatePercent(value, total);

    Map<String, double> dataMap = {
      "value": percent.toDouble(),
      "total": (100 - percent).toDouble(),
    };

    final gradientList = <List<Color>>[
      barColorByType(type),
      [
        barBackgroundColor(type),
        barBackgroundColor(type),
      ],
    ];

    return PieChart(
      dataMap: dataMap,
      chartRadius: MediaQuery.of(context).size.width / 2,
      ringStrokeWidth: 15,
      centerText: "$value/$total",
      centerTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      chartType: ChartType.ring,
      animationDuration: const Duration(milliseconds: 1500),
      chartValuesOptions: ChartValuesOptions(
        showChartValues: true,
        showChartValuesOutside: true,
        showChartValuesInPercentage: true,
        showChartValueBackground: false,
        decimalPlaces: 0,
        chartValueStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      legendOptions: const LegendOptions(
        showLegends: false,
      ),
      gradientList: gradientList,
    );
  }
}

String formatPercent(int value) {
  return "$value%";
}
