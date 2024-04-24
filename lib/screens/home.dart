import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/components/tournaments/tournament_card.dart';
import 'package:tennis_app/firebase_api.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/services/player/get_player_data.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/tournaments/paginate.dart';
import 'package:tennis_app/services/user/get_my_user_data.dart';
import 'package:flutter_svg/svg.dart';
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

    setState(() {
      tournaments = result.getValue().rows;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: state[StateKeys.loading]
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 512),
                      padding: EdgeInsets.only(
                        top: 8,
                        left: 16,
                        right: 16,
                        bottom: 32,
                      ),
                      child: Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              enlargeCenterPage: false,
                              autoPlay: true,
                              viewportFraction: 1,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                            ),
                            items: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Image.asset(
                                    "assets/everlast.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 5,
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Image.asset(
                                    "assets/las_nieves.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            child: InkWell(
                              onTap: () {},
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.asset(
                                  "assets/CTA.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 16, bottom: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Torneos",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Divider(
                                      endIndent: 200,
                                      thickness: 4,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                ),
                              ),
                              ...tournaments.map(
                                (t) {
                                  return TournamentCard(tournament: t);
                                },
                              ).toList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
