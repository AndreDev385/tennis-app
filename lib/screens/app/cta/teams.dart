import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/teams/ranking_card.dart';
import 'package:tennis_app/components/cta/teams/team_card.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/ranking_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/get_current_season.dart';
import 'package:tennis_app/services/list_rankings.dart';
import 'package:tennis_app/services/list_teams.dart';

class Teams extends StatefulWidget {
  const Teams({
    super.key,
    required this.categories,
  });

  final List<CategoryDto> categories;

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
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
    EasyLoading.show(status: "Cargando...");
    await listClubTeams();
    await listTeamRankings();
    EasyLoading.dismiss();
  }

  listClubTeams() async {
    final result = await listTeams().catchError((e) {
      EasyLoading.showError("Error al cargar encuentros");
      return e;
    });

    if (result.isFailure) {
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
    });

    if (seasonResult.isFailure) {
      return;
    }

    SeasonDto season = seasonResult.getValue();

    if (!season.isFinish) {
      return;
    }

    final rankingResult = await listRankings().catchError((e) {
      print(e);
      EasyLoading.showError("Ha ocurrido un error");
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
          .where((element) => element.category.categoryId == selectedCategory)
          .toList();
    }
    setState(() {
      filteredTeams = initialTeams;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (rankings.isNotEmpty)
              CarouselSlider(
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
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      const Text("Filtrar"),
                    ],
                  ),
                  DropdownButton(
                    value: selectedCategory,
                    items: widget.categories
                        .map((CategoryDto e) => DropdownMenuItem(
                              value: e.categoryId,
                              child: Text(e.name),
                            ))
                        .toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectedCategory = value;
                      });
                      filterTeams();
                    },
                    hint: const Text("Categoría"),
                  ),
                  DropdownButton(
                    value: selectedTeam,
                    items: teamNames
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectedTeam = value;
                      });
                      filterTeams();
                    },
                    hint: const Text("Equipo"),
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
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: filteredTeams.asMap().entries.map((entry) {
                  return TeamCard(
                    team: entry.value,
                  );
                }).toList(),
              ),
            ),
          ],
        ));
  }
}
