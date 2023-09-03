import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/tutorial_step.dart';
import 'package:tennis_app/services/get_my_user_data.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/layout/header.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const route = "/home";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token = '';
  bool? isLogged = false;

  @override
  initState() {
    super.initState();
    _handleRequest();
  }

  _handleRequest() async {
    EasyLoading.show(status: "Cargando...");
    SharedPreferences storage = await SharedPreferences.getInstance();

    await _loadToken(storage);
    EasyLoading.dismiss();
  }

  _loadToken(SharedPreferences storage) async {
    token = storage.getString("accessToken") ?? "";
    if (token.isEmpty) {
      setState(() {
        isLogged = false;
      });
      return;
    }
    setState(() {
      isLogged = true;
      token = token;
    });
    await getMyUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const Header(),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: SvgPicture.asset(
            'assets/logo_dark_bg.svg',
            width: 150,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: <Widget>[
                  TutorialStep(
                    number: 1,
                    title: "Crea un partido",
                    content:
                        "En GameMind puedes llevar objetivamente el rendimiento de un jugador (o pareja) durante su partido.",
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40)),
                  TutorialStep(
                    number: 2,
                    title: "Elige una configuración",
                    content:
                        "Elige entre las configuraciones disponibles la que se adecúe al tipo de partidos que vas a observar.",
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40)),
                  TutorialStep(
                    number: 3,
                    title: "Selecciona las estadísticas",
                    content:
                        "Hay tres modelos diferentes a la hora de llevar las estadísticas, elige las que prefieras y da inicio al conteo.",
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40)),
                  TutorialStep(
                    number: 4,
                    title: "Conteo de los puntos",
                    content:
                        "Sigue detenidamente los puntos que se hacen durante el partido y anótalos como corresponden.",
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40)),
                  TutorialStep(
                    number: 5,
                    title: "Observa los resultados",
                    content:
                        "Al finalizar podrás ver el total de los puntos que han realizado los jugadores y cada una de sus estadísticas.",
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? "assets/add1.png"
                            : "assets/add1_dark.png",
                        fit: BoxFit.fitWidth,
                        width: 120,
                      ),
                      Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? "assets/add2.png"
                            : "assets/add2_dark.png",
                        fit: BoxFit.fitWidth,
                        width: 120,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? "assets/add3.png"
                            : "assets/add3_dark.png",
                        fit: BoxFit.fitWidth,
                        width: 120,
                      ),
                      Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? "assets/add4.png"
                            : "assets/add4_dark.png",
                        fit: BoxFit.fitWidth,
                        width: 120,
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 48))
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.of(context).pushNamed("/add-game");
          },
          label: Row(
            children: [
              Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              Text(
                "Crear juego",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          )),
    );
  }
}
