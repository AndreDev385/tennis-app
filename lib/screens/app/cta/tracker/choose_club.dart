import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/dtos/club_dto.dart';
import 'package:tennis_app/providers/tracker_state.dart';
import 'package:tennis_app/screens/app/cta/tracker/tracker_cta.dart';
import 'package:tennis_app/screens/app/home.dart';
import 'package:tennis_app/services/list_clubs.dart';

import "package:tennis_app/utils/state_keys.dart";

class ChooseClub extends StatefulWidget {
  const ChooseClub({super.key});

  static const route = "/choose-club";

  @override
  State<ChooseClub> createState() => _ChooseClub();
}

class _ChooseClub extends State<ChooseClub> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };

  List<ClubDto> clubs = [];

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

  @override
  void initState() {
    super.initState();
    _getClubs();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(MyHomePage.route);
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
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
}

class ClubCard extends StatelessWidget {
  const ClubCard({
    super.key,
    required this.club,
  });

  final ClubDto club;

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
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
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
      ),
    );
  }
}
