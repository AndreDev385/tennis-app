import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../dtos/player_dto.dart';
import '../../dtos/user_dto.dart';
import '../../main.dart';
import '../../screens/auth/login.dart';
import '../../screens/auth/sign_in.dart';
import '../../screens/club_subscription/affiliate_club.dart';
import '../../screens/cta/home.dart';
import '../../screens/cta/tracker/choose_club.dart';
import '../../screens/home.dart';
import '../../screens/tournaments/tournament_list.dart';
import '../../screens/user/config.dart';
import '../../services/storage.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 20,
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: SvgPicture.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/logo_light_bg.svg'
                  : 'assets/logo_dark_bg.svg',
              height: 50,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: isLoggedIn
                ? Column(children: [
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    ListTile(
                      title: Text("Inicio"),
                      leading: Icon(Icons.home),
                      onTap: () {
                        Navigator.of(context).pushNamed(MyHomePage.route);
                      },
                    ),
                    ListTile(
                      title: Text("CTA"),
                      leading: Icon(Icons.sports_tennis),
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
                      title: Text("Tournaments"),
                      leading: Icon(Icons.settings),
                      onTap: () => Navigator.of(context).pushNamed(
                        TournamentListPage.route,
                      ),
                    ),
                    ListTile(
                      title: Text("Configuración"),
                      leading: Icon(Icons.settings),
                      onTap: () =>
                          Navigator.of(context).pushNamed(UserConfig.route),
                    ),
                    ListTile(
                      title: Text("Tema"),
                      leading: Icon(Icons.light),
                      onTap: () {
                        themeManager.toggleTheme(
                            themeManager.themeMode == ThemeMode.dark);
                      },
                    ),
                    ListTile(
                      title: Text("Cerrar session"),
                      leading: Icon(Icons.exit_to_app),
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
                        title: Text("Regístrate"),
                        leading: Icon(
                          Icons.app_registration,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(SigningPage.route);
                        },
                      ),
                      ListTile(
                        title: Text("Inicia Sesión"),
                        leading: Icon(Icons.login),
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
