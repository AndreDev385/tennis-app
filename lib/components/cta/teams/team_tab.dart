import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/teams/team_graphics.dart';
import 'package:tennis_app/components/cta/teams/team_table.dart';
import 'package:tennis_app/components/shared/category_colors.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/journey_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/dtos/team_stats.dto.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/state_keys.dart';

class TeamTab extends StatefulWidget {
  const TeamTab({
    super.key,
    required this.team,
    required this.seasons,
    required this.journeys,
    required this.stats,
    required this.getStats,
    this.error = "",
  });

  final List<SeasonDto> seasons;
  final List<JourneyDto> journeys;
  final TeamStatsDto? stats;
  final TeamDto team;
  final Function({
    String? selectedSeason,
    String? selectedJourney,
  }) getStats;

  final String error;

  @override
  State<TeamTab> createState() => _TeamTabState();
}

class _TeamTabState extends State<TeamTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> state = {
    StateKeys.loading: false,
    StateKeys.showMore: false,
    StateKeys.error: "",
  };

  String? selectedSeason;
  String? selectedJourney;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  renderView() {
    if (state[StateKeys.showMore]) {
      return TeamTable(
          stats: widget.stats != null ? widget.stats! : TeamStatsDto.empty());
    }
    return TeamGraphics(
        stats: widget.stats != null ? widget.stats! : TeamStatsDto.empty());
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
                        items: widget.seasons
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
                        items: widget.journeys
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
                      widget.getStats(
                        selectedJourney: selectedJourney,
                        selectedSeason: selectedSeason,
                      );
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

    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 8,
            ),
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
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Text(
                      widget.team.category.name,
                      style: TextStyle(
                        fontSize: 18,
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
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
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () => showFiltersModal(),
                        child: Text(
                          "Filtrar",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedJourney = null;
                            selectedSeason = null;
                          });
                          widget.getStats(
                            selectedJourney: selectedJourney,
                            selectedSeason: selectedSeason,
                          );
                        },
                        child: Text(
                          "Limpiar",
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorWeight: 4,
                  indicatorSize: TabBarIndicatorSize.tab,
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
        ),
        if (widget.error.isNotEmpty)
          SliverFillRemaining(
            child: Center(
              child: Text(
                widget.error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        else
          SliverFillRemaining(
            child: ListView(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top: 16, bottom: 24),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8, top: 8),
                    height: 1200,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TeamGraphics(
                            stats: widget.stats != null
                                ? widget.stats!
                                : TeamStatsDto.empty()),
                        Container(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          child: TeamTable(
                              stats: widget.stats != null
                                  ? widget.stats!
                                  : TeamStatsDto.empty()),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
