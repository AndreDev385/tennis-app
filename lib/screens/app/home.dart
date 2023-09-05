import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/tutorial_step.dart';
import 'package:tennis_app/services/get_my_user_data.dart';
import 'package:flutter_svg/svg.dart';

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
    EasyLoading.show(status: "Cargando...");
    SharedPreferences storage = await SharedPreferences.getInstance();

    await _loadToken(storage);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const Header(),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: SvgPicture.asset(
            'assets/logo_dark_bg.svg',
            width: 150,
          ),
        ),
      ),
      body: CustomScrollView(
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
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
              ),
              items: [
                Image.asset(Theme.of(context).brightness == Brightness.light
                    ? "assets/step1.png"
                    : "assets/step1_dark.png"),
                Image.asset(Theme.of(context).brightness == Brightness.light
                    ? "assets/step2.png"
                    : "assets/step2_dark.png"),
                Image.asset(Theme.of(context).brightness == Brightness.light
                    ? "assets/step3.png"
                    : "assets/step3_dark.png"),
                Image.asset(Theme.of(context).brightness == Brightness.light
                    ? "assets/step4.png"
                    : "assets/step4_dark.png"),
                Image.asset(Theme.of(context).brightness == Brightness.light
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
          )),
    );
  }
}
