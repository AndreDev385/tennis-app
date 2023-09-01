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
      status: "Cargando...",
      dismissOnTap: true,
    );
    await getJourneys();
    await getSeasons();
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
    if (selectedSeason == null || selectedJourney == null) {
      return;
    }
    EasyLoading.show(status: "Cargando...");
    final result = await getTeamStats(
      selectedJourney!,
      selectedSeason!,
      widget.team.teamId,
    );

    if (result.isFailure) {
      EasyLoading.dismiss();
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      stats = result.getValue();
    });
    EasyLoading.dismiss();
  }

  renderView() {
    if (showTable) {
      return TeamTable(stats: stats!);
    }
    return TeamGraphics(stats: stats!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTitle(
          title: "Detalle de equipo",
          icon: Icons.people,
        ),
      ),
      body: loading
          ? const Center()
          : ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Categoría:",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 8)),
                          Text(
                            widget.team.category.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: colorByCategory[widget.team.category.name],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Equipo:",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 8)),
                          Text(
                            widget.team.name,
                            style: const TextStyle(
                              fontSize: 24,
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
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                labelText: "Jornada",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onChanged: (dynamic value) {
                                setState(() {
                                  selectedJourney = value;
                                });
                                getStats();
                              },
                              items: journeys
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.name,
                                      child: Text(e.name),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                labelText: "Temporada",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onChanged: (dynamic value) {
                                setState(() {
                                  selectedSeason = value;
                                });
                                getStats();
                              },
                              items: seasons
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.seasonId,
                                      child: Text(e.name),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top: 32),
                  child: stats != null
                      ? Column(
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
                                    labelColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    indicatorColor:
                                        Theme.of(context).colorScheme.tertiary,
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
                              padding: const EdgeInsets.only(bottom: 8, top: 8),
                              height: 1200,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  TeamGraphics(stats: stats!),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16),
                                    child: TeamTable(stats: stats!),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            "Busca estadísticas de una jornada",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
