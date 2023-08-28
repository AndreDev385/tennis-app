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
            width: 200,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(32),
              child: Container(
                child: Column(
                  children: <Widget>[
                    TutorialStep(
                      number: 1,
                      title: "Crea un partido",
                      content:
                          "En GameMind puedes llevar objetivamente el rendimiento de un jugador (o pareja) durante su partido",
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 40)),
                    TutorialStep(
                      number: 2,
                      title: "Elige una configuración",
                      content:
                          "Elige entre la configuraciones disponibles la que se adecué al tipo de partidos que vas a observar",
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 40)),
                    TutorialStep(
                      number: 3,
                      title: "Selecciona las estadísticas",
                      content:
                          "Hay tres modelos diferentes a la hora de llevar las estadísticas, elige las que prefieras o te interesen mas seguir y da inicio al conteo",
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 40)),
                    TutorialStep(
                      number: 4,
                      title: "Lleva el conteo de los puntos",
                      content:
                          "Siga detenidamente los puntos que se hacen durante el partido y anótelos como corresponden",
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 40)),
                    TutorialStep(
                      number: 5,
                      title: "Observa los resultados",
                      content:
                          "Al finalizar podrás ver objetivamente el total de los puntos que han realizado los jugadores y cada una de sus estadísticas y porcentajes",
                    ),
                  ],
                ),
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
