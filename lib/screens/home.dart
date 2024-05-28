import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/shared/network_image.dart';
import 'package:tennis_app/components/shared/section_title.dart';
import 'package:tennis_app/components/shared/slider.dart';
import 'package:tennis_app/components/tournaments/tournament_card.dart';
import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/firebase_api.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/screens/tournaments/tournament_list.dart';
import 'package:tennis_app/services/list_home_ads.dart';
import 'package:tennis_app/services/player/get_player_data.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/tournaments/paginate.dart';
import 'package:tennis_app/services/user/get_my_user_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/state_keys.dart';

import '../../components/layout/header.dart';
import '../dtos/home_ad_dto.dart';
import '../dtos/tournaments/tournament.dart';
import 'cta/home.dart';
import 'cta/tracker/choose_club.dart';
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
  List<HomeAdDto> ads = [];

  // user data
  bool canTrack = false;
  bool hasCTAAccess = false;

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
    await _listHomeAds();

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
    final result = await getMyUserData();
    if (result.isFailure) {
      //TODO: handle error
      return;
    }
    final value = result.getValue();

    if (value.user.isPlayer) {
      final playerResult = await getPlayerData();
      if (!playerResult.isFailure) {
        PlayerDto player = playerResult.getValue();
        setState(() {
          hasCTAAccess = !player.isDeleted!;
        });
      }
    }

    setState(() {
      state['isLogged'] = true;
      state['token'] = token;
      canTrack = value.user.canTrack;
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

  _listHomeAds() async {
    final result = await listHomeAds();

    setState(() {
      ads = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    render() {
      final fakeAds = List.filled(5, HomeAdDto.skeleton());
      final fakeTournaments = List.filled(4, Tournament.skeleton());

      final listAds = state[StateKeys.loading] ? fakeAds : ads;
      final listTournaments =
          state[StateKeys.loading] ? fakeTournaments : tournaments;

      return Skeletonizer(
        enabled: state[StateKeys.loading],
        child: Column(
          children: [
            if (ads.isNotEmpty || state[StateKeys.loading])
              SectionTitle(title: "patrocinantes"),
            if (ads.isNotEmpty || state[StateKeys.loading])
              CardSlider(
                cards: listAds.map((r) {
                  return InkWell(
                    onTap: () {
                      // TODO: handle cta access
                      print("Click");
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          MyTheme.cardBorderRadius,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 0,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: state[StateKeys.loading]
                            ? Image.asset(
                                "assets/CTA.jpg",
                                fit: BoxFit.fill,
                              )
                            : NetWorkImage(url: r.image, height: null),
                      ),
                    ),
                  );
                }).toList(),
              ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            if (hasCTAAccess || canTrack) SectionTitle(title: "ligas"),
            if (hasCTAAccess || canTrack)
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
                      },
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
            if (tournaments.length > 0 || state[StateKeys.loading])
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
              cards: listTournaments.map(
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
        body: ListView(
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
                child: render(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
