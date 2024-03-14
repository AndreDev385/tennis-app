import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/feature_couple_dto.dart';
import 'package:tennis_app/services/player/list_feature_couples.dart';
import 'package:tennis_app/utils/calculate_percent.dart';
import 'package:tennis_app/utils/state_keys.dart';

import 'utils.dart';

class SortOptions {
  //service
  static String firstServIn = "1er servicio in";
  static String secondServIn = "2do servicio in";
  static String firstServWon = "1er saque ganador";
  static String secondServWon = "2do saque ganador";
  static String pointsWinnedFirstServ = "Puntos con el 1er servicio";
  static String pointsWinnedSecondServ = "Puntos con el 2do servicio";
  static String aces = "aces";
  static String dobleFaults = "dobleFaults";
  // return
  static String breakPts = "Break points";
  static String firstReturnIn = "1era devolución in";
  static String secondReturnIn = "2da devolución in";
  static String firstReturnWon = "1era devolución ganadora";
  static String secondReturnWon = "2da devolución ganadora";
  static String firstReturnWinner = "Winner 1era devolución";
  static String secondReturnWinner = "Winner 2da devolución";
  static String pointsWinnedFirstReturn = "Puntos ganados 1era devolución";
  static String pointsWinnedSecondReturn = "Puntos ganados 2da devolución";
  // ball in game
  static String bckgPointsWon = "Puntos ganados en fondo/approach";
  static String bckgWinners = "Winners en fondo/approach";
  static String bckgErrors = "Errores en fondo/approach";
  static String meshPointsWon = "Puntos ganados en malla";
  static String meshWinners = "Winners en malla";
  static String meshErrors = "Errores en malla";
  static String totalWinners = "Total winners";
  static String totalErrors = "Total errores";
}

final notTotalOptions = [
  SortOptions.firstServWon,
  SortOptions.secondServWon,
  SortOptions.aces,
  SortOptions.dobleFaults,
  SortOptions.firstReturnWon,
  SortOptions.secondReturnWon,
  SortOptions.firstReturnWinner,
  SortOptions.secondReturnWinner,
  SortOptions.meshErrors,
  SortOptions.meshWinners,
  SortOptions.bckgErrors,
  SortOptions.bckgWinners,
  SortOptions.totalErrors,
  SortOptions.totalWinners,
];

class CouplesTab extends StatefulWidget {
  const CouplesTab({
    super.key,
    required this.team,
  });

  final TeamDto team;

  @override
  State<CouplesTab> createState() => _CouplesTabState();
}

class _CouplesTabState extends State<CouplesTab> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.success: false,
    StateKeys.error: "",
  };

  List<FeatureCoupleDto> featureCouples = [];
  String selectedOption = SortOptions.firstServIn;
  String? selectedJourney;
  String? selectedSeason;

  @override
  void initState() {
    super.initState();
    getData();
  }

  sortPlayers(String type) {
    setState(() {
      featureCouples.sort(((a, b) {
        int aFirstValue = 0;
        int aSecondValue = 0;
        int bFirstValue = 0;
        int bSecondValue = 0;

        /* Service Optiosn */
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

        if (type == SortOptions.firstServWon) {
          aFirstValue = a.firstServWon;
          bFirstValue = b.firstServWon;
        }

        if (type == SortOptions.secondServWon) {
          aFirstValue = a.secondServWon;
          bFirstValue = b.secondServWon;
        }

        if (type == SortOptions.pointsWinnedFirstServ) {
          aFirstValue = a.pointsWinnedFirstServ;
          aSecondValue = a.firstServIn;
          bFirstValue = b.pointsWinnedFirstServ;
          bSecondValue = b.firstServIn;
        }

        if (type == SortOptions.pointsWinnedSecondServ) {
          aFirstValue = a.pointsWinnedSecondServ;
          aSecondValue = a.secondServIn;
          bFirstValue = b.pointsWinnedSecondServ;
          bSecondValue = b.secondServIn;
        }

        if (type == SortOptions.aces) {
          aFirstValue = a.aces;
          bFirstValue = b.aces;
        }

        if (type == SortOptions.dobleFaults) {
          aFirstValue = b.dobleFaults;
          bFirstValue = a.dobleFaults;
        }
        /* End Service Options */

        /* Return Options */
        if (type == SortOptions.firstReturnIn) {
          aFirstValue = a.firstReturnIn;
          aSecondValue = a.firstReturnIn + a.firstReturnOut;
          bFirstValue = b.firstReturnIn;
          bSecondValue = b.firstReturnIn + b.firstReturnOut;
        }
        if (type == SortOptions.secondReturnIn) {
          aFirstValue = a.secondReturnIn;
          aSecondValue = a.secondReturnIn + a.secondReturnOut;
          bFirstValue = b.secondReturnIn;
          bSecondValue = b.secondReturnIn + b.secondReturnOut;
        }
        if (type == SortOptions.firstReturnWon) {
          aFirstValue = a.firstReturnWon;
          bFirstValue = b.firstReturnWon;
        }
        if (type == SortOptions.secondReturnWon) {
          aFirstValue = a.secondReturnWon;
          bFirstValue = b.secondReturnWon;
        }
        if (type == SortOptions.firstReturnWinner) {
          aFirstValue = a.firstReturnWinner;
          bFirstValue = b.firstReturnWinner;
        }
        if (type == SortOptions.secondReturnWinner) {
          aFirstValue = a.secondReturnWinner;
          bFirstValue = b.secondReturnWinner;
        }
        if (type == SortOptions.pointsWinnedFirstReturn) {
          aFirstValue = a.pointsWinnedFirstReturn;
          aSecondValue = a.firstReturnIn;
          bFirstValue = b.pointsWinnedFirstReturn;
          bSecondValue = b.firstReturnIn;
        }
        if (type == SortOptions.pointsWinnedSecondReturn) {
          aFirstValue = a.pointsWinnedSecondReturn;
          aSecondValue = a.secondReturnIn;
          bFirstValue = b.pointsWinnedSecondReturn;
          bSecondValue = b.secondReturnIn;
        }
        /* Return Options */

        /* Ball in game Options */

        if (type == SortOptions.bckgPointsWon) {
          aFirstValue = a.bckgPointsWon;
          aSecondValue = a.bckgPointsWon + a.bckgPointsLost;
          bFirstValue = b.bckgPointsWon;
          bSecondValue = b.bckgPointsWon + b.bckgPointsLost;
        }
        if (type == SortOptions.bckgWinners) {
          aFirstValue = a.bckgWinner;
          bFirstValue = b.bckgWinner;
        }
        if (type == SortOptions.bckgErrors) {
          // reverse for errors
          aFirstValue = b.bckgError;
          bFirstValue = a.bckgError;
        }
        if (type == SortOptions.meshPointsWon) {
          aFirstValue = a.meshPointsWon;
          aSecondValue = a.meshPointsWon + a.meshPointsLost;
          bFirstValue = b.meshPointsWon;
          bSecondValue = b.meshPointsWon + b.meshPointsLost;
        }
        if (type == SortOptions.meshWinners) {
          aFirstValue = a.meshWinner;
          bFirstValue = b.meshWinner;
        }
        if (type == SortOptions.meshErrors) {
          aFirstValue = b.meshError;
          bFirstValue = a.meshError;
        }
        if (type == SortOptions.totalWinners) {
          aFirstValue = a.aces +
              a.meshWinner +
              a.bckgWinner +
              a.firstReturnWinner +
              a.secondReturnWinner;
          bFirstValue = b.aces +
              b.meshWinner +
              b.bckgWinner +
              a.firstReturnWinner +
              b.secondReturnWinner;
        }
        if (type == SortOptions.totalErrors) {
          aFirstValue = b.dobleFaults + b.meshError + b.bckgError;
          bFirstValue = a.dobleFaults + a.meshError + a.bckgError;
        }
        /* End Ball in game Options */
        final isSimpleType = notTotalOptions.indexOf(type) >= 0;

        if (isSimpleType) {
          return bFirstValue - aFirstValue;
        }

        return calculatePercent(bFirstValue, bSecondValue) -
            calculatePercent(aFirstValue, aSecondValue);
      }));
    });
  }

  getData() async {
    setState(() {
      state['loading'] = true;
    });
    final result = await listFeatureCouples(teamId: widget.team.teamId);

    if (result.isFailure) {
      EasyLoading.showError("error");
      setState(() {
        state['loading'] = false;
        state['error'] = result.error;
      });
      return;
    }

    setState(() {
      state['success'] = true;
      state['loading'] = false;
      featureCouples = result.getValue();
      sortPlayers(SortOptions.firstServIn);
    });
  }

  String showStat(FeatureCoupleDto player) {
    // service
    if (selectedOption == SortOptions.secondServIn) {
      return "${player.secondServIn}/${player.secondServIn + player.dobleFaults}(${calculatePercent(player.secondServIn, player.dobleFaults + player.secondServIn)}%)";
    }
    if (selectedOption == SortOptions.firstServWon) {
      return "${player.firstServWon}";
    }
    if (selectedOption == SortOptions.secondServWon) {
      return "${player.secondServWon}";
    }
    if (selectedOption == SortOptions.pointsWinnedFirstServ) {
      return "${player.pointsWinnedFirstServ}/${player.firstServIn}(${calculatePercent(player.pointsWinnedFirstServ, player.firstServIn)}%)";
    }
    if (selectedOption == SortOptions.pointsWinnedSecondServ) {
      return "${player.pointsWinnedSecondServ}/${player.secondServIn}(${calculatePercent(player.pointsWinnedSecondServ, player.secondServIn)}%)";
    }
    if (selectedOption == SortOptions.aces) {
      return "${player.aces}";
    }
    if (selectedOption == SortOptions.dobleFaults) {
      return "${player.dobleFaults}";
    }
    // return
    if (selectedOption == SortOptions.firstReturnIn) {
      return "${player.firstReturnIn}/${player.firstReturnIn + player.firstReturnOut}(${calculatePercent(player.firstReturnIn, player.firstReturnIn + player.firstReturnOut)}%)";
    }
    if (selectedOption == SortOptions.secondReturnIn) {
      return "${player.secondReturnIn}/${player.secondReturnIn + player.secondReturnOut}(${calculatePercent(player.secondReturnIn, player.secondReturnIn + player.secondReturnOut)}%)";
    }
    if (selectedOption == SortOptions.firstReturnWon) {
      return "${player.firstReturnWon}";
    }
    if (selectedOption == SortOptions.secondReturnWon) {
      return "${player.secondReturnWon}";
    }
    if (selectedOption == SortOptions.firstReturnWinner) {
      return "${player.firstReturnWinner}";
    }
    if (selectedOption == SortOptions.secondReturnWinner) {
      return "${player.secondReturnWinner}";
    }
    if (selectedOption == SortOptions.pointsWinnedFirstReturn) {
      return "${player.pointsWinnedFirstReturn}/${player.firstReturnIn}(${calculatePercent(player.pointsWinnedFirstReturn, player.firstReturnIn)}%)";
    }
    if (selectedOption == SortOptions.pointsWinnedSecondReturn) {
      return "${player.pointsWinnedSecondReturn}/${player.secondReturnIn}(${calculatePercent(player.pointsWinnedSecondReturn, player.secondReturnIn)}%)";
    }
    // ball in game
    if (selectedOption == SortOptions.bckgPointsWon) {
      return "${player.bckgPointsWon}/${player.bckgPointsWon + player.bckgPointsLost}(${calculatePercent(player.bckgPointsWon, player.bckgPointsWon + player.bckgPointsLost)}%)";
    }
    if (selectedOption == SortOptions.bckgWinners) {
      return "${player.bckgWinner}";
    }
    if (selectedOption == SortOptions.bckgErrors) {
      return "${player.bckgError}";
    }
    if (selectedOption == SortOptions.meshPointsWon) {
      return "${player.meshPointsWon}/${player.meshPointsWon + player.meshPointsLost}(${calculatePercent(player.meshPointsWon, player.meshPointsLost + player.meshPointsWon)}%)";
    }
    if (selectedOption == SortOptions.meshWinners) {
      return "${player.meshWinner}";
    }
    if (selectedOption == SortOptions.meshErrors) {
      return "${player.meshError}";
    }
    if (selectedOption == SortOptions.totalWinners) {
      return "${player.firstReturnWinner + player.secondReturnWinner + player.aces + player.meshWinner + player.bckgWinner}";
    }
    if (selectedOption == SortOptions.totalErrors) {
      return "${player.dobleFaults + player.meshError + player.bckgError}";
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
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    icon: Icon(Icons.filter_alt),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    isExpanded: true,
                    value: selectedOption,
                    items: [
                      // service
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.firstServIn,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.firstServIn),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.secondServIn,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.secondServIn),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.firstServWon,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.firstServWon),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.secondServWon,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.secondServWon),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.pointsWinnedFirstServ,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.pointsWinnedFirstServ),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.pointsWinnedSecondServ,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.pointsWinnedSecondServ),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.aces,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.aces),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.dobleFaults,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.dobleFaults),
                      // return
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.firstReturnIn,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.firstReturnIn),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.secondReturnIn,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.secondReturnIn),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.firstReturnWon,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.firstReturnWon),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.secondReturnWon,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.secondReturnWon),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.firstReturnWinner,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.firstReturnWinner),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.secondReturnWinner,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.secondReturnWinner),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.pointsWinnedFirstReturn,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.pointsWinnedFirstReturn),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.pointsWinnedSecondReturn,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.pointsWinnedSecondReturn),
                      // ball in game
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.bckgPointsWon,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.bckgPointsWon),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.bckgWinners,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.bckgWinners),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.bckgErrors,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.bckgErrors),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.meshPointsWon,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.meshPointsWon),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.meshWinners,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.meshWinners),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.meshErrors,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.meshErrors),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.totalWinners,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.totalWinners),
                      DropdownMenuItem(
                          child: Text(
                            SortOptions.totalErrors,
                            overflow: TextOverflow.ellipsis,
                          ),
                          value: SortOptions.totalErrors),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                      sortPlayers(value!);
                    },
                  ),
                ),
              ],
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
        else if (featureCouples.isEmpty)
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
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
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
                          "Pareja",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
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
                ...featureCouples.asMap().entries.map(
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
                                "${entry.value.player.firstName[0]}. ${entry.value.player.lastName}/${entry.value.partner.firstName[0]}. ${entry.value.partner.lastName}",
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
                              alignment: Alignment.center,
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
