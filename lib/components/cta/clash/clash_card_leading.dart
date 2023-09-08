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
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 4),
      child: Container(
        height: double.infinity,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 6, color: colorByCategory[categoryName]!),
        ),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              color: colorByCategory[categoryName]!,
              fontWeight: FontWeight.bold,
              fontSize: categoryName.length > 3 ? 12 : 16,
            ),
          ),
        ),
      ),
    );
  }
}
