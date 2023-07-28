import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/components/new_regular_game/select_statistics.dart';

import '../../../components/new_regular_game/config_form.dart';
import '../../../components/new_regular_game/players_form.dart';

class AddGameRegularPage extends StatefulWidget {
  const AddGameRegularPage({super.key});

  static const route = "/add-game";

  @override
  State<AddGameRegularPage> createState() => _AddGameRegularPageState();
}

class _AddGameRegularPageState extends State<AddGameRegularPage> {
  int formStep = 1;

  bool superTiebreak = false;
  int setsQuantity = 3;

  String surface = Surfaces.hard;
  String gameMode = GameMode.single;
  int setType = GamesPerSet.regular;

  String direction = "";

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    void back() {
      setState(() {
        formStep--;
      });
    }

    void next({
      required String mode,
      required int setsQuantity,
      required String surface,
      required int setType,
      //required bool superTiebreak,
      required String direction,
    }) {
      setState(() {
        gameMode = mode;
        this.setsQuantity = setsQuantity;
        this.surface = surface;
        this.setType = setType;
        //this.superTiebreak = superTiebreak;
        this.direction = direction;
        formStep++;
      });
    }

    void createGame({
      required String me,
      required String rival,
      required String partner,
      required String rival2,
    }) {
      gameProvider.createNewMatch(
          gameMode, setsQuantity, surface, setType, direction);

      if (gameMode == GameMode.single) {
        gameProvider.setSingleGamePlayers(me, rival);
      } else {
        gameProvider.setDoubleGamePlayers(me, partner, rival, rival2);
      }
      formStep++;
    }

    void selectStatisticsAndStartGame(String value) {
      gameProvider.setStatistics(value);
      Navigator.of(context).pushNamed('/game-points/basic');
    }

    showStep() {
      if (formStep == 2) {
        return PlayersForm(back: back, createGame: createGame, mode: gameMode);
      } else if (formStep == 3) {
        return SelectStatistics(
          selectStatisticsAndStartGame: selectStatisticsAndStartGame,
          back: back,
        );
      } else {
        // step == 1
        return ConfigForm(next: next);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Nuevo juego"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: showStep(),
        ),
      ),
    );
  }
}
