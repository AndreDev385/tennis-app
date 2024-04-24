import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tennis_app/components/cta/profile/ball_in_game_charts.dart';
import 'package:tennis_app/components/cta/profile/profile_table.dart';
import 'package:tennis_app/components/cta/profile/return_charts.dart';
import 'package:tennis_app/components/cta/profile/service_charts.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/services/player/get_my_player_stats.dart';
import 'package:tennis_app/services/list_seasons.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/state_keys.dart';

import '../pdf_preview.dart';

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

  late TabController _externalCtrl;

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
  UserDto? user;

  @override
  void initState() {
    super.initState();
    _getData();
    _externalCtrl = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _externalCtrl.dispose();
    super.dispose();
  }

  _getData() async {
    await _getSeasons();
    await _getPlayerStats();
    await _getUser();
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

  _getUser() async {
    StorageHandler st = await createStorageHandler();
    String? userJson = st.getUser();
    if (userJson == null) {
      return;
    }

    final user = UserDto.fromJson(jsonDecode(userJson));

    setState(() {
      this.user = user;
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

  handleBuildPDF() async {
    if (stats != null) {
      final range = limit != null ? "$limit partidos" : "Todos los registros";

      goToPDFPreview(
        stats!,
        "${user!.firstName} ${user!.lastName}",
        range,
      );
    }
  }

  handleFilter() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> query = {'isDouble': type == MatchType.double};

      if (selectedSeason != null) {
        query['season'] = selectedSeason;
      }

      if (limit != null) {
        query['limit'] = limit;
      }

      _getPlayerStats(query: query);

      _externalCtrl.animateTo(0);
    }
  }

  resetFilters() {
    setState(() {
      limit = null;
      selectedSeason = null;
      type = MatchType.double;
    });
    //formKey.currentState!.save();

    Map<String, dynamic> query = {'isDouble': type == MatchType.double};

    _getPlayerStats(query: query);

    _externalCtrl.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: TabBar(
                labelColor: MyTheme.yellow,
                indicatorWeight: 4,
                indicatorColor: Theme.of(context).colorScheme.tertiary,
                controller: _externalCtrl,
                tabs: const [
                  Tab(
                    child: Text(
                      "Datos",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Filtros",
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
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _externalCtrl,
              children: [
                CustomScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(children: [
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              ToggleButtons(
                                isSelected: selectViewOptions,
                                selectedColor:
                                    Theme.of(context).colorScheme.brightness ==
                                            Brightness.dark
                                        ? Theme.of(context).colorScheme.tertiary
                                        : Theme.of(context).colorScheme.primary,
                                onPressed: (index) {
                                  setState(() {
                                    for (int i = 0;
                                        i < selectViewOptions.length;
                                        i++) {
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                constraints: const BoxConstraints(
                                    minHeight: 35, minWidth: 120),
                                children: const [
                                  Text(
                                    "Barras",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Tabla",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.download,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                onPressed: () => handleBuildPDF(),
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(bottom: 8)),
                          if (state[StateKeys.showMore])
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Tabla",
                                      style: TextStyle(
                                        color: MyTheme.yellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: TabBar(
                                    labelColor: MyTheme.yellow,
                                    indicatorWeight: 4,
                                    indicatorColor:
                                        Theme.of(context).colorScheme.tertiary,
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
                            ),
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
                      ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Form(
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
                                  value: selectedSeason,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.track_changes),
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
                                  initialValue: limit != null ? "$limit" : "",
                                  validator: (String? input) {
                                    if (input != null) {
                                      final value = int.parse(input);

                                      if (value < 1) {
                                        return "Ingresa un valor mayor a 0";
                                      }
                                    }

                                    return null;
                                  },
                                  onSaved: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return;
                                    }
                                    limit = int.parse(value);
                                  },
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.numbers),
                                    hintText: "Ejemplo: 4",
                                    labelText: "Últimos # partidos",
                                    helperText:
                                        "Por defecto se toman en cuenta todos los partidos",
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  onPressed: () => resetFilters(),
                                  child: Text(
                                    "Limpiar",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  onPressed: () => handleFilter(),
                                  child: Text(
                                    "Filtrar",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
