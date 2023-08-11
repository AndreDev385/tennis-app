import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsCarousel extends StatelessWidget {
  const AdsCarousel({
    super.key,
    required this.ads,
  });

  final List<AdDto> ads;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: false,
        autoPlay: true,
        viewportFraction: 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: false,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: ads
          .map((e) => Ad(
                ad: e,
              ))
          .toList(),
    );
  }
}

class Ad extends StatelessWidget {
  const Ad({
    super.key,
    required this.ad,
  });

  final AdDto ad;

  @override
  Widget build(BuildContext context) {
    buildModal(String link) {
      launch() async {
        final Uri url = Uri.parse(link);

        if (!await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch $url');
        }
      }

      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Quieres visitar el link seleccionado?"),
              content: const Text("Seras redirigido a la pagina"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      launch();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Aceptar")),
              ],
            );
          });
    }

    return InkWell(
        onTap: () => buildModal(ad.link),
        child: SizedBox(
          width: double.maxFinite,
          child: FadeInImage.assetNetwork(
            image: ad.image,
            placeholder: "assets/image_not_found.png",
            fit: BoxFit.fill,
          ),
        ));
  }
}
