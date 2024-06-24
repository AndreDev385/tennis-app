import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/home/greet.dart';
import 'package:tennis_app/components/shared/network_image.dart';
import 'package:tennis_app/components/shared/section_title.dart';
import 'package:tennis_app/components/shared/slider.dart';
import 'package:tennis_app/components/tournaments/tournament_card.dart';
import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/firebase_api.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/screens/auth/login.dart';
import 'package:tennis_app/screens/new_game/add_tournament_game.dart';
import 'package:tennis_app/screens/tournaments/tournament_list.dart';
import 'package:tennis_app/services/list_home_ads.dart';
import 'package:tennis_app/services/player/get_player_data.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/tournaments/paginate.dart';
import 'package:tennis_app/services/user/get_my_user_data.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/state_keys.dart';

import '../../components/layout/header.dart';
import '../dtos/home_ad_dto.dart';
import '../dtos/tournaments/tournament.dart';
import 'cta/home.dart';
import 'cta/tracker/choose_club.dart';
import 'onboarding.dart';

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
  UserDto? userData;

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
      navigationKey.currentState?.pushNamed(OnboardingPage.route);
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
      st.logOut();
      navigationKey.currentState!.pushNamed(LoginPage.route);
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
      userData = value.user;
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
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CardSlider(
                  cards: listAds.map((r) {
                    return Card(
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
                    );
                  }).toList(),
                ),
              ),
            if (tournaments.length > 0 || state[StateKeys.loading])
              SectionTitle(
                title: 'Torneos',
                navigate: () {
                  Navigator.of(context).pushNamed(
                    TournamentListPage.route,
                  );
                },
              ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: CardSlider(
                viewport: 1,
                height: 200,
                cards: listTournaments.map(
                  (t) {
                    return TournamentCard(
                      tournament: t,
                      height: 240,
                    );
                  },
                ).toList(),
              ),
            ),
            if (hasCTAAccess || canTrack) SectionTitle(title: "Ligas"),
            if (hasCTAAccess || canTrack)
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CardSlider(
                  height: 200,
                  viewport: 1,
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
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Image.asset(
                            "assets/cta-league.JPG",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        endDrawer: const Header(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: HomeGreet(user: userData),
        ),
        body: ListView(
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 512),
                padding: EdgeInsets.only(
                  left: 4,
                  right: 4,
                ),
                child: render(),
              ),
            )
          ],
        ),
        floatingActionButton: canTrack
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddTournamentGame.route);
                },
                child: Icon(Icons.add),
                backgroundColor: Theme.of(context).colorScheme.primary,
                tooltip: "Practice match",
                shape: CircleBorder(),
              )
            : null,
      ),
    );
  }
}
