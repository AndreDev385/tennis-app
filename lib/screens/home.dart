import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/shared/section_title.dart';
import 'package:tennis_app/components/shared/slider.dart';
import 'package:tennis_app/components/tournaments/tournament_card.dart';
import 'package:tennis_app/firebase_api.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/screens/tournaments/tournament_list.dart';
import 'package:tennis_app/services/player/get_player_data.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/tournaments/paginate.dart';
import 'package:tennis_app/services/user/get_my_user_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/state_keys.dart';

import '../../components/layout/header.dart';
import '../dtos/tournaments/tournament.dart';
import 'tutorial.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const route = "/home";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> state = {
    'isLogged': false,
    'token': '',
    StateKeys.loading: true,
  };

  List<Tournament> tournaments = [];

  @override
  initState() {
    super.initState();
    _seeTutorial();
    _handleRequest();
    if (Platform.isAndroid || Platform.isIOS) {
      FirebaseApi().initNotifications();
    }
  }

  _seeTutorial() async {
    final st = await createStorageHandler();

    if (st.getTutorial() == null || st.getTutorial()! == false) {
      navigationKey.currentState?.pushNamed(TutorialPage.route);
    }
  }

  _handleRequest() async {
    final st = await createStorageHandler();

    await _loadToken(st);
    await _paginateTournaments();

    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  _loadToken(StorageHandler st) async {
    String token = st.loadToken();
    if (token.isEmpty) {
      setState(() {
        state['isLogged'] = false;
      });
      return;
    }
    await getMyUserData();
    await getPlayerData();
    setState(() {
      state['isLogged'] = true;
      state['token'] = token;
    });
  }

  _paginateTournaments() async {
    final result = await paginateTournaments();

    if (result.isFailure) {
      return;
    }

    print(result.getValue().rows);

    setState(() {
      tournaments = result.getValue().rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    render() {
      return Skeletonizer(
        enabled: state[StateKeys.loading],
        child: ListView(
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 512),
                padding: EdgeInsets.only(
                  top: 8,
                  left: 4,
                  right: 4,
                  bottom: 32,
                ),
                child: Column(
                  children: [
                    SectionTitle(title: "patrocinantes"),
                    CardSlider(
                      cards: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.cardBorderRadius,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 0,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Image.asset(
                              "assets/everlast.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.cardBorderRadius,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 0,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Image.asset(
                              "assets/las_nieves.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.cardBorderRadius,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 0,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Image.asset(
                              "assets/las_nieves.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    SectionTitle(title: "ligas"),
                    CardSlider(
                      cards: [
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.cardBorderRadius,
                            ),
                          ),
                          elevation: 0,
                          child: InkWell(
                            onTap: () {},
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.asset(
                                "assets/CTA.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    if (tournaments.length > 0)
                      SectionTitle(
                        title: 'torneos',
                        navigate: () {
                          Navigator.of(context).pushNamed(
                            TournamentListPage.route,
                          );
                        },
                      ),
                    CardSlider(
                      viewport: 1,
                      height: 240,
                      cards: tournaments.map(
                        (t) {
                          return TournamentCard(
                            tournament: t,
                            height: 240,
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: const Header(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: SvgPicture.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/logo_light_bg.svg'
                  : 'assets/logo_dark_bg.svg',
              width: 150,
            ),
          ),
        ),
        body: render(),
      ),
    );
  }
}
