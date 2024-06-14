import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/shared/network_image.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/main.dart';
import 'package:tennis_app/providers/curr_tournament_provider.dart';
import 'package:tennis_app/providers/user_state.dart';
import 'package:tennis_app/screens/auth/login.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/format_date.dart';

import '../../dtos/tournaments/tournament.dart';
import '../../screens/tournaments/tournament_page.dart';

class TournamentCard extends StatelessWidget {
  final Tournament tournament;

  final double height;

  const TournamentCard({
    super.key,
    required this.tournament,
    this.height = 240,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserState>(context);
    final currentTournamentProvider =
        Provider.of<CurrentTournamentProvider>(context);

    setUserAndNavigate(BuildContext context) async {
      currentTournamentProvider.setCurrTournament(tournament);

      final st = await createStorageHandler();
      final userStr = st.getUser();

      if (userStr == null) {
        showMessage(
          context,
          "Inicia sesión para acceder",
          ToastType.info,
        );
        navigationKey.currentState!.pushNamed(LoginPage.route);
        return;
      }

      UserDto user = UserDto.fromJson(jsonDecode(userStr));
      userProvider.setCurrentUser(user);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TournamentPage(
            tournamentProvider: currentTournamentProvider,
            updateContest: true,
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        NetWorkImage(url: tournament.image, height: height),
        Align(
          alignment: Alignment.bottomCenter,
          child: BlurryContainer(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.black.withOpacity(.2),
            borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
            height: 60,
            width: double.maxFinite,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        tournament.name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MyTheme.largeTextSize,
                        ),
                      ),
                      Text(
                        "Fecha: ${formatDate(tournament.startDate)} - ${formatDate(tournament.endDate)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MyTheme.smallTextSize,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    constraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
                    child: IconButton(
                      onPressed: () => setUserAndNavigate(context),
                      color: Theme.of(context).colorScheme.onPrimary,
                      icon: Icon(Icons.arrow_forward),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
