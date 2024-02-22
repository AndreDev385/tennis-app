import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/clash/clash_card.dart';
import 'package:tennis_app/components/cta/news/carousel.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/clash/list_clash.dart';
import 'package:tennis_app/utils/state_keys.dart';

class Live extends StatefulWidget {
  const Live({
    super.key,
    required this.categories,
    required this.ads,
    required this.clubId,
    this.adsError = false,
  });

  final List<CategoryDto> categories;
  final List<AdDto> ads;
  final bool adsError;
  final String clubId;

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };

  List<ClashDto> _clashs = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    await _listClashResults();
    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  _listClashResults() async {
    Map<String, String> query = {
      'isFinish': 'false',
      'clubId': widget.clubId,
    };

    final result = await listClash(query);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error!;
      });
      return;
    }

    setState(() {
      _clashs = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        if (!state[StateKeys.loading])
          if (widget.adsError)
            SliverToBoxAdapter(
              child: Container(
                height: 60,
                child: Center(
                  child: Text(
                    "Error al cargar las ads",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          else if (widget.ads.length > 0)
            SliverToBoxAdapter(
              child: AdsCarousel(
                ads: widget.ads,
              ),
            ),
        if (state[StateKeys.loading])
          SliverFillRemaining(
              child: Center(
            child: CircularProgressIndicator(),
          ))
        else if ((state[StateKeys.error] as String).length > 0)
          SliverFillRemaining(
            child: Center(
              child: Text(
                state[StateKeys.error],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        else
          SliverFillRemaining(
            child: _clashs.length > 0
                ? ListView(
                    children: _clashs
                        .map(
                          (entry) => Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: ClashCard(clash: entry, loadOnClick: false),
                          ),
                        )
                        .toList(),
                  )
                : Center(
                    child: Text(
                      "No hay partidos en vivo actualmente",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
          ),
      ],
    );
  }
}
