import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/news/carousel.dart';

import 'package:tennis_app/components/cta/news/new_card.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/news_dto.dart';
import 'package:tennis_app/services/list_news.dart';
import 'package:tennis_app/utils/state_keys.dart';

class News extends StatefulWidget {
  const News({
    super.key,
    required this.ads,
    this.adsError = false,
  });

  final List<AdDto> ads;
  final bool adsError;

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };

  List<NewDto> news = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await getNews();
    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  getNews() async {
    final result = await listNews({});

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = "No ha sido posible cargar las novedades";
      });
      return;
    }

    setState(() {
      news = result.getValue();
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
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        else if (news.length == 0)
          SliverFillRemaining(
            child: Center(
              child: Text(
                "No hay novedades actualmente",
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
            child: ListView(children: [
              ...news.map((dto) => NewCard(newDto: dto)).toList(),
              Padding(padding: EdgeInsets.only(bottom: 30))
            ]),
          )
      ],
    );
  }
}
