import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/layout/header.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/cta/live.dart';
import 'package:tennis_app/screens/app/cta/news.dart';
import 'package:tennis_app/screens/app/cta/profile.dart';
import 'package:tennis_app/screens/app/cta/results.dart';
import 'package:tennis_app/screens/app/cta/teams.dart';
import 'package:tennis_app/screens/app/pdf_preview.dart';
import 'package:tennis_app/services/get_current_season.dart';
import 'package:tennis_app/services/player/get_my_player_stats.dart';
import 'package:tennis_app/services/player/get_player_data.dart';
import 'package:tennis_app/services/list_ads.dart';
import 'package:tennis_app/services/list_categories.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/utils/state_keys.dart';

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
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    'selectedIdx': 0,
    StateKeys.error: "",
    'fail': false, // if fails loading player data
  };

  List<CategoryDto> _categories = [];
  List<AdDto> ads = [];
  PlayerDto? player;
  SeasonDto? currentSeason;

  String downloadRange = MatchRange.last;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    await _getUser();
    await _getCategories();
    await _getCurrentSeason();
    await getAds();
    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  getAds() async {
    final result = await listAds({'clubId': player!.clubId});

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = "Error al cargar publicidad";
      });
      return;
    }

    setState(() {
      ads = result.getValue();
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

  _getUser() async {
    StorageHandler st = await createStorageHandler();
    String? userJson = st.getUser();
    if (userJson == null) {
      return;
    }

    final user = UserDto.fromJson(jsonDecode(userJson));

    if (user.isPlayer) {}
    final result = await getPlayerData();

    if (result.isFailure) {
      return;
    }

    setState(() {
      this.player = result.getValue();
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

  void _onItemTapped(int index) {
    setState(() {
      state['selectedIdx'] = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      StorageHandler st = await createStorageHandler();

      String userJson = st.getUser();

      UserDto user = UserDto.fromJson(jsonDecode(userJson));

      Map<String, dynamic> query = {};

      if (range == MatchRange.last) {
        query["limit"] = 1;
      }

      if (range == MatchRange.last3) {
        query["limit"] = 3;
      }

      if (range == MatchRange.season) {
        query["season"] = currentSeason?.seasonId;
      }

      final result = await getMyPlayerStats(query);

      if (result.isFailure) {
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

    appBarIcon() {
      switch (state['selectedIdx']) {
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
      switch (state['selectedIdx']) {
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

    return PopScope(
      onPopInvoked: (bool value) async {
        return;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: const Header(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: AppBarTitle(title: appBarTitle(), icon: appBarIcon()),
          actions: [
            IconButton(
              onPressed: () => downloadPDF(context),
              icon: Icon(
                Icons.download,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        body: Container(
          child: (state[StateKeys.loading])
              ? const Center(child: CircularProgressIndicator())
              : renderPages(_categories).elementAt(state['selectedIdx']),
        ),
        floatingActionButton: state[StateKeys.loading]
            ? null
            : FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () => _onItemTapped(2),
                child: Icon(
                  Icons.person,
                  color: state['selectedIdx'] == 2
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.onPrimary,
                ),
                elevation: 8.0,
              ),
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
                    children: /* user != null && user!.isPlayer
                        ? */
                        [
                      BottomBarButton(
                        iconData: Icons.newspaper,
                        onPressed: _onItemTapped,
                        idx: 0,
                        selectedIdx: state['selectedIdx'],
                      ),
                      BottomBarButton(
                        iconData: Icons.live_tv,
                        onPressed: _onItemTapped,
                        idx: 1,
                        selectedIdx: state['selectedIdx'],
                      ),
                      Expanded(
                        child: Text(""),
                      ),
                      BottomBarButton(
                        iconData: Icons.people,
                        onPressed: _onItemTapped,
                        idx: 3,
                        selectedIdx: state['selectedIdx'],
                      ),
                      BottomBarButton(
                        iconData: Icons.sports_tennis,
                        onPressed: _onItemTapped,
                        idx: 4,
                        selectedIdx: state['selectedIdx'],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  List<Widget> renderPages(List<CategoryDto> categories) {
    return [
      News(
        ads: ads,
        adsError: (state[StateKeys.error] as String).length > 0,
        clubId: player!.clubId,
      ),
      Live(
        categories: categories,
        ads: ads,
        clubId: player!.clubId,
      ),
      const Profile(),
      Teams(
        categories: categories,
        ads: ads,
        clubId: player!.clubId,
      ),
      ClashResults(
        categories: categories,
        ads: ads,
        clubId: player!.clubId,
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
