import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/services/get_my_user_data.dart';

import 'games_list.dart';
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
    SharedPreferences storage = await SharedPreferences.getInstance();

    await _loadToken(storage);
  }

  _loadToken(SharedPreferences storage) async {
    token = storage.getString("accessToken") ?? "";
    if (token.isEmpty) {
      setState(() {
        isLogged = false;
      });
      return;
    }
    print('hello');
    setState(() {
      isLogged = true;
      this.token = token;
    });
    await getMyUserData();
  }

  List<String> names = ["Andre Izarra", "Alexandra Balza", "Luismar Banezca"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Header(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Inicio"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //GameList()
            Title(
              color: Theme.of(context).primaryColor,
              child: const Text(
                "Mis partidos",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: GameList(games: names),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          splashColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pushNamed("/add-game");
          },
          label: const Row(
            children: [Icon(Icons.add), Text("Crear juego")],
          )),
    );
  }
}
