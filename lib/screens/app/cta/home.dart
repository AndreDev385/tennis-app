import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/layout/header.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/cta/create_clash.dart';
import 'package:tennis_app/screens/app/cta/live.dart';
import 'package:tennis_app/screens/app/cta/news.dart';
import 'package:tennis_app/screens/app/cta/profile.dart';
import 'package:tennis_app/screens/app/cta/results.dart';
import 'package:tennis_app/screens/app/cta/teams.dart';
import 'package:tennis_app/screens/app/cta/track_match.dart';
import 'package:tennis_app/screens/app/pdf_preview.dart';
import 'package:tennis_app/services/get_current_season.dart';
import 'package:tennis_app/services/get_my_player_stats.dart';
import 'package:tennis_app/services/get_player_data.dart';
import 'package:tennis_app/services/list_ads.dart';
import 'package:tennis_app/services/list_categories.dart';

class MatchRange {
  static const last = 'Último partido';
  static const last3 = 'Últimos 3 partidos';
  static const season = 'Temporada';
  static const all = 'Siempre';
}

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
  List<AdDto> ads = [];
  UserDto? user;
  SeasonDto? currentSeason;

  bool hasAPausedMatch = false;

  Match? pausedMatch;

  String downloadRange = MatchRange.last;

  @override
  void initState() {
    EasyLoading.show();
    _getData();
    super.initState();
  }

  _getData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await _getUser();
    await _getCategories(storage);
    await _getCurrentSeason(storage);
    await _getPausedMatch(storage);
    await getAds();
    setState(() {
      _loading = false;
    });
    EasyLoading.dismiss();
  }

  getAds() async {
    final result = await listAds({}).catchError((e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error al cargar novedades");
      return e;
    });
    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      ads = result.getValue();
    });
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
    final result = await getCurrentSeason();

    if (result.isFailure) {
      return;
    }

    setState(() {
      currentSeason = result.getValue();
    });
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

    goToPDFPreview(
      PlayerTrackerDto stats,
      String playerName,
      String range,
    ) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PDFPreview(
            playerName: playerName,
            range: range,
            stats: stats,
          ),
        ),
      );
    }

    handleBuildPDf(String range) async {
      SharedPreferences storage = await SharedPreferences.getInstance();

      String userJson = storage.getString("user")!;

      UserDto user = UserDto.fromJson(jsonDecode(userJson));

      Map<String, dynamic> query = {};

      if (range == MatchRange.last) {
        query["last"] = true;
      }

      if (range == MatchRange.last3) {
        query["last3"] = true;
      }

      if (range == MatchRange.season) {
        query["season"] = currentSeason?.seasonId;
      }

      final result = await getMyPlayerStats(query);

      if (result.isFailure) {
        print("${result.error}");
        EasyLoading.showError("Ha ocurrido un error.");
        return;
      }

      PlayerTrackerDto stats = result.getValue();

      goToPDFPreview(stats, "${user.firstName} ${user.lastName}", range);
    }

    downloadPDF(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            String selectedRange = MatchRange.last;
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: const Text(
                  "Descargar estadísticas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: DropdownButton(
                  value: selectedRange,
                  hint: Text("Partidos"),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      value: MatchRange.last,
                      child: Text(
                        "Último",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: MatchRange.last3,
                      child: Text(
                        "Últimos 3",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: MatchRange.season,
                      child: Text(
                        "Temporada",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: MatchRange.all,
                      child: Text(
                        "Siempre",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (dynamic value) {
                    setState(() {
                      downloadRange = value;
                      selectedRange = value;
                    });
                  },
                ),
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
                      handleBuildPDf(selectedRange);
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
              ),
            );
          });
    }

    continueMatch() async {
      SharedPreferences storage = await SharedPreferences.getInstance();

      List<String> pausedMatch = storage.getStringList("pausedMatch") ?? [];

      Match match = Match.fromJson(jsonDecode(pausedMatch[1]));

      gameProvider.startPausedMatch(match);

      await storage.remove("pausedMatch");

      goToTrackLive(pausedMatch[0]);
    }

    resumeMatchModal(BuildContext context) {
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
          if (user != null && user!.isPlayer)
            IconButton(
              onPressed: () => downloadPDF(context),
              icon: const Icon(Icons.download),
            ),
          if (hasAPausedMatch && (user != null && user!.canTrack))
            IconButton(
              onPressed: () => resumeMatchModal(context),
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
      floatingActionButton: user != null && user!.isPlayer
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () => _onItemTapped(2),
              child: Icon(
                Icons.person,
                color: _selectedIndex == 2
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.onPrimary,
              ),
              elevation: 8.0,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _loading
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
                  children: user != null && user!.isPlayer
                      ? [
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
                        ]
                      : [
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
      News(ads: ads),
      Live(
        categories: categories,
        ads: ads,
      ),
      const Profile(),
      Teams(
        categories: categories,
        ads: ads,
      ),
      ClashResults(
        categories: categories,
        ads: ads,
      ),
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
