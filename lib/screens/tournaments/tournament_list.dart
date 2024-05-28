import 'package:flutter/material.dart';
import 'package:tennis_app/components/tournaments/tournament_card.dart';

import '../../dtos/tournaments/tournament.dart';
import '../../services/tournaments/paginate.dart';

class TournamentListPage extends StatefulWidget {
  const TournamentListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TournamentListPageState();

  static const route = "/tournaments";
}

class _TournamentListPageState extends State<TournamentListPage> {
  List<Tournament> tournaments = [];

  @override
  void initState() {
    _paginateTournaments();
    super.initState();
  }

  _paginateTournaments() async {
    final result = await paginateTournaments();
    if (result.isFailure) {
      return;
    }

    setState(() {
      tournaments = result.getValue().rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
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
            children: tournaments.map((t) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: TournamentCard(tournament: t),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
