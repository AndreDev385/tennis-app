import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/utils/calculate_percent.dart';

class Sector {
  final Color color;
  final double value;

  const Sector({
    required this.color,
    required this.value,
  });
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
          color: Theme.of(context).colorScheme.tertiary),
      Sector(
          color: Theme.of(context).colorScheme.primary,
          value: (100 - percent).toDouble()),
    ];

    return AspectRatio(
      aspectRatio: 1.0,
      child: PieChart(
        PieChartData(
          sections: _chartSections(sectors),
        ),
      ),
    );
  }

  List<PieChartSectionData> _chartSections(List<Sector> sectors) {
    return sectors
        .map(
          (e) => PieChartSectionData(
            value: e.value,
            color: e.color,
            radius: 15,
            showTitle: false,
          ),
        )
        .toList();
  }
}
