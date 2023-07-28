import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/clubs/afiliate_club.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/screens/app/home.dart';
import 'package:tennis_app/screens/auth/login.dart';
import 'package:tennis_app/screens/auth/signin.dart';
import '../../main.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isLoggedIn = false;
  bool isPlayer = false;
  bool canTrack = false;

  @override
  void initState() {
    super.initState();
    getPlayerType();
  }

  getPlayerType() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? user = storage.getString("user");
    if (user == null) {
      return;
    }
    UserDto data = UserDto.fromJson(jsonDecode(user));
    setState(() {
      isLoggedIn = true;
      canTrack = data.canTrack;
      isPlayer = data.isPlayer;
    });
  }

  logOut() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.remove("user");
    storage.remove("accessToken");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 20,
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Image(
            image: AssetImage('assets/pexels-pixabay-209977.jpg'),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: isLoggedIn
                ? Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    ListTile(
                      title: const Text("Inicio"),
                      leading: const Icon(Icons.home),
                      onTap: () {
                        Navigator.of(context).pushNamed(MyHomePage.route);
                      },
                    ),
                    ListTile(
                      title: const Text("CTA"),
                      leading: const Icon(Icons.sports_tennis),
                      onTap: () {
                        if (canTrack) {
                          Navigator.of(context).pushNamed(CtaHomePage.route);
                          return;
                        }
                        if (!isPlayer) {
                          Navigator.of(context).pushNamed(AffiliateClub.route);
                          return;
                        }
                        Navigator.of(context).pushNamed(CtaHomePage.route);
                      },
                    ),
                    /*ListTile(
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: const Text("Historial"),
                      leading: const Icon(Icons.history),
                      onTap: () {},
                    ),
                    ListTile(
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: const Text("Perfil"),
                      leading: const Icon(Icons.person),
                      onTap: () {},
                    ),*/
                    ListTile(
                      title: const Text("Tema"),
                      leading: const Icon(Icons.light),
                      onTap: () {
                        themeManager.toggleTheme(
                            themeManager.themeMode == ThemeMode.dark);
                      },
                    ),
                    ListTile(
                      title: const Text("Cerrar session"),
                      leading: const Icon(Icons.exit_to_app),
                      onTap: () {
                        logOut();
                        Navigator.of(context).pushNamed(LoginPage.route);
                      },
                    ),
                  ])
                : Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      ListTile(
                        title: const Text("Registrate"),
                        leading: const Icon(Icons.app_registration),
                        onTap: () {
                          Navigator.of(context).pushNamed(SigninPage.route);
                        },
                      ),
                      ListTile(
                        title: const Text("Inicia Sesion"),
                        leading: const Icon(Icons.login),
                        onTap: () {
                          Navigator.of(context).pushNamed(LoginPage.route);
                        },
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
