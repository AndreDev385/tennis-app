import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:tennis_app/components/shared/appbar_title.dart';
import "package:tennis_app/domain/game_rules.dart";
import 'package:tennis_app/components/results/render_result.dart';
import 'package:tennis_app/screens/app/home.dart';

import '../../components/game_score/score_board.dart';
import '../../components/game_buttons/advanced/advanced_buttons.dart';

class GamePointsBasic extends StatefulWidget {
  const GamePointsBasic({super.key});

  static const route = "/game-points/basic";

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
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Botones"),
                Tab(text: "Estadísticas"),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: const AppBarTitle(
              icon: Icons.sports_tennis,
              title: "Juego",
            ),
            leading: BackButton(
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
                      child: ScoreBoard(),
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
