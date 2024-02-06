import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/feature_player_dto.dart';
import 'package:tennis_app/services/player/list_feature_players.dart';
import 'package:tennis_app/utils/calculate_percent.dart';
import 'package:tennis_app/utils/state_keys.dart';

import 'utils.dart';

class SortOptions {
  static String firstServIn = "1er servicio in";
  static String secondServIn = "2do servicio in";
  static String pointsWinnedFirstServ = "Puntos con el 1er servicio";
  static String pointsWinnedSecondServ = "Puntos con el 2do servicio";
  static String meshPointsWon = "Puntos en malla";
}

class PlayersTab extends StatefulWidget {
  const PlayersTab({
    super.key,
    required this.team,
  });

  final TeamDto team;

  @override
  State<PlayersTab> createState() => _PlayersTabState();
}

class _PlayersTabState extends State<PlayersTab> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.success: false,
    StateKeys.error: "",
  };

  List<FeaturePlayerDto> featurePlayers = [];
  String selectedOption = SortOptions.firstServIn;

  @override
  void initState() {
    super.initState();
    getData();
  }

  sortPlayers(String type) {
    setState(() {
      featurePlayers.sort(((a, b) {
        int aFirstValue = 0;
        int aSecondValue = 0;
        int bFirstValue = 0;
        int bSecondValue = 0;

        if (type == SortOptions.firstServIn) {
          aFirstValue = a.firstServIn;
          aSecondValue = a.firstServIn + a.secondServIn + a.dobleFaults;
          bFirstValue = b.firstServIn;
          bSecondValue = b.firstServIn + b.secondServIn + b.dobleFaults;
        }

        if (type == SortOptions.secondServIn) {
          aFirstValue = a.secondServIn;
          aSecondValue = a.secondServIn + a.dobleFaults;
          bFirstValue = b.secondServIn;
          bSecondValue = b.secondServIn + b.dobleFaults;
        }

        if (type == SortOptions.pointsWinnedFirstServ) {
          aFirstValue = a.pointsWinnedFirstServ;
          aSecondValue = a.firstServIn;
          bFirstValue = b.pointsWinnedFirstServ;
          bSecondValue = b.firstServIn;
        }

        if (type == SortOptions.pointsWinnedSecondServ) {
          aFirstValue = a.pointsWinnedSecondServe;
          aSecondValue = a.secondServIn;
          bFirstValue = b.pointsWinnedSecondServe;
          bSecondValue = b.secondServIn;
        }

        if (type == SortOptions.meshPointsWon) {
          aFirstValue = a.meshPointsWon;
          aSecondValue = a.meshPointsWon + a.meshPointsLost;
          bFirstValue = b.meshPointsWon;
          bSecondValue = b.meshPointsWon + b.meshPointsLost;
        }

        return calculatePercent(bFirstValue, bSecondValue) -
            calculatePercent(aFirstValue, aSecondValue);
      }));
    });
  }

  getData() async {
    setState(() {
      state[StateKeys.loading] = true;
    });
    final result = await listFeaturePlayers(teamId: widget.team.teamId);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error;
        state[StateKeys.loading] = false;
      });
      return;
    }

    setState(() {
      state[StateKeys.success] = true;
      state[StateKeys.error] = "";
      state[StateKeys.loading] = false;
      featurePlayers = result.getValue();
      sortPlayers(SortOptions.firstServIn);
    });
  }

  String showStat(FeaturePlayerDto player) {
    if (selectedOption == SortOptions.secondServIn) {
      return "${player.secondServIn}/${player.secondServIn + player.dobleFaults}(${calculatePercent(player.secondServIn, player.dobleFaults + player.secondServIn)}%)";
    }
    if (selectedOption == SortOptions.pointsWinnedFirstServ) {
      return "${player.pointsWinnedFirstServ}/${player.firstServIn}(${calculatePercent(player.pointsWinnedFirstServ, player.firstServIn)}%)";
    }
    if (selectedOption == SortOptions.pointsWinnedSecondServ) {
      return "${player.pointsWinnedSecondServe}/${player.secondServIn}(${calculatePercent(player.pointsWinnedSecondServe, player.secondServIn)}%)";
    }
    if (selectedOption == SortOptions.meshPointsWon) {
      return "${player.meshPointsWon}/${player.meshPointsWon + player.meshPointsLost}(${calculatePercent(player.meshPointsWon, player.meshPointsLost + player.meshPointsWon)}%)";
    }
    return "${player.firstServIn}/${player.firstServIn + player.secondServIn + player.dobleFaults}(${calculatePercent(player.firstServIn, player.firstServIn + player.secondServIn + player.dobleFaults)}%)";
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButtonFormField(
              icon: Icon(Icons.filter_alt),
              decoration: const InputDecoration(
                labelText: "Estadística",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              value: selectedOption,
              items: [
                DropdownMenuItem(
                    child: Text(SortOptions.firstServIn),
                    value: SortOptions.firstServIn),
                DropdownMenuItem(
                    child: Text(SortOptions.secondServIn),
                    value: SortOptions.secondServIn),
                DropdownMenuItem(
                    child: Text(SortOptions.pointsWinnedFirstServ),
                    value: SortOptions.pointsWinnedFirstServ),
                DropdownMenuItem(
                    child: Text(SortOptions.pointsWinnedSecondServ),
                    value: SortOptions.pointsWinnedSecondServ),
                DropdownMenuItem(
                    child: Text(SortOptions.meshPointsWon),
                    value: SortOptions.meshPointsWon),
              ],
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                });
                sortPlayers(value!);
              },
            ),
          ),
        ),
        if (state[StateKeys.loading])
          SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
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
        else if (featurePlayers.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Text(
                "No hay partidos registrados para la tabla de jugadores",
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
            child: Table(
              border: const TableBorder(
                horizontalInside: BorderSide(width: .5, color: Colors.grey),
                bottom: BorderSide(width: .5, color: Colors.grey),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(50),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: backgroundColor(0, context),
                  ),
                  children: [
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          "N.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Text(
                          "Jugador",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Text(
                          selectedOption,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...featurePlayers.asMap().entries.map(
                      (entry) => TableRow(
                        decoration: BoxDecoration(
                          color: backgroundColor(entry.key + 1, context),
                        ),
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: positionColor(entry.key + 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "${entry.key + 1}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${entry.value.firstName} ${entry.value.lastName}",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                showStat(entry.value),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
      ],
    );
  }
}
