import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tennis_app/components/cta/news/carousel.dart';

import 'package:tennis_app/components/cta/news/new_card.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/news_dto.dart';
import 'package:tennis_app/services/list_ads.dart';
import 'package:tennis_app/services/list_news.dart';
import 'package:url_launcher/url_launcher.dart';

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
    EasyLoading.show(status: "Cargando...");
    getNews();
    getAds();
    EasyLoading.dismiss();
  }

  getNews() async {
    final result = await listNews({});
    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    setState(() {
      news = result.getValue();
    });
  }

  getAds() async {
    final result = await listAds({});
    if (result.isFailure) {
      EasyLoading.showError(result.error!);
      return;
    }

    print("ads: ${result.getValue()}");

    setState(() {
      ads = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    buildModal(String link) {
      _lauchUrl() async {
        final Uri _url = Uri.parse(link);

        if (!await launchUrl(
          _url,
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch $_url');
        }
      }

      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Quieres visitar el link seleccionado?"),
              content: const Text("Seras redirigido a la pagina seleccionada"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      _lauchUrl();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Aceptar")),
              ],
            );
          });
    }

    return Column(
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
    );
  }
}
