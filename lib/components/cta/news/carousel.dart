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
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: false,
          autoPlay: true,
          viewportFraction: .60,
          aspectRatio: 16 / 6,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        items: ads
            .map((e) => Ad(
                  ad: e,
                ))
            .toList(),
      ),
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
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Quieres visitar el link seleccionado?"),
              content: const Text("Seras redirigido a la pagina"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    launch();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Aceptar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    return InkWell(
      onTap: () => buildModal(ad.link),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: SizedBox(
          width: double.maxFinite,
          child: FadeInImage.assetNetwork(
            image: ad.image,
            placeholder: "assets/image_placeholder.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
