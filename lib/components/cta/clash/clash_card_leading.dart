import 'package:flutter/material.dart';

class ClashCardLeading extends StatelessWidget {
  const ClashCardLeading({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final colorByCategory = {
      "3F": Colors.orange[900],
      "3M": Colors.blue[900],
      "4F": Colors.orange[700],
      "4M": Colors.blue[700],
      "5F": Colors.orange[500],
      "5M": Colors.blue[500],
      "5MM": Colors.blue[300],
      "6F": Colors.orange[300],
      "6M": Colors.blue[100],
      "6MM": Colors.orange[100],
      "DM": Colors.yellow,
      "FEM-MM": Colors.pink,
    };

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 4),
      child: Container(
        height: double.infinity,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(width: 6, color: colorByCategory[categoryName]!),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
                color: colorByCategory[categoryName]!,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
