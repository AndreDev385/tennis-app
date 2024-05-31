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
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: navigate != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          if (navigate != null)
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () => navigate!(),
              child: Text(
                "Ver más",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
