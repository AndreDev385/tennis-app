import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/profile/ball_in_game_charts.dart';
import 'package:tennis_app/components/cta/profile/profile_table.dart';
import 'package:tennis_app/components/cta/profile/return_charts.dart';
import 'package:tennis_app/components/cta/profile/service_charts.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/get_my_player_stats.dart';
import 'package:tennis_app/services/list_seasons.dart';
import 'package:tennis_app/utils/state_keys.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.showMore: false,
    StateKeys.error: "",
  };

  PlayerTrackerDto? stats;

  SeasonDto? currentSeason;

  List<bool> selectedOptions = [true, false, false, false];
  List<bool> selectViewOptions = [true, false];

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
      state[StateKeys.showMore] = !state[StateKeys.showMore];
    });
  }

  getData() async {
    await getCurrentSeason();
    await getPlayerStats();
    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  getCurrentSeason() async {
    final result = await listSeasons({'isCurrentSeason': 'true'});

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error!;
      });
      return;
    }

    List<SeasonDto> list = result.getValue();

    if (list.isEmpty) {
      setState(() {
        state[StateKeys.error] = "Error al cargar temporada actual";
      });
      return;
    }

    setState(() {
      currentSeason = list[0];
    });
  }

  getPlayerStats() async {
    setState(() {
      state[StateKeys.loading] = true;
    });
    Map<String, dynamic> query = {};
    if (selectedOptions[0]) {
      query["last"] = true;
    }

    if (selectedOptions[1]) {
      query["last3"] = true;
    }

    if (selectedOptions[2]) {
      query["season"] = currentSeason?.seasonId;
    }

    final result = await getMyPlayerStats(query);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.loading] = false;
        state[StateKeys.error] = "Error al cargar estadísticas";
      });
      return;
    }

    setState(() {
      state[StateKeys.loading] = false;
      state[StateKeys.error] = '';
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
                constraints: const BoxConstraints(minHeight: 30, minWidth: 75),
                children: const [
                  Text(
                    "Último",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Últimos 3",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Temporada",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Siempre",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
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
                        state[StateKeys.showMore] = false;
                        return;
                      }
                      state[StateKeys.showMore] = true;
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
              if (state[StateKeys.showMore])
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
                          Tab(
                            child: Text(
                              "Servicio",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Devolución",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Pelota en juego",
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
        if (state[StateKeys.loading])
          SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          )
        else if ((state[StateKeys.error] as String).length > 0)
          SliverFillRemaining(
            child: Center(
              child: Text(
                state[StateKeys.error],
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
              children: [
                if (state[StateKeys.showMore])
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
