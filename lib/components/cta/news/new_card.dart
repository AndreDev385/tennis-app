import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/news_dto.dart';
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
      onTap: () => buildModal(newDto.link),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          child: Image.network(
            newDto.image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
