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
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                journey,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Icon(Icons.location_pin), Text(host)],
          ),
          if (!isFinish && lives > 0)
            Text(
              "$lives partidos en vivo",
              textAlign: TextAlign.center,
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
