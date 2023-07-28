import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/category_colors.dart';

class ClashCardLeading extends StatelessWidget {
  const ClashCardLeading({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 4),
      child: Container(
        height: double.infinity,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(width: 8, color: colorByCategory[categoryName]!),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              color: colorByCategory[categoryName]!,
              fontWeight: FontWeight.bold,
              fontSize: categoryName.length > 3 ? 12 : 20,
            ),
          ),
        ),
      ),
    );
  }
}
