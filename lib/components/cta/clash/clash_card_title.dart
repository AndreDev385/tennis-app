import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';

class ClashCardTitle extends StatelessWidget {
  const ClashCardTitle({
    super.key,
    required this.vs,
    required this.journey,
    required this.lives,
    required this.isFinish,
    required this.host,
  });

  final String vs;
  final String journey;
  final int lives;
  final bool isFinish;
  final String host;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  vs,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Text(
                journey,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_pin,
                color: MyTheme.green,
              ),
              Expanded(
                child: Text(
                  host,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          if (!isFinish && lives > 0)
            Text(
              "$lives partidos en vivo",
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: MyTheme.green,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
