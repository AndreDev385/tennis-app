import 'package:flutter/material.dart';
import 'package:tennis_app/components/tournaments/tournament_card.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<StatefulWidget> createState() => _TournamentsPageState();

  static const route = "/tournaments";
}

class _TournamentsPageState extends State<TournamentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Torneos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              TournamentCard(),
            ],
          ),
        ),
      ),
    );
  }
}
