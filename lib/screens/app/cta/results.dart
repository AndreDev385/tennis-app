import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/clash/clash_card.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/journey_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/list_clash.dart';
import 'package:tennis_app/services/list_journeys.dart';
import 'package:tennis_app/services/list_seasons.dart';

class ClashResults extends StatefulWidget {
  const ClashResults({
    super.key,
    required this.categories,
  });

  final List<CategoryDto> categories;

  @override
  State<ClashResults> createState() => _ClashResultsState();
}

class _ClashResultsState extends State<ClashResults> {
  List<ClashDto> _clashes = [];
  List<ClashDto> _filteredClash = [];
  List<SeasonDto> _seasons = [];
  List<JourneyDto> _journeys = [];

  String? selectedCategory;
  String? selectedSeason;
  String? selectedJourney;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    EasyLoading.show(status: "Cargando...");
    await _listClashResults();
    await _listSeasons();
    await getJourneys();
    EasyLoading.dismiss();
  }

  _listClashResults() async {
    Map<String, String> query = {
      'isFinish': 'true',
    };

    final result = await listClash(query).catchError((e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error al cargar resultados");
      throw e;
    });

    if (result.isFailure) {
      EasyLoading.showError("Ha ocurrido un error");
      return;
    }

    setState(() {
      _clashes = result.getValue();
      _filteredClash = result.getValue();
    });
  }

  _listSeasons() async {
    final result = await listSeasons({}).catchError((e) {
      EasyLoading.showError("Ha ocurrido un error");
      throw e;
    });

    if (result.isFailure) {
      return;
    }

    setState(() {
      _seasons = result.getValue();
    });
  }

  getJourneys() async {
    final result = await listJourneys().catchError((e) {
      return e;
    });

    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      _journeys = result.getValue();
    });
  }

  filterResults() {
    var filteredClash = _clashes;

    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      filteredClash = filteredClash
          .where((ClashDto element) => element.categoryName == selectedCategory)
          .toList();
    }

    if (selectedJourney != null && selectedJourney!.isNotEmpty) {
      filteredClash = filteredClash
          .where((ClashDto element) => element.journey == selectedJourney)
          .toList();
    }

    if (selectedSeason != null && selectedSeason!.isNotEmpty) {
      filteredClash = filteredClash
          .where((ClashDto element) => element.seasonId == selectedSeason)
          .toList();
    }

    setState(() {
      _filteredClash = filteredClash;
    });
  }

  @override
  Widget build(BuildContext context) {
    void showFiltersModal() {
      showDialog(
        context: context,
        builder: (context) {
          String? categoryValue;
          String? journeyValue;
          String? seasonValue;
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
                      items: _journeys
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
                    ),
                    DropdownButton(
                      isExpanded: true,
                      items: _seasons
                          .map((SeasonDto e) => DropdownMenuItem(
                                value: e.seasonId,
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
                    filterResults();
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

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
                        selectedJourney = null;
                        selectedSeason = null;
                      });
                      filterResults();
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
            Column(
              children: _filteredClash
                  .map(
                    (entry) => ClashCard(clash: entry),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
