import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/clubs/affiliate_club.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/screens/app/home.dart';
import 'package:tennis_app/screens/app/user/config.dart';
import 'package:tennis_app/screens/auth/login.dart';
import 'package:tennis_app/screens/auth/sign_in.dart';
import 'package:tennis_app/services/storage.dart';

import '../../main.dart';
import "../../screens/app/cta/tracker/choose_club.dart";

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool isLoggedIn = false;
  bool canTrack = false;
  bool hasCTAAccess = false;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    StorageHandler st = await createStorageHandler();
    String? user = st.getUser();
    if (user == null) {
      return;
    }

    String? player = st.getPlayer();
    if (player != null) {
      print(player);
      PlayerDto playerData = PlayerDto.fromJson(jsonDecode(player));
      if (playerData.isDeleted == false) {
        setState(() {
          hasCTAAccess = true;
        });
      }
    }

    UserDto data = UserDto.fromJson(jsonDecode(user));
    setState(() {
      isLoggedIn = true;
      canTrack = data.canTrack;
    });
  }

  logOut() async {
    StorageHandler st = await createStorageHandler();
    st.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 20,
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: const Image(
              image: AssetImage('assets/logo_dark_bg.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: isLoggedIn
                ? Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    ListTile(
                      title: Text(
                        "Inicio",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      leading: Icon(
                        Icons.home,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(MyHomePage.route);
                      },
                    ),
                    ListTile(
                      title: Text(
                        "CTA",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      leading: Icon(
                        Icons.sports_tennis,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onTap: () {
                        if (canTrack) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChooseClub()));
                          return;
                        }
                        if (hasCTAAccess) {
                          Navigator.of(context).pushNamed(CtaHomePage.route);
                          return;
                        }
                        Navigator.of(context).pushNamed(AffiliateClub.route);
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Configuración",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      leading: Icon(
                        Icons.settings,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onTap: () =>
                          Navigator.of(context).pushNamed(UserConfig.route),
                    ),
                    ListTile(
                      title: Text(
                        "Tema",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      leading: Icon(
                        Icons.light,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onTap: () {
                        themeManager.toggleTheme(
                            themeManager.themeMode == ThemeMode.dark);
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Cerrar session",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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
                        title: Text(
                          "Regístrate",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        leading: Icon(
                          Icons.app_registration,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(SigningPage.route);
                        },
                      ),
                      ListTile(
                        title: Text(
                          "Inicia Sesión",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        leading: Icon(
                          Icons.login,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
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
