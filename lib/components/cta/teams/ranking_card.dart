import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/ranking_dto.dart';
import 'package:tennis_app/styles.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({
    super.key,
    required this.ranking,
  });

  final RankingDto ranking;

  @override
  Widget build(BuildContext context) {
    Map<String, Color> colors = {
      '1': Colors.yellow.shade400,
      '2': Colors.grey.shade400,
      '4': Colors.yellow.shade900,
      '8': Colors.blue.shade400,
      '16': Colors.blueGrey.shade800,
      'G': Colors.cyan.shade900,
    };

    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 8, left: 8),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: colors[ranking.symbol],
                ),
                child: Center(
                  child: Text(
                    ranking.symbol,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Text(
                "${ranking.team.category.name} ${ranking.team.name}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                ranking.position,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
