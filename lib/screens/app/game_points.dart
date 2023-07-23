import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:tennis_app/domain/game_rules.dart";
import 'package:tennis_app/components/results/render_result.dart';

import '../../components/game_score/score_board.dart';

import '../../components/game_buttons/basic_buttons.dart';
import '../../components/game_buttons/intermediate/intermediate_buttons.dart';
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
        return const IntermediateButtons();
      } else if (gameProvider.match?.statistics == Statistics.advanced) {
        return const AdvancedButtons();
      } else if (gameProvider.match?.statistics == Statistics.basic) {
        return const BasicButtons();
      } else {
        return const BasicButtons();
      }
    }

    modalBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Estas seguro de salir del partido actual?"),
              content: const Text("Todo el progreso actual se perdera"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/home');
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text("Aceptar"),
                ),
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: () {
        return modalBuilder(context) as Future<bool>;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Botones"),
                Tab(text: "Estadisticas"),
              ],
            ),
            centerTitle: true,
            title: const Text("Juego"),
            leading: BackButton(
              onPressed: () => modalBuilder(context),
            ),
          ),
          body: Container(
            color: Colors.black12,
            padding: const EdgeInsets.all(16),
            child: TabBarView(children: [
              Column(
                children: [
                  const ScoreBoard(),
                  renderButtons(),
                ],
              ),
              ListView(
                children: [
                  ResultTable(
                    match: gameProvider.match!,
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
