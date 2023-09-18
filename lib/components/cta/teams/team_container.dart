import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/teams/team_graphics.dart';
import 'package:tennis_app/components/cta/teams/team_table.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';
import 'package:tennis_app/components/shared/category_colors.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/journey_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/dtos/team_stats.dto.dart';
import 'package:tennis_app/services/get_team_stats.dart';
import 'package:tennis_app/services/list_journeys.dart';
import 'package:tennis_app/services/list_seasons.dart';

class TeamContainer extends StatefulWidget {
  const TeamContainer({
    super.key,
    required this.team,
  });

  final TeamDto team;

  @override
  State<TeamContainer> createState() => _TeamContainerState();
}

class _TeamContainerState extends State<TeamContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final formKey = GlobalKey<FormState>();

  List<JourneyDto> journeys = [];
  List<SeasonDto> seasons = [];

  String? selectedSeason;
  String? selectedJourney;

  TeamStatsDto? stats;

  bool showTable = false;

  bool loading = true;

  @override
  void initState() {
    getData();
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  getData() async {
    EasyLoading.show(
      dismissOnTap: true,
    );
    await getJourneys();
    await getSeasons();
    await getStats();
    setState(() {
      loading = false;
    });
    EasyLoading.dismiss(animation: true);
  }

  getJourneys() async {
    final result = await listJourneys();
    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      journeys = result.getValue();
    });
  }

  getSeasons() async {
    final result = await listSeasons({});

    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      seasons = result.getValue();
    });
  }

  getStats() async {
    String? seasonId;
    if (selectedSeason == null && selectedJourney == null) {
      final list = seasons.where((element) => element.isCurrentSeason == true);

      if (list.isEmpty) {
        return;
      }

      seasonId = list.first.seasonId;
    } else {
      seasonId = selectedSeason;
    }

    print(seasonId);

    EasyLoading.show();
    final result = await getTeamStats(
      selectedJourney,
      seasonId!,
      widget.team.teamId,
    );

    if (result.isFailure) {
      EasyLoading.dismiss();
      return;
    }

    setState(() {
      stats = result.getValue();
    });
    EasyLoading.dismiss();
  }

  renderView() {
    if (showTable) {
      return TeamTable(stats: stats != null ? stats! : TeamStatsDto.empty());
    }
    return TeamGraphics(stats: stats != null ? stats! : TeamStatsDto.empty());
  }

  @override
  Widget build(BuildContext context) {
    void showFiltersModal() {
      showDialog(
        context: context,
        builder: (context) {
          String? seasonValue;
          String? journeyValue;
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text("Filtros"),
              content: SizedBox(
                height: 300,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButtonFormField(
                        isExpanded: true,
                        items: seasons
                            .map((SeasonDto e) => DropdownMenuItem(
                                  value: e.name,
                                  child: Text(e.name),
                                ))
                            .toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            seasonValue = value;
                            selectedSeason = value;
                          });
                        },
                        hint: const Text("Temporada"),
                        value: seasonValue,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Elige una temporada";
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField(
                        isExpanded: true,
                        items: journeys
                            .map((JourneyDto e) => DropdownMenuItem(
                                  value: e.name,
                                  child: Text(e.name),
                                ))
                            .toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            journeyValue = value;
                            selectedJourney = value;
                          });
                        },
                        hint: const Text("Jornada"),
                        value: journeyValue,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Elige una jornada";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      getStats();
                    }
                  },
                  child: Text(
                    "Filtrar",
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
        },
      );
    }

    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            centerTitle: true,
            title: const AppBarTitle(
              title: "Detalle de equipo",
              icon: Icons.people,
            ),
            bottom: TabBar(tabs: [
              Tab(text: "Equipo"),
              Tab(text: "Jugadores"),
            ]),
          ),
          body: TabBarView(
            children: [
              loading
                  ? const Center()
                  : ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Categoría:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 8)),
                                  Text(
                                    widget.team.category.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: colorByCategory[
                                          widget.team.category.name],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Equipo:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 8)),
                                  Text(
                                    widget.team.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Container(
                          margin: const EdgeInsets.only(right: 8, left: 8),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      onPressed: () => showFiltersModal(),
                                      child: Text(
                                        "Filtrar",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedJourney = null;
                                          selectedSeason = null;
                                        });
                                      },
                                      child: Text(
                                        "Limpiar",
                                        style: TextStyle(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    TabBar(
                                      controller: _tabController,
                                      indicatorWeight: 4,
                                      labelColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      indicatorColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      tabs: const [
                                        Tab(
                                          text: "Gráficas",
                                        ),
                                        Tab(text: "Tabla"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(bottom: 8, top: 8),
                                height: 1200,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    TeamGraphics(
                                        stats: stats != null
                                            ? stats!
                                            : TeamStatsDto.empty()),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          right: 16, left: 16),
                                      child: TeamTable(
                                          stats: stats != null
                                              ? stats!
                                              : TeamStatsDto.empty()),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              Center(
                child: Text("Jugadores"),
              )
            ],
          ),
        ));
  }
}
