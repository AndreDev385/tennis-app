import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';

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
            title,
            style: TextStyle(
              fontSize: MyTheme.titleTextSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          if (navigate != null)
            InkWell(
              onTap: () => navigate!(),
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
