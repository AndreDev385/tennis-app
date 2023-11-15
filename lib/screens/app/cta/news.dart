import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/news/carousel.dart';

import 'package:tennis_app/components/cta/news/new_card.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/news_dto.dart';
import 'package:tennis_app/services/list_news.dart';

class News extends StatefulWidget {
  const News({
    super.key,
    required this.ads,
  });

  final List<AdDto> ads;

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<NewDto> news = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    EasyLoading.show();
    getNews();
    EasyLoading.dismiss();
  }

  getNews() async {
    final result = await listNews({}).catchError((e) {
      EasyLoading.dismiss();
      EasyLoading.showError("");
      return e;
    });
    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      news = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.ads.isNotEmpty)
            AdsCarousel(
              ads: widget.ads,
            ),
          Container(
            margin: EdgeInsets.all(16),
            child: Column(children: [
              ...news.map((dto) => NewCard(newDto: dto)).toList(),
            ]),
          )
        ],
      ),
    );
  }
}
