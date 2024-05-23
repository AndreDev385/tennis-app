import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/news_dto.dart';
import 'package:tennis_app/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NewCard extends StatelessWidget {
  const NewCard({
    super.key,
    required this.newDto,
  });

  final NewDto newDto;

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
      onTap: () => buildModal(newDto.link),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
        ),
        elevation: 5,
        child: SizedBox(
          width: double.maxFinite,
          child: FadeInImage.assetNetwork(
            image: newDto.image,
            placeholder: "assets/image_placeholder.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
