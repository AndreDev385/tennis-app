import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tennis_app/firebase_api.dart';

import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/components/cta/match/match_result.dart';
import 'package:tennis_app/components/cta/live/watch_live.dart';
import 'package:tennis_app/firebase_options.dart';
import 'package:tennis_app/providers/tracker_state.dart';
import 'package:tennis_app/screens/app/cta/create_clash_matchs.dart';
import 'package:tennis_app/screens/app/cta/track_match.dart';
import 'package:tennis_app/screens/app/new_game/add_regular_game.dart';
import 'package:tennis_app/screens/app/clubs/affiliate_club.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/screens/app/game_points.dart';
import 'package:tennis_app/screens/app/results/results.dart';
import 'package:tennis_app/screens/app/tournaments/tournament.dart';
import 'package:tennis_app/screens/app/tournaments/tournament_list.dart';
import 'package:tennis_app/screens/app/tutorial.dart';
import 'package:tennis_app/screens/app/user/change_password.dart';
import 'package:tennis_app/screens/app/user/config.dart';
import 'package:tennis_app/screens/app/user/edit_profile.dart';
import 'package:tennis_app/screens/auth/forget_password.dart';
import 'package:tennis_app/screens/auth/sign_in.dart';
import 'package:tennis_app/screens/auth/login.dart';
import 'package:tennis_app/screens/app/home.dart';
import 'package:tennis_app/styles.dart';

final navigationKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  if (Platform.isIOS || Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
    await FirebaseApi().initNotifications();
  }
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance..indicatorType = EasyLoadingIndicatorType.ring;
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
    super.dispose();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameRules>(
          create: (_) => GameRules(),
        ),
        ChangeNotifierProvider<TrackerState>(
          create: (_) => TrackerState(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeManager.themeMode,
        builder: EasyLoading.init(),
        navigatorKey: navigationKey,
        initialRoute: MyHomePage.route,
        routes: {
          //VideoStream.route: (context) => const VideoStream(),
          TutorialPage.route: (context) => const TutorialPage(),
          LoginPage.route: (context) => const LoginPage(),
          SigningPage.route: (context) => SigningPage(),
          ForgetPassword.route: (context) => const ForgetPassword(),
          MyHomePage.route: (context) => const MyHomePage(),
          UserConfig.route: (context) => const UserConfig(),
          EditProfile.route: (context) => const EditProfile(),
          ChangePassword.route: (context) => const ChangePassword(),
          AddGameRegularPage.route: (context) => const AddGameRegularPage(),
          CtaHomePage.route: (context) => const CtaHomePage(),
          GamePointsBasic.route: (context) => const GamePointsBasic(),
          ResultPage.route: (context) => const ResultPage(),
          AffiliateClub.route: (context) => const AffiliateClub(),
          WatchLive.route: (context) => const WatchLive(),
          MatchResult.route: (context) => const MatchResult(),
          CreateClashMatchs.route: (context) => const CreateClashMatchs(),
          TrackMatch.route: (context) => const TrackMatch(),
          TournamentListPage.route: (context) => const TournamentListPage(),
          TournamentPage.route: (context) => const TournamentPage(),
        },
      ),
    );
  }
}
