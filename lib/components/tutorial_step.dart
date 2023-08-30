import 'package:flutter/material.dart';

class TutorialStep extends StatelessWidget {
  const TutorialStep({
    super.key,
    required this.title,
    required this.content,
    required this.number,
  });

  final String title;
  final String content;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(
                  '$number',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            content,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}