import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
