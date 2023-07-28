import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    _tabController = TabController(vsync: this, length: 2);
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

    print("${result.getValue()}: RESULT");

    setState(() {
      stats = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalServDone = 0;

    if (stats != null) {
      totalServDone =
          stats!.firstServIn + stats!.secondServIn + stats!.dobleFaults;
    }

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
                Tab(text: "Graficas"),
                Tab(text: "Tabla"),
              ],
            ),
          ),
          SizedBox(
            height: 600,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [],
                ),
                ListView(
                  scrollDirection: Axis.vertical,
                  children: stats == null
                      ? []
                      : [
                          Column(
                            children: [
                              Container(
                                color: Theme.of(context).colorScheme.primary,
                                height: 40,
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Servicio",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Table(
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
                                            child: const Text(
                                              "Aces",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.aces}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Doble falta",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.dobleFaults}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "1er servicio in",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.firstServIn}/$totalServDone",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Puntos ganados con el 1er servicio",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.pointsWinnedFirstServ}/${stats!.firstServIn}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Puntos ganados con el 2do servicio",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.pointsWinnedSecondServ}/${stats!.secondServIn}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Break points salvados",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.breakPtsSaved}/${stats?.saveBreakPtsChances}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Games ganados con el servicio",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Theme.of(context).colorScheme.primary,
                                height: 40,
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Devolucion",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Table(
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
                                            child: const Text(
                                              "1era devolucion in",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.firstReturnIn}/${stats!.pointsWonReturning + stats!.pointsLostReturning}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "2da devolucion in",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.secondReturnIn}/${stats!.pointsWonReturning + stats!.pointsLostReturning}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Puntos ganados con la 1era devolucion",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.pointsWinnedFirstReturn}/${stats?.firstReturnIn}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Puntos ganados con la 2da devolucion",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.pointsWinnedSecondReturn}/${stats?.secondReturnIn}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Theme.of(context).colorScheme.primary,
                                height: 40,
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Pelota en juego",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Table(
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
                                            child: const Text(
                                              "Puntos ganados en malla",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.meshPointsWon}/${stats!.meshPointsWon + stats!.meshPointsLost}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Puntos ganados en fondo/approach",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.bckgPointsWon}/${stats!.bckgPointsWon + stats!.bckgPointsLost}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "winners",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.winners}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Errores no forzados",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.noForcedErrors}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Theme.of(context).colorScheme.primary,
                                height: 40,
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Puntos",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Table(
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
                                            child: const Text(
                                              "Puntos ganados con el servicio",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.pointsWonServing}/${stats!.pointsWonServing + stats!.pointsLostServing}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Puntos ganados con la devolucion",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.pointsWonReturning}/${stats!.pointsWonReturning + stats!.pointsLostReturning}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Total puntos ganados",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.pointsWon}/${stats!.pointsWon + stats!.pointsLost}",
                                              textAlign: TextAlign.center,
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
                                            child: const Text(
                                              "Errores no forzados",
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 50,
                                            child: Text(
                                              "${stats?.noForcedErrors}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
