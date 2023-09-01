import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

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

    return PieChart(
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
