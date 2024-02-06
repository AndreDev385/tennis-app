import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/screens/app/tutorial.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/user/get_my_user_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/state_keys.dart';

import '../../components/layout/header.dart';

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

  @override
  initState() {
    super.initState();
    _seeTutorial();
    _handleRequest();
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
    setState(() {
      state['isLogged'] = true;
      state['token'] = token;
    });
    await getMyUserData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool value) async {
        return;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: const Header(),
        appBar: AppBar(
          backgroundColor: MyTheme.purple,
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: SvgPicture.asset(
              'assets/logo_dark_bg.svg',
              width: 150,
            ),
          ),
        ),
        body: state[StateKeys.loading]
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enlargeCenterPage: false,
                          autoPlay: true,
                          height: 100,
                          viewportFraction: 1,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: false,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                        ),
                        items: [
                          Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/add1.png"
                                : "assets/add1_dark.png",
                            fit: BoxFit.fitWidth,
                          ),
                          Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/add2.png"
                                : "assets/add2_dark.png",
                            fit: BoxFit.fitWidth,
                          ),
                          Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/add3.png"
                                : "assets/add3_dark.png",
                            fit: BoxFit.fitWidth,
                          ),
                          Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/add4.png"
                                : "assets/add4_dark.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: false,
                        autoPlay: true,
                        aspectRatio: 9 / 12,
                        viewportFraction: 1,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: false,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                      ),
                      items: [
                        Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/step1.png"
                                : "assets/step1_dark.png"),
                        Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/step2.png"
                                : "assets/step2_dark.png"),
                        Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/step3.png"
                                : "assets/step3_dark.png"),
                        Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/step4.png"
                                : "assets/step4_dark.png"),
                        Image.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? "assets/step5.png"
                                : "assets/step5_dark.png"),
                      ],
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
          ),
        ),
      ),
    );
  }
}
