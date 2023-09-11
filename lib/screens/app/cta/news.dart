import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/news/carousel.dart';

import 'package:tennis_app/components/cta/news/new_card.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/news_dto.dart';
import 'package:tennis_app/services/list_ads.dart';
import 'package:tennis_app/services/list_news.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<NewDto> news = [];
  List<AdDto> ads = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    EasyLoading.show();
    getNews();
    getAds();
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

  getAds() async {
    final result = await listAds({}).catchError((e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error al cargar novedades");
      return e;
    });
    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      ads = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          if (ads.isNotEmpty)
            AdsCarousel(
              ads: ads,
            ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: news.map((dto) => NewCard(newDto: dto)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
