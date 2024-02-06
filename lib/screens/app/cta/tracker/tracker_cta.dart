import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/club_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/providers/tracker_state.dart';
import 'package:tennis_app/screens/app/cta/create_clash.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/screens/app/cta/live.dart';
import 'package:tennis_app/screens/app/cta/news.dart';
import 'package:tennis_app/screens/app/cta/results.dart';
import 'package:tennis_app/screens/app/cta/track_match.dart';
import 'package:tennis_app/screens/app/cta/tracker/choose_club.dart';
import 'package:tennis_app/services/get_current_season.dart';
import 'package:tennis_app/services/list_categories.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/utils/state_keys.dart';

class TrackerCTA extends StatefulWidget {
  const TrackerCTA({
    super.key,
    required this.club,
  });

  final ClubDto club;

  @override
  State<TrackerCTA> createState() => _TrackerCTA();
}

class _TrackerCTA extends State<TrackerCTA> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    'pendingMatch': false,
    'selectedIdx': 1,
    StateKeys.error: "",
    'fail': false, // if fails loading player data
  };

  SeasonDto? currentSeason;
  List<CategoryDto> _categories = [];

  _pendingMatch(StorageHandler st) {
    String? matchStr = st.getTennisLiveMatch();

    setState(() {
      if (matchStr == null) {
        state['pendingMatch'] = false;
      } else {
        state['pendingMatch'] = true;
      }
    });
  }

  _getCategories() async {
    final result = await listCategories({});

    if (result.isFailure) {
      return;
    }

    List<CategoryDto> list = result.getValue();

    setState(() {
      _categories = list;
    });
  }

  _getCurrentSeason() async {
    final result = await getCurrentSeason();

    if (result.isFailure) {
      return;
    }

    setState(() {
      currentSeason = result.getValue();
    });
  }

  _getData() async {
    StorageHandler st = await createStorageHandler();
    await _pendingMatch(st);
    await _getCategories();
    await _getCurrentSeason();
    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  appBarIcon() {
    switch (state['selectedIdx']) {
      case 0:
        return Icons.newspaper;
      case 1:
        return Icons.live_tv;
      case 2:
        return Icons.sports_tennis;
    }
    return Icons.newspaper;
  }

  appBarTitle() {
    switch (state['selectedIdx']) {
      case 0:
        return "Novedades";
      case 1:
        return "Live";
      case 2:
        return "Resultados";
    }
    return "";
  }

  void _onItemTapped(int index) {
    setState(() {
      state['selectedIdx'] = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);
    final trackerProvider = Provider.of<TrackerState>(context);

    void resumeMatch(BuildContext context) async {
      StorageHandler st = await createStorageHandler();

      String matchStr = st.getTennisLiveMatch();

      final matchObj = jsonDecode(matchStr);

      await gameProvider.restorePendingMatch();

      Navigator.of(context).pushNamed(
        TrackMatch.route,
        arguments: TrackMatchArgs(matchId: matchObj['tracker']['matchId']),
      );
    }

    resumePendingMatch(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text(
                "Continuar partido",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content:
                  Text("Deseas continuar el partido que tienes pendiente?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resumeMatch(context);
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text(
                    "Aceptar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    List<Widget> renderPages(List<CategoryDto> categories) {
      return [
        News(
          ads: [],
          adsError: (state[StateKeys.error] as String).length > 0,
          clubId: widget.club.clubId,
        ),
        Live(
          categories: categories,
          ads: [],
          clubId: widget.club.clubId,
        ),
        ClashResults(
          categories: categories,
          ads: [],
          clubId: widget.club.clubId,
        ),
      ];
    }

    return PopScope(
      onPopInvoked: (bool value) async {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ChooseClub()),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.club.symbol,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          centerTitle: true,
          leading: BackButton(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          actions: [
            if (state['pendingMatch'])
              IconButton(
                onPressed: () => resumePendingMatch(context),
                icon: Icon(
                  Icons.play_arrow,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => CreateClash(
                          currentClub: trackerProvider.currentClub!,
                        ),
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        body: (state[StateKeys.loading])
            ? const Center(child: CircularProgressIndicator())
            : renderPages(_categories).elementAt(state['selectedIdx']),
        floatingActionButton: !state[StateKeys.loading]
            ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () => _onItemTapped(1),
                child: Icon(
                  Icons.live_tv,
                  color: state['selectedIdx'] == 1
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.onPrimary,
                ),
                elevation: 8.0,
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: state[StateKeys.loading]
            ? null
            : BottomAppBar(
                shape: AutomaticNotchedShape(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  StadiumBorder(),
                ),
                height: 60,
                notchMargin: 8,
                color: Theme.of(context).colorScheme.primary,
                shadowColor: Theme.of(context).colorScheme.primaryContainer,
                child: Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      BottomBarButton(
                        iconData: Icons.newspaper,
                        onPressed: _onItemTapped,
                        idx: 0,
                        selectedIdx: state['selectedIdx'],
                      ),
                      BottomBarButton(
                        iconData: Icons.sports_tennis,
                        onPressed: _onItemTapped,
                        idx: 2,
                        selectedIdx: state['selectedIdx'],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
