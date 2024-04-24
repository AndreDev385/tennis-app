import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tennis_app/dtos/club_dto.dart';
import 'package:tennis_app/providers/tracker_state.dart';
import 'package:tennis_app/screens/cta/tracker/tracker_cta.dart';
import 'package:tennis_app/screens/home.dart';
import 'package:tennis_app/services/list_clubs.dart';
import "package:tennis_app/utils/state_keys.dart";

class ChooseClub extends StatefulWidget {
  static const route = "/choose-club";

  const ChooseClub({super.key});

  @override
  State<ChooseClub> createState() => _ChooseClub();
}

class ClubCard extends StatelessWidget {
  final ClubDto club;

  const ClubCard({
    super.key,
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    final trackerProvider = Provider.of<TrackerState>(context);

    goToClub() {
      Navigator.of(context).push(
        MaterialPageRoute(
          maintainState: true,
          builder: (context) => TrackerCTA(club: club),
        ),
      );
    }

    handleSelectClub() {
      trackerProvider.setCurrentClub(club);

      goToClub();
    }

    return GestureDetector(
      onTap: () => handleSelectClub(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
        height: 60,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                club.name,
                style: TextStyle(
                  fontSize: 18,
                  //fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                club.symbol,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChooseClub extends State<ChooseClub> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };

  List<ClubDto> clubs = [];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) async {
        Navigator.of(context).pushNamed(MyHomePage.route);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("Clubs"),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            if (state[StateKeys.loading])
              SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if ((state[StateKeys.error] as String).length > 0)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    state[StateKeys.error],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              SliverFillRemaining(
                child: ListView(
                  children: clubs.map((c) => ClubCard(club: c)).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getClubs();
  }

  _getClubs() async {
    final result = await listClubs({'isSubscribed': 'true'});

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error;
        state[StateKeys.loading] = false;
      });
    }

    setState(() {
      clubs = result.getValue();
      state[StateKeys.loading] = false;
    });
  }
}
