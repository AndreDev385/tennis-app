import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/screens/app/home.dart';
import 'package:tennis_app/services/storage.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<StatefulWidget> createState() => _TutorialPage();

  static const route = 'tutorial-page';
}

final List<Widget> steps = [
  {
    "title": "Crear y configurar partido",
    "description":
        "En GameMind puedes crear partidos con una configuracion perzonalizada de acuerdo a tu necesidad.",
    "asset": "assets/gears.svg",
  },
  {
    "title": "Estadísticas",
    "description":
        "Marca el punto a punto del partido con un flujo de botones sencillo de entender.",
    "asset": "assets/statistics.svg",
  },
  {
    "title": "Resultados",
    "description":
        "Las estadísticas finales te permiten analizar el desempeño de los jugadores durante el partido.",
    "asset": "assets/results.svg",
  },
]
    .map((e) => TutorialStep(
          title: e['title']!,
          description: e['description']!,
          asset: e['asset']!,
        ))
    .toList();

class _TutorialPage extends State<TutorialPage> {
  @override
  void initState() {
    super.initState();
  }

  int _page = 0;
  CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;

    double percentNumber = 0.25;

    void markTutorialSeen() async {
      StorageHandler st = await createStorageHandler();
      st.markTutorialSeen();
      Navigator.of(context).pushNamed(MyHomePage.route);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              child: CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: totalHeight - (totalHeight * percentNumber),
                  autoPlay: false,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  initialPage: 0,
                  pageSnapping: false,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                ),
                disableGesture: true,
                items: steps,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () async {
                    if (_page == steps.length - 1) {
                      markTutorialSeen();
                    }
                    setState(() {
                      _page += 1;
                    });
                    await _controller.animateToPage(
                      _page,
                      duration: Duration(milliseconds: 400),
                    );
                  },
                  child: Text(
                    "Siguiente",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                ElevatedButton(
                  onPressed: () => markTutorialSeen(),
                  child: Text(
                    "Saltar",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TutorialStep extends StatelessWidget {
  const TutorialStep({
    super.key,
    required this.title,
    required this.description,
    required this.asset,
  });

  final String title;
  final String description;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          asset,
          height: 250,
          fit: BoxFit.fitHeight,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          description,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
