import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/profile/ball_in_game_charts.dart';
import 'package:tennis_app/components/cta/profile/profile_table.dart';
import 'package:tennis_app/components/cta/profile/return_charts.dart';
import 'package:tennis_app/components/cta/profile/service_charts.dart';
import 'package:tennis_app/dtos/player_tracker_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/get_my_player_stats.dart';
import 'package:tennis_app/services/list_seasons.dart';
import 'package:tennis_app/services/utils.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  PlayerTrackerDto? stats;

  SeasonDto? currentSeason;

  List<bool> selectedOptions = [true, false, false];

  @override
  void initState() {
    getData();
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getData() async {
    EasyLoading.show(status: "Cargando...");
    getCurrentSeason();
    getPlayerStats();
    EasyLoading.dismiss();
  }

  getCurrentSeason() async {
    final result = await listSeasons({'isCurrentSeason': 'true'});

    if (result.isFailure) {
      EasyLoading.showError("Error al cargar temporada");
    }

    List<SeasonDto> list = result.getValue();

    if (list.isEmpty) {
      return;
    }
    setState(() {
      currentSeason = list[0];
    });
  }

  getPlayerStats() async {
    Result<dynamic> result;

    if (selectedOptions[0]) {
      result = await getMyPlayerStats(last3: true);
    } else if (selectedOptions[1]) {
      result = await getMyPlayerStats(season: currentSeason?.seasonId);
    } else {
      result = await getMyPlayerStats();
    }

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
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 16)),
          const Text(
            "Selecciona los partidos a tomar en cuenta",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          ToggleButtons(
            isSelected: selectedOptions,
            selectedColor:
                Theme.of(context).colorScheme.brightness == Brightness.dark
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.primary,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < selectedOptions.length; i++) {
                  selectedOptions[i] = i == index;
                }
                getPlayerStats();
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            constraints: const BoxConstraints(minHeight: 40, minWidth: 120),
            children: const [
              Text(
                "Ultimos 3",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Temporada",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Siempre",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              indicatorWeight: 4,
              indicatorColor: Theme.of(context).colorScheme.tertiary,
              controller: _tabController,
              tabs: const [
                Tab(text: "Servicio"),
                Tab(text: "Devolucion"),
                Tab(text: "Pelota en juego"),
              ],
            ),
          ),
          SizedBox(
            height: 560,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                stats == null ? const Center() : ServiceCharts(stats: stats!),
                stats == null
                    ? const Center()
                    : ProfileReturnCharts(stats: stats!),
                stats == null
                    ? const Center()
                    : ProfileBallInGameCharts(stats: stats!),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text("Mostrar mas"),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 16))
        ],
      ),
    );
  }
}
