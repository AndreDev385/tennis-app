import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';

import 'components/cta/live/watch_live.dart';
import 'components/cta/match/match_result.dart';
import 'firebase_api.dart';
import 'firebase_options.dart';
import 'providers/game_rules.dart';
import 'providers/tracker_state.dart';
import 'screens/auth/forget_password.dart';
import 'screens/auth/login.dart';
import 'screens/auth/sign_in.dart';
import 'screens/club_subscription/affiliate_club.dart';
import 'screens/cta/create_clash_matchs.dart';
import 'screens/cta/home.dart';
import 'screens/cta/track_match.dart';
import 'screens/game_points.dart';
import 'screens/home.dart';
import 'screens/new_game/add_regular_game.dart';
import 'screens/results/results.dart';
import 'screens/tournaments/tournament_list.dart';
import 'screens/tutorial.dart';
import 'screens/user/change_password.dart';
import 'screens/user/config.dart';
import 'screens/user/edit_profile.dart';
import 'styles.dart';

final navigationKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  if (Platform.isIOS || Platform.isAndroid) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider<TournamentMatchProvider>(
          create: (_) => TournamentMatchProvider(),
        ),
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
        },
      ),
    );
  }
}
