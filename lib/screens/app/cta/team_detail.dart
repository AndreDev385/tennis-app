import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/teams/couples_tab.dart';
import 'package:tennis_app/components/cta/teams/players_tab.dart';
import 'package:tennis_app/components/cta/teams/team_tab.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/journey_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/dtos/team_stats.dto.dart';
import 'package:tennis_app/services/get_team_stats.dart';
import 'package:tennis_app/services/list_journeys.dart';
import 'package:tennis_app/services/list_seasons.dart';

class TeamDetail extends StatefulWidget {
  const TeamDetail({
    super.key,
    required this.team,
  });

  final TeamDto team;
  static const route = 'cta/team-detail';

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  List<JourneyDto> journeys = [];
  List<SeasonDto> seasons = [];

  String? selectedSeason;
  String? selectedJourney;

  TeamStatsDto? stats;

  bool loading = true;
  bool showTable = false;

  @override
  void initState() {
    getData();
    super.initState();
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

  getStats({
    String? selectedSeason,
    String? selectedJourney,
  }) async {
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

    print("Result: ${result.getValue()}");

    setState(() {
      stats = result.getValue();
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    print("$stats");
    return DefaultTabController(
      length: 3,
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
            Tab(text: "Parejas"),
          ]),
        ),
        body: TabBarView(
          children: [
            loading
                ? Center()
                : TeamTab(
                    team: widget.team,
                    getStats: getStats,
                    journeys: journeys,
                    seasons: seasons,
                    stats: stats,
                  ),
            PlayersTab(team: widget.team),
            CouplesTab(team: widget.team)
          ],
        ),
      ),
    );
  }
}
