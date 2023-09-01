import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/layout/header.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/cta/create_clash.dart';
import 'package:tennis_app/screens/app/cta/live.dart';
import 'package:tennis_app/screens/app/cta/news.dart';
import 'package:tennis_app/screens/app/cta/profile.dart';
import 'package:tennis_app/screens/app/cta/results.dart';
import 'package:tennis_app/screens/app/cta/teams.dart';
import 'package:tennis_app/screens/app/cta/track_match.dart';
import 'package:tennis_app/services/get_player_data.dart';
import 'package:tennis_app/services/list_categories.dart';
import 'package:tennis_app/services/list_seasons.dart';

class CtaHomePage extends StatefulWidget {
  const CtaHomePage({super.key});

  static const route = "/cta";

  @override
  State<CtaHomePage> createState() => _CtaHomePage();
}

class _CtaHomePage extends State<CtaHomePage> {
  bool _loading = true;
  int _selectedIndex = 0;
  List<CategoryDto> _categories = [];
  UserDto? user;

  bool hasAPausedMatch = false;

  Match? pausedMatch;

  @override
  void initState() {
    EasyLoading.show(status: "Cargando...");
    _getData();
    super.initState();
  }

  _getData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await _getUser();
    await _getCategories(storage);
    await _getCurrentSeason(storage);
    await _getPausedMatch(storage);
    setState(() {
      _loading = false;
    });
    EasyLoading.dismiss();
  }

  _getPausedMatch(SharedPreferences storage) {
    List<String>? paused = storage.getStringList("pausedMatch");

    setState(() {
      if (paused == null) {
        hasAPausedMatch = false;
        return;
      }

      hasAPausedMatch = true;
      Match match = Match.fromJson(jsonDecode(paused[1]));
      pausedMatch = match;
    });
  }

  _getCategories(SharedPreferences storage) async {
    String? categoriesJson = storage.getString("categories");

    if (categoriesJson != null) {
      List<dynamic> rawList = jsonDecode(categoriesJson);
      setState(() {
        _categories = rawList.map((e) => CategoryDto.fromJson(e)).toList();
        _loading = false;
      });
      return;
    }

    final result = await listCategories({});

    if (result.isFailure) {
      return;
    }

    List<CategoryDto> list = result.getValue();

    setState(() {
      _categories = list;
      _loading = false;
    });

    EasyLoading.dismiss();
  }

  _getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? userJson = storage.getString("user");
    if (userJson == null) {
      return;
    }

    final user = UserDto.fromJson(jsonDecode(userJson));

    if (user.isPlayer) {
      await getPlayerData();
    }

    setState(() {
      this.user = user;
    });
    EasyLoading.dismiss();
  }

  _getCurrentSeason(SharedPreferences storage) async {
    String? seasonJson = storage.getString("season");

    if (seasonJson == null) {
      await listSeasons({'isCurrentSeason': 'true'}).catchError((e) {
        EasyLoading.showError("Ha ocurrido un error");
      });
    }
    EasyLoading.dismiss();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    goToTrackLive(String matchId) {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        TrackMatch.route,
        arguments: TrackMatchArgs(matchId: matchId),
      );
    }

    continueMatch() async {
      SharedPreferences storage = await SharedPreferences.getInstance();

      List<String> pausedMatch = storage.getStringList("pausedMatch") ?? [];

      Match match = Match.fromJson(jsonDecode(pausedMatch[1]));

      gameProvider.startPausedMatch(match);

      await storage.remove("pausedMatch");

      goToTrackLive(pausedMatch[0]);
    }

    modalBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Reanudar partido"),
              content: const Text("Quieres reanudar el partido?"),
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
                  onPressed: () => continueMatch(),
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

    appBarIcon() {
      switch (_selectedIndex) {
        case 0:
          return Icons.newspaper;
        case 1:
          return Icons.live_tv;
        case 2:
          return Icons.person;
        case 3:
          return Icons.people;
        case 4:
          return Icons.sports_tennis;
      }
      return Icons.newspaper;
    }

    appBarTitle() {
      switch (_selectedIndex) {
        case 0:
          return "Novedades";
        case 1:
          return "Live";
        case 2:
          return "Perfil";
        case 3:
          return "Equipos";
        case 4:
          return "Resultados";
      }
      return "";
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const Header(),
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle(title: appBarTitle(), icon: appBarIcon()),
        actions: [
          if (hasAPausedMatch && (user != null && user!.canTrack))
            IconButton(
              onPressed: () => modalBuilder(context),
              icon: const Icon(Icons.play_arrow),
            ),
          if (user != null && user!.canTrack)
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CreateClash.route);
              },
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: Container(
        child: (_loading && _categories.isNotEmpty)
            ? const Center()
            : renderPages(_categories).elementAt(_selectedIndex),
      ),
      floatingActionButton: user != null && user!.isPlayer ? FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        child: Icon(
          Icons.person,
          color: _selectedIndex == 2
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.onSurface,
        ),
        elevation: 4.0,
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _loading
          ? null
          : BottomAppBar(
              color: Theme.of(context).colorScheme.primary,
              child: Container(
                height: 60,
                child: Row(
                  children: user != null && user!.isPlayer ? [
                    BottomBarButton(
                      iconData: Icons.newspaper,
                      onPressed: _onItemTapped,
                      idx: 0,
                      selectedIdx: _selectedIndex,
                    ),
                    BottomBarButton(
                      iconData: Icons.live_tv,
                      onPressed: _onItemTapped,
                      idx: 1,
                      selectedIdx: _selectedIndex,
                    ),
                    Expanded(
                      child: Text(""),
                    ),
                    BottomBarButton(
                      iconData: Icons.people,
                      onPressed: _onItemTapped,
                      idx: 3,
                      selectedIdx: _selectedIndex,
                    ),
                    BottomBarButton(
                      iconData: Icons.sports_tennis,
                      onPressed: _onItemTapped,
                      idx: 4,
                      selectedIdx: _selectedIndex,
                    ),
                  ] : [
                    BottomBarButton(
                      iconData: Icons.newspaper,
                      onPressed: _onItemTapped,
                      idx: 0,
                      selectedIdx: _selectedIndex,
                    ),
                    BottomBarButton(
                      iconData: Icons.live_tv,
                      onPressed: _onItemTapped,
                      idx: 1,
                      selectedIdx: _selectedIndex,
                    ),
                    BottomBarButton(
                      iconData: Icons.sports_tennis,
                      onPressed: _onItemTapped,
                      idx: 4,
                      selectedIdx: _selectedIndex,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  List<Widget> renderPages(List<CategoryDto> categories) {
    return [
      const News(),
      Live(categories: categories),
      const Profile(),
      Teams(categories: categories),
      ClashResults(categories: categories),
    ];
  }
}

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.selectedIdx,
    required this.idx,
  });

  final IconData iconData;
  final Function onPressed;
  final int selectedIdx;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        icon: Icon(
          iconData,
          color: selectedIdx == idx
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () => onPressed(idx),
      ),
    );
  }
}
