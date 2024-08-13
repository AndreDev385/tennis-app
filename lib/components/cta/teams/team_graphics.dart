import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/circle_chart.dart';
import 'package:tennis_app/dtos/team_stats.dto.dart';
import 'package:tennis_app/styles.dart';

class TeamGraphics extends StatelessWidget {
  const TeamGraphics({
    super.key,
    required this.stats,
  });

  final TeamStatsDto stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const Text(
              "Games ganados vs jugados",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 0.5,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 180,
              ),
              items: [
                ChartCard(
                  total: stats.totalGamesPlayed,
                  value: stats.totalGamesWon,
                  title: "General",
                  type: 2,
                ),
                ChartCard(
                  total: stats.gamesPlayedAsLocal,
                  value: stats.gamesWonAsLocal,
                  title: "Local",
                  type: 1,
                ),
                ChartCard(
                  total: stats.gamesPlayedAsVisitor,
                  value: stats.gamesWonAsVisitor,
                  title: "Visitante",
                  type: 0,
                )
              ],
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24)),
        Column(
          children: [
            const Text(
              "Sets ganados vs jugados",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 0.5,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 180,
              ),
              items: [
                ChartCard(
                  total: stats.totalSetsPlayed,
                  value: stats.totalSetsWon,
                  title: "General",
                  type: 2,
                ),
                ChartCard(
                  total: stats.setsPlayedAsLocal,
                  value: stats.setsWonAsLocal,
                  title: "Local",
                  type: 1,
                ),
                ChartCard(
                  total: stats.setsPlayedAsVisitor,
                  value: stats.setsWonAsVisitor,
                  title: "Visitante",
                  type: 0,
                )
              ],
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24)),
        Column(
          children: [
            const Text(
              "Super tie breaks ganados vs jugados",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 0.5,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 180,
              ),
              items: [
                ChartCard(
                  total: stats.totalSuperTieBreaksPlayed,
                  value: stats.totalSuperTieBreaksWon,
                  title: "General",
                  type: 2,
                ),
                ChartCard(
                  total: stats.superTieBreaksPlayedAsLocal,
                  value: stats.superTieBreaksWonAsLocal,
                  title: "Local",
                  type: 1,
                ),
                ChartCard(
                  total: stats.superTieBreaksPlayedAsVisitor,
                  value: stats.superTieBreaksWonAsVisitor,
                  title: "Visitante",
                  type: 0,
                )
              ],
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24)),
        Column(
          children: [
            const Text(
              "Partidos ganados y perdidos vs jugados",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 0.5,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 180,
              ),
              items: [
                ChartCard(
                  total: stats.totalMatchPlayed,
                  value: stats.totalMatchWon,
                  title: "General",
                  type: 2,
                ),
                ChartCard(
                  total: stats.matchPlayedAsLocal,
                  value: stats.matchWonAsLocal,
                  title: "Local Ganados",
                  type: 1,
                ),
                ChartCard(
                  total: stats.matchPlayedAsVisitor,
                  value: stats.matchWonAsVisitor,
                  title: "Visitante Ganados",
                  type: 0,
                ),
                ChartCard(
                  total: stats.matchPlayedAsLocal,
                  value: stats.matchLostAsLocal,
                  title: "Local Perdidos",
                  type: 1,
                ),
                ChartCard(
                  total: stats.matchPlayedAsVisitor,
                  value: stats.matchLostAsVisitor,
                  title: "Visitante Perdidos",
                  type: 0,
                )
              ],
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 24)),
        Column(
          children: [
            const Text(
              "Encuentros ganados vs jugados",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 4)),
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 0.5,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 180,
              ),
              items: [
                ChartCard(
                  total: stats.totalClashPlayed,
                  value: stats.totalClashWon,
                  title: "General",
                  type: 2,
                ),
                ChartCard(
                  total: stats.clashPlayedAsLocal,
                  value: stats.clashWonAsLocal,
                  title: "Local",
                  type: 1,
                ),
                ChartCard(
                  total: stats.clashPlayedAsVisitor,
                  value: stats.clashWonAsVisitor,
                  title: "Visitante",
                  type: 0,
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

class ChartCard extends StatelessWidget {
  const ChartCard({
    super.key,
    required this.total,
    required this.value,
    required this.title,
    required this.type,
  });

  final int value;
  final int total;
  final int type;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, left: 8),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
        ),
        elevation: 0,
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Expanded(
                child: CircularChart(
                  value: value,
                  total: total,
                  type: type,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
