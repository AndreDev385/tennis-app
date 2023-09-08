import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/profile/ball_in_game_charts.dart';
import 'package:tennis_app/components/cta/profile/profile_table.dart';
import 'package:tennis_app/components/cta/profile/return_charts.dart';
import 'package:tennis_app/components/cta/profile/service_charts.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/get_my_player_stats.dart';
import 'package:tennis_app/services/list_seasons.dart';
import 'package:tennis_app/services/utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  PlayerTrackerDto? stats;

  SeasonDto? currentSeason;

  List<bool> selectedOptions = [true, false, false];
  List<bool> selectViewOptions = [true, false];

  bool showMore = false;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  seeMore() {
    setState(() {
      showMore = !showMore;
    });
  }

  getData() async {
    EasyLoading.show(status: "Cargando...");
    await getCurrentSeason();
    await getPlayerStats();
    setState(() {
      loading = false;
    });
    EasyLoading.dismiss();
  }

  getCurrentSeason() async {
    final result =
        await listSeasons({'isCurrentSeason': 'true'}).catchError((e) => e);

    if (result.isFailure) {
      EasyLoading.showError("Error al cargar temporada");
    }

    List<SeasonDto> list = result.getValue();

    if (list.isEmpty) {
      return;
    }
    setState(() {
      currentSeason = list[0];
    });
  }

  getPlayerStats() async {
    Result<dynamic> result;
    if (selectedOptions[0]) {
      result = await getMyPlayerStats(last3: true).catchError((e) {
        EasyLoading.dismiss();
        EasyLoading.showError("Error al cargar perfil");
        return e;
      });
    } else if (selectedOptions[1]) {
      result = await getMyPlayerStats(season: currentSeason?.seasonId)
          .catchError((e) {
        EasyLoading.dismiss();
        EasyLoading.showError("Error al cargar perfil");
        return e;
      });
    } else {
      result = await getMyPlayerStats().catchError((e) {
        EasyLoading.dismiss();
        EasyLoading.showError("Error al cargar perfil");
        return e;
      });
    }

    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      stats = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 16)),
              ToggleButtons(
                isSelected: selectedOptions,
                selectedColor:
                    Theme.of(context).colorScheme.brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.primary,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < selectedOptions.length; i++) {
                      selectedOptions[i] = i == index;
                    }
                    getPlayerStats();
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                constraints: const BoxConstraints(minHeight: 30, minWidth: 100),
                children: const [
                  Text(
                    "Últimos 3",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Temporada",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Siempre",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8)),
              ToggleButtons(
                isSelected: selectViewOptions,
                selectedColor:
                    Theme.of(context).colorScheme.brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.primary,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < selectViewOptions.length; i++) {
                      selectViewOptions[i] = i == index;
                    }
                    setState(() {
                      if (selectViewOptions[0] == true) {
                        showMore = false;
                        return;
                      }
                      showMore = true;
                    });
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                constraints: const BoxConstraints(minHeight: 30, minWidth: 120),
                children: const [
                  Text(
                    "Barras",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tabla",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8)),
              if (showMore)
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Tabla",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: TabBar(
                        indicatorWeight: 4,
                        indicatorColor: Theme.of(context).colorScheme.tertiary,
                        controller: _tabController,
                        tabs: const [
                          Tab(text: "Servicio"),
                          Tab(text: "Devolución"),
                          Tab(text: "Pelota en juego"),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
        SliverFillRemaining(
          child: ListView(
            children: [
              if (showMore)
                // table
                Column(
                  children: [
                    SizedBox(
                      height: 560,
                      width: double.maxFinite,
                      child: ProfileTable(
                          stats: stats != null
                              ? stats!
                              : PlayerTrackerDto.empty()),
                    ),
                  ],
                )
              else
                // Graphics
                Column(
                  children: [
                    SizedBox(
                      height: 750,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ServiceCharts(
                              stats: stats != null
                                  ? stats!
                                  : PlayerTrackerDto.empty()),
                          ProfileReturnCharts(
                              stats: stats != null
                                  ? stats!
                                  : PlayerTrackerDto.empty()),
                          ProfileBallInGameCharts(
                              stats: stats != null
                                  ? stats!
                                  : PlayerTrackerDto.empty()),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }
}
