import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

class _TeamContainerState extends State<TeamContainer> {
  List<JourneyDto> journeys = [];
  List<SeasonDto> seasons = [];

  String? selectedSeason;
  String? selectedJourney;

  TeamStatsDto? stats;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: "Cargando...",
      dismissOnTap: true,
    );
    await getJourneys();
    await getSeasons();
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
    final result = await getTeamStats(
      selectedJourney!,
      selectedSeason!,
      widget.team.teamId,
    );

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Text(
                      "Categoria:",
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
          const Padding(padding: EdgeInsets.only(top: 32)),
          Container(
            margin: const EdgeInsets.only(right: 8, left: 8),
            child: Row(
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
                        .asMap()
                        .entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value.seasonId,
                            child: Text(e.value.name),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 4, right: 4)),
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
                        .asMap()
                        .entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value.name,
                            child: Text(e.value.name),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: stats != null
                ? Table(
                    border: const TableBorder(
                      horizontalInside:
                          BorderSide(width: .5, color: Colors.grey),
                      bottom: BorderSide(width: .5, color: Colors.grey),
                    ),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FixedColumnWidth(88),
                    },
                    children: <TableRow>[
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Games ganados de local",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.gamesWonAsLocal}/${stats?.gamesPlayedAsLocal}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Games ganados de visitante",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.gamesWonAsVisitor}/${stats?.gamesPlayedAsVisitor}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Games ganados en total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.totalGamesWon}/${stats?.totalGamesPlayed}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Sets ganados de local",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.setsWonAsLocal}/${stats?.setsPlayedAsLocal}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Sets ganados de visitante",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.setsWonAsVisitor}/${stats?.setsPlayedAsVisitor}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Sets ganados en total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.totalSetsWon}/${stats?.totalSetsPlayed}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Super Tie-Breaks ganados de local",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.superTieBreaksWonAsLocal}/${stats?.superTieBreaksPlayedAsLocal}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Super Tie-Breaks ganados de visitante",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.superTieBreaksWonAsVisitor}/${stats?.superTieBreaksPlayedAsVisitor}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Super Tie-Breaks ganados en total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.totalSuperTieBreaksWon}/${stats?.totalSuperTieBreaksPlayed}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Partidos ganados de local",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.matchWonAsLocal}/${stats?.matchPlayedAsLocal}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Partidos ganados de visitante",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.matchWonAsVisitor}/${stats?.matchPlayedAsVisitor}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Partidos ganados en total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.totalMatchWon}/${stats?.totalMatchPlayed}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Partidos ganados ganando el primer set de local",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.matchsWonWithFirstSetWonAsLocal}/${stats?.matchsPlayedWithFirstSetWonAsLocal}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Partidos ganados ganando el primer set de visitante",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.matchsWonWithFirstSetWonAsVisitor}/${stats?.matchsPlayedWithFirstSetWonAsVisitor}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Total partidos ganados ganando el primer set",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.totalMatchsWonWithFirstSetWon}/${stats?.totalMatchsPlayedWithFirstSetWon}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Encuentros ganados de local",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.clashWonAsLocal}/${stats?.clashPlayedAsLocal}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Encuentros ganados de visitante",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.clashWonAsVisitor}/${stats?.clashPlayedAsVisitor}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "Encuentros ganados en total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 50,
                              child: Text(
                                "${stats?.totalClashWon}/${stats?.totalClashPlayed}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      "Busca estadisticas de una jornada",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
