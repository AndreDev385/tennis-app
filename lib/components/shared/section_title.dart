import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Function? navigate;

  SectionTitle({
    super.key,
    required this.title,
    this.navigate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        mainAxisAlignment: navigate != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          if (navigate != null)
            TextButton(
              onPressed: () => navigate!(),
              child: Text(
                "Ver más",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
