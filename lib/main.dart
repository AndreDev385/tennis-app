import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/components/cta/match/match_result.dart';
import 'package:tennis_app/components/cta/live/watch_live.dart';
import 'package:tennis_app/screens/app/cta/create_clash.dart';
import 'package:tennis_app/screens/app/cta/create_clash_matchs.dart';
import 'package:tennis_app/screens/app/cta/track_match.dart';

import 'package:tennis_app/screens/app/new_game/add_regular_game.dart';
import 'package:tennis_app/screens/app/clubs/afiliate_club.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/screens/app/game_detail.dart';
import 'package:tennis_app/screens/app/game_points.dart';
import 'package:tennis_app/screens/app/results/results.dart';
import 'package:tennis_app/screens/auth/signin.dart';
import 'package:tennis_app/styles.dart';
import 'screens/app/home.dart';
import 'screens/auth/login.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameRules(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeManager.themeMode,
        builder: EasyLoading.init(),
        initialRoute: MyHomePage.route,
        routes: {
          LoginPage.route: (context) => const LoginPage(),
          SigninPage.route: (context) => SigninPage(),
          MyHomePage.route: (context) => const MyHomePage(),
          AddGameRegularPage.route: (context) => const AddGameRegularPage(),
          GameDetail.route: (context) => const GameDetail(),
          CtaHomePage.route: (context) => const CtaHomePage(),
          GamePointsBasic.route: (context) => const GamePointsBasic(),
          ResultPage.route: (context) => const ResultPage(),
          AffiliateClub.route: (context) => const AffiliateClub(),
          WatchLive.route: (context) => const WatchLive(),
          MatchResult.route: (context) => const MatchResult(),
          CreateClash.route: (context) => const CreateClash(),
          CreateClashMatchs.route: (context) => const CreateClashMatchs(),
          TrackMatch.route: (context) => const TrackMatch(),
        },
      ),
    );
  }
}
