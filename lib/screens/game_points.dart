import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../../components/game_buttons/advanced/advanced_buttons.dart';
import '../../components/game_score/score_board.dart';
import '../components/results/render_result.dart';
import '../components/shared/appbar_title.dart';
import '../domain/shared/utils.dart';
import '../providers/game_rules.dart';
import 'home.dart';

class GamePointsBasic extends StatefulWidget {
  static const route = "/game-points/basic";

  const GamePointsBasic({super.key});

  @override
  State<GamePointsBasic> createState() => _GamePoints();
}

class _GamePoints extends State<GamePointsBasic> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    renderButtons() {
      if (gameProvider.match?.statistics == Statistics.intermediate) {
        return const AdvancedButtons(renderRally: false);
      } else if (gameProvider.match?.statistics == Statistics.advanced) {
        return const AdvancedButtons(renderRally: true);
      } else {
        return const AdvancedButtons(basicButtons: true);
      }
    }

    modalBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Estas seguro de salir del partido actual?"),
              content: const Text("Todo el progreso actual se perderá"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(MyHomePage.route);
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Aceptar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        modalBuilder(context);
        return;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Botones"),
                Tab(text: "Estadísticas"),
              ],
            ),
            centerTitle: true,
            title: const AppBarTitle(
              icon: Icons.sports_tennis,
              title: "Juego",
            ),
            leading: BackButton(
              color: Theme.of(context).colorScheme.onPrimary,
              onPressed: () => modalBuilder(context),
            ),
          ),
          body: TabBarView(
            children: [
              CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 16, right: 8, left: 8),
                      child: ScoreBoard(
                        sets: gameProvider.match!.sets,
                        mode: gameProvider.match!.mode,
                        points1: gameProvider.getMyPoints,
                        points2: gameProvider.getRivalPoints,
                        servingTeam: gameProvider.match!.servingTeam,
                        player1Name: gameProvider.match!.player1,
                        player2Name: gameProvider.match!.player2,
                        player3Name: gameProvider.match!.player3,
                        player4Name: gameProvider.match!.player4,
                        singleServeFlow: gameProvider.match!.singleServeFlow,
                        doubleServeFlow: gameProvider.match!.doubleServeFlow,
                        matchFinish: gameProvider.match!.matchFinish,
                        currentSetIdx: gameProvider.match!.currentSetIdx,
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16, right: 8, left: 8),
                      child: renderButtons(),
                    ),
                  )
                ],
              ),
              ListView(
                children: [
                  ResultTable(
                    match: gameProvider.match!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
