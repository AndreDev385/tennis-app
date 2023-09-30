import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/clash/clash_card.dart';
import 'package:tennis_app/components/cta/news/carousel.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/journey_dto.dart';
import 'package:tennis_app/dtos/season_dto.dart';
import 'package:tennis_app/services/list_journeys.dart';
import 'package:tennis_app/services/list_seasons.dart';
import 'package:tennis_app/services/paginate_clash.dart';

class ClashResults extends StatefulWidget {
  const ClashResults({
    super.key,
    required this.categories,
    required this.ads,
  });

  final List<CategoryDto> categories;
  final List<AdDto> ads;

  @override
  State<ClashResults> createState() => _ClashResultsState();
}

class _ClashResultsState extends State<ClashResults> {
  Map<String, dynamic> state = {
    'loading': true,
    'success:': false,
    'error': "",
    'final': false,
  };

  List<ClashDto> _clashes = [];
  //List<ClashDto> _filteredClashes = [];
  List<SeasonDto> _seasons = [];
  List<JourneyDto> _journeys = [];

  String? selectedCategory;
  String? selectedSeason;
  String? selectedJourney;

  ScrollController _scrollController = ScrollController();
  int page = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      setState(() {
        page++;
      });

      print(page);
      if (!state['final']) {
        _listClashResults();
      }
    }
  }

  _getData() async {
    await _listSeasons();
    await getJourneys();
    await _listClashResults();
  }

  _listClashResults({bool isFilter = false}) async {
    Map<String, dynamic> query = {
      'isFinish': 'true',
      'offset': page,
    };

    if (selectedCategory != null) {
      query['categoryId'] = selectedCategory;
    }

    if (selectedJourney != null) {
      query['journey'] = selectedJourney;
    }

    if (selectedSeason != null) {
      query['selectedSeason'] = selectedSeason;
    }

    setState(() {
      state['loading'] = true;
    });

    final result = await paginateClash(query);

    if (result.isFailure) {
      setState(() {
        state['loading'] = false;
        state['error'] = result.error!;
      });
      return;
    }

    setState(() {
      state['loading'] = false;
      state['success'] = true;
      if (result.getValue().clashes.isEmpty) {
        state['final'] = true;
      }
      if (isFilter) {
        _clashes = result.getValue().clashes;
      } else {
        _clashes.addAll(result.getValue().clashes);
      }
      count = result.getValue().count;
    });
  }

  _listSeasons() async {
    final result = await listSeasons({}).catchError((e) {
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
      return;
    }

    setState(() {
      _journeys = result.getValue();
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
                                value: e.categoryId,
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
                    setState(() {
                      page = 0;
                    });
                    _listClashResults(isFilter: true);
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
      slivers: [
        SliverToBoxAdapter(
          child:
              widget.ads.isNotEmpty ? AdsCarousel(ads: widget.ads) : Center(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
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
                    setState(() {
                      page = 0;
                    });
                    _listClashResults(isFilter: true);
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
        ),
        SliverFillRemaining(
          child: Builder(
            builder: (context) {
              if (_clashes.isEmpty && state['loading']) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: _clashes.length + 1,
                itemBuilder: (BuildContext context, int idx) {
                  if (idx < _clashes.length) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: ClashCard(clash: _clashes[idx]),
                    );
                  } else if (state['final']) {
                    return Container();
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}
