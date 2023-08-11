import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/circle_chart.dart';
import 'package:tennis_app/dtos/team_stats.dto.dart';

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
                enableInfiniteScroll: false,
                viewportFraction: 0.4,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 170,
              ),
              items: [
                ChartCard(
                  total: stats.totalGamesPlayed,
                  value: stats.totalGamesWon,
                  title: "General",
                ),
                ChartCard(
                  total: stats.gamesPlayedAsLocal,
                  value: stats.gamesWonAsLocal,
                  title: "Local",
                ),
                ChartCard(
                  total: stats.gamesPlayedAsVisitor,
                  value: stats.gamesWonAsVisitor,
                  title: "Visitante",
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
                enableInfiniteScroll: false,
                viewportFraction: 0.4,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 160,
              ),
              items: [
                ChartCard(
                  total: stats.totalSetsPlayed,
                  value: stats.totalSetsWon,
                  title: "General",
                ),
                ChartCard(
                  total: stats.setsPlayedAsLocal,
                  value: stats.setsWonAsLocal,
                  title: "Local",
                ),
                ChartCard(
                  total: stats.setsPlayedAsVisitor,
                  value: stats.setsWonAsVisitor,
                  title: "Visitante",
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
                enableInfiniteScroll: false,
                viewportFraction: 0.4,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 160,
              ),
              items: [
                ChartCard(
                  total: stats.totalSuperTieBreaksPlayed,
                  value: stats.totalSuperTieBreaksWon,
                  title: "General",
                ),
                ChartCard(
                  total: stats.superTieBreaksPlayedAsLocal,
                  value: stats.superTieBreaksWonAsLocal,
                  title: "Local",
                ),
                ChartCard(
                  total: stats.superTieBreaksPlayedAsVisitor,
                  value: stats.superTieBreaksWonAsVisitor,
                  title: "Visitante",
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
                enableInfiniteScroll: false,
                viewportFraction: 0.4,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 160,
              ),
              items: [
                ChartCard(
                  total: stats.totalMatchPlayed,
                  value: stats.totalMatchWon,
                  title: "General",
                ),
                ChartCard(
                  total: stats.matchPlayedAsLocal,
                  value: stats.matchWonAsLocal,
                  title: "Local Ganados",
                ),
                ChartCard(
                  total: stats.matchPlayedAsLocal,
                  value: stats.matchLostAsLocal,
                  title: "Local Perdidos",
                ),
                ChartCard(
                  total: stats.matchPlayedAsVisitor,
                  value: stats.matchWonAsVisitor,
                  title: "Visitante Ganados",
                ),
                ChartCard(
                  total: stats.matchPlayedAsVisitor,
                  value: stats.matchLostAsVisitor,
                  title: "Visitante Perdidos",
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
                enableInfiniteScroll: false,
                viewportFraction: 0.4,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 160,
              ),
              items: [
                ChartCard(
                  total: stats.totalClashPlayed,
                  value: stats.totalClashWon,
                  title: "General",
                ),
                ChartCard(
                  total: stats.clashPlayedAsLocal,
                  value: stats.clashWonAsLocal,
                  title: "Local",
                ),
                ChartCard(
                  total: stats.clashPlayedAsVisitor,
                  value: stats.clashWonAsVisitor,
                  title: "Visitante",
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
  });

  final int value;
  final int total;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              Expanded(
                child: CircularChart(
                  value: value,
                  total: total,
                ),
              ),
              Text(
                "$value/$total",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
