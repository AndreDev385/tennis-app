import 'package:flutter/material.dart';
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
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/state_keys.dart';

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
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: '',
    StateKeys.showMore: false,
  };

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
    await getJourneys();
    await getSeasons();
    await getStats();

    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  getJourneys() async {
    final result = await listJourneys();
    if (result.isFailure) {
      return;
    }

    setState(() {
      journeys = result.getValue();
    });
  }

  getSeasons() async {
    final result = await listSeasons({});

    if (result.isFailure) {
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
        setState(() {
          state[StateKeys.error] = 'Error al cargar datos del equipo';
        });
        return;
      }

      seasonId = list.first.seasonId;
    } else {
      seasonId = selectedSeason;
    }

    setState(() {
      state[StateKeys.loading] = true;
    });

    final result = await getTeamStats(
      selectedJourney,
      seasonId!,
      widget.team.teamId,
    );

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error!;
        state[StateKeys.loading] = false;
      });
      return;
    }

    setState(() {
      state[StateKeys.error] = '';
      state[StateKeys.loading] = false;
      stats = result.getValue();
    });
  }

  render() {
    if (state[StateKeys.loading]) {
      return Center(child: CircularProgressIndicator());
    } else {
      return TabBarView(
        children: [
          TeamTab(
            team: widget.team,
            getStats: getStats,
            journeys: journeys,
            seasons: seasons,
            stats: stats,
            error: state[StateKeys.error],
          ),
          PlayersTab(team: widget.team),
          CouplesTab(team: widget.team)
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: const AppBarTitle(
            title: "Detalle de equipo",
            icon: Icons.people,
          ),
          bottom: TabBar(
            labelColor: MyTheme.yellow,
            indicatorColor: MyTheme.yellow,
            tabs: [
              Tab(text: "Equipo"),
              Tab(text: "Jugadores"),
              Tab(text: "Parejas"),
            ],
          ),
        ),
        body: render(),
      ),
    );
  }
}
