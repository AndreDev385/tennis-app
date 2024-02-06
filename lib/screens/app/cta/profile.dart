import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_app/components/cta/profile/ball_in_game_charts.dart';
import 'package:tennis_app/components/cta/profile/profile_table.dart';
import 'package:tennis_app/components/cta/profile/return_charts.dart';
import 'package:tennis_app/components/cta/profile/service_charts.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/player/get_my_player_stats.dart';
import 'package:tennis_app/services/list_seasons.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/state_keys.dart';

enum MatchType { single, double }

class ProfileFilters {
  final bool isDouble;
  final String? seasonId;
  final int? limit;

  const ProfileFilters({
    this.isDouble = true,
    this.seasonId,
    this.limit,
  });
}

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late TabController _tabController;

  // component state
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.showMore: false,
    StateKeys.error: "",
  };
  List<SeasonDto> _seasons = [];

  // form state
  MatchType type = MatchType.double;
  String? selectedSeason;
  int? limit;

  // table
  List<bool> selectedOptions = [true, false, false, false];
  List<bool> selectViewOptions = [true, false];

  PlayerTrackerDto? stats;

  @override
  void initState() {
    super.initState();
    _getData();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _getData() async {
    await _getSeasons();
    await _getPlayerStats();
    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  _getSeasons() async {
    setState(() {
      state[StateKeys.loading] = true;
    });

    final result = await listSeasons({});

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error!;
        state[StateKeys.loading] = false;
      });
      return;
    }

    setState(() {
      state[StateKeys.loading] = false;
      _seasons = result.getValue();
    });
  }

  _getPlayerStats({
    Map<String, dynamic> query = const {"isDouble": true},
  }) async {
    setState(() {
      state[StateKeys.loading] = true;
    });

    final result = await getMyPlayerStats(query);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.loading] = false;
        state[StateKeys.error] = result.error!;
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
    handleFilter() {
      formKey.currentState!.save();

      Map<String, dynamic> query = {'isDouble': type == MatchType.double};

      if (selectedSeason != null) {
        query['season'] = selectedSeason;
      }

      if (limit != null) {
        query['limit'] = limit;
      }

      _getPlayerStats(query: query);

      Navigator.pop(context);
    }

    filtersModal() {
      return showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: const Text(
                  "Filtrar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Container(
                  padding: EdgeInsets.all(16),
                  width: 300,
                  height: 400,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            RadioListTile(
                              title: const Text("Single"),
                              value: MatchType.single,
                              groupValue: type,
                              onChanged: (MatchType? value) {
                                setState(() {
                                  type = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Double"),
                              value: MatchType.double,
                              groupValue: type,
                              onChanged: (MatchType? value) {
                                setState(() {
                                  type = value!;
                                });
                              },
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                labelText: "Temporada",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedSeason = value;
                                });
                              },
                              items: _seasons
                                  .map((s) => DropdownMenuItem(
                                        child: Text(s.name),
                                        value: s.seasonId,
                                      ))
                                  .toList(),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 16)),
                            TextFormField(
                              onSaved: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return;
                                }
                                limit = int.parse(value);
                              },
                              decoration: const InputDecoration(
                                labelText: "Cantidad de partidos",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancelar"),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4)),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () => handleFilter(),
                              child: Text(
                                "Filtrar",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }

    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Buscar",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    onPressed: () {
                      filtersModal();
                    },
                  ),
                  ElevatedButton(
                    child: Text("Limpiar"),
                    onPressed: () => _getPlayerStats(),
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
                constraints: const BoxConstraints(minHeight: 25, minWidth: 120),
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
                        labelColor: MyTheme.yellow,
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
