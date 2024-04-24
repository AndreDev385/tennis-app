import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/news/carousel.dart';
import 'package:tennis_app/components/cta/teams/ranking_card.dart';
import 'package:tennis_app/components/cta/teams/team_card.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/ranking_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/get_current_season.dart';
import 'package:tennis_app/services/team/list_rankings.dart';
import 'package:tennis_app/services/team/list_teams.dart';
import 'package:tennis_app/utils/state_keys.dart';

class Teams extends StatefulWidget {
  const Teams({
    super.key,
    required this.categories,
    required this.ads,
    required this.clubId,
  });

  final List<CategoryDto> categories;
  final List<AdDto> ads;
  final String clubId;

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: '',
  };

  List<TeamDto> teams = [];
  List<String> teamNames = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"];
  List<TeamDto> filteredTeams = [];
  List<RankingDto> rankings = [];

  String? selectedTeam;
  String? selectedCategory;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await listTeamRankings();
    await listClubTeams();
    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  listClubTeams() async {
    final result = await listTeams(widget.clubId);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = "Error al cargar equipos";
      });
      return;
    }

    setState(() {
      teams = result.getValue();
      filteredTeams = result.getValue();
    });
  }

  listTeamRankings() async {
    final seasonResult = await getCurrentSeason().catchError((e) {
      EasyLoading.showError("Ha ocurrido un error");
      throw e;
    });

    if (seasonResult.isFailure) {
      return;
    }

    SeasonDto season = seasonResult.getValue();

    if (!season.isFinish) {
      return;
    }

    final rankingResult = await listRankings().catchError((e) {
      EasyLoading.showError("Ha ocurrido un error");
      throw e;
    });

    if (rankingResult.isFailure) {
      return;
    }

    setState(() {
      rankings = rankingResult.getValue();
    });
  }

  filterTeams() {
    var initialTeams = teams;
    if (selectedTeam != null) {
      initialTeams = initialTeams
          .where((element) => element.name == selectedTeam)
          .toList();
    }
    if (selectedCategory != null) {
      initialTeams = initialTeams
          .where((element) => element.category.name == selectedCategory)
          .toList();
    }
    setState(() {
      filteredTeams = initialTeams;
    });
  }

  @override
  Widget build(BuildContext context) {
    void showFiltersModal() {
      showDialog(
        context: context,
        builder: (context) {
          String? categoryValue;
          String? teamValue;
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text("Filtros"),
              content: SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton(
                      isExpanded: true,
                      items: widget.categories
                          .map((CategoryDto e) => DropdownMenuItem(
                                value: e.name,
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          categoryValue = value;
                          selectedCategory = value;
                        });
                      },
                      hint: const Text("Categoría"),
                      value: categoryValue,
                    ),
                    DropdownButton(
                      isExpanded: true,
                      items: teamNames
                          .map((String e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          teamValue = value;
                          selectedTeam = value;
                        });
                      },
                      hint: const Text("Equipo"),
                      value: teamValue,
                    ),
                  ],
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
                    Navigator.of(context).pop();
                    filterTeams();
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
        if (rankings.isNotEmpty)
          SliverToBoxAdapter(
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: false,
                viewportFraction: 0.5,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 800,
                ),
                height: 170,
              ),
              items: rankings.map((e) => RankingCard(ranking: e)).toList(),
            ),
          )
        else if (widget.ads.isNotEmpty)
          SliverToBoxAdapter(
            child: AdsCarousel(ads: widget.ads),
          ),
        if (state[StateKeys.loading])
          SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if ((state[StateKeys.error] as String).length > 0)
          SliverFillRemaining(
            child: Center(
              child: Text(
                state[StateKeys.error],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          )
        else if (filteredTeams.length == 0)
          SliverFillRemaining(
            child: Center(
              child: Text(
                "No hay equipos registrados",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          )
        else
          SliverFillRemaining(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4, bottom: 4),
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
                            selectedCategory = null;
                            selectedTeam = null;
                          });
                          filterTeams();
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
                ...filteredTeams.asMap().entries.map((entry) {
                  return TeamCard(
                    team: entry.value,
                  );
                }).toList(),
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                )
              ],
            ),
          )
      ],
    );
  }
}
