import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/services/get_my_user_data.dart';
import 'package:flutter_svg/svg.dart';

import 'games_list.dart';
import '../../components/layout/header.dart';
import 'package:tennis_app/domain/match.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const route = "/home";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token = '';
  bool? isLogged = false;
  List<Match> games = [];

  final String assetName = 'assets/logo_light.svg';

  @override
  initState() {
    super.initState();
    _handleRequest();
  }

  _handleRequest() async {
    EasyLoading.show(status: "Cargando...");
    SharedPreferences storage = await SharedPreferences.getInstance();

    await _loadToken(storage);
    await _loadGames(storage);

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

  _loadGames(SharedPreferences storage) async {
    List<String>? games = storage.getStringList("myGames");

    if (games == null || games.isEmpty) {
      return;
    }

    setState(() {
      this.games = games.map((e) => Match.fromJson(jsonDecode(e))).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget logo = SvgPicture.asset(
      assetName,
      semanticsLabel: "logo",
      width: 200,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const Header(),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: logo,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Container(
              child: games.isEmpty
                  ? const Center()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Mis partidos",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          child: GameList(games: games),
                        ),
                      ],
                    )),
        ),
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
