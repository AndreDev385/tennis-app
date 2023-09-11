import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tennis_app/components/cta/create_matchs/matches_form.dart';
import 'package:tennis_app/components/cta/create_matchs/list_matches_preview.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/player_dto.dart';
import 'package:tennis_app/services/list_categories.dart';
import 'package:tennis_app/services/list_players.dart';

class StepManager extends StatefulWidget {
  const StepManager({super.key, required this.clash});

  final ClashDto clash;

  @override
  State<StepManager> createState() => _StepManagerState();
}

class _StepManagerState extends State<StepManager> {
  List<PlayerDto> players = [];
  List<CategoryDto> categories = [];

  int step = 1;

  //form
  String doble1player1 = "";
  String doble1player2 = "";
  String doble1rival1 = "";
  String doble1rival2 = "";

  String doble2player1 = "";
  String doble2player2 = "";
  String doble2rival1 = "";
  String doble2rival2 = "";

  String doble3player1 = "";
  String doble3player2 = "";
  String doble3rival1 = "";
  String doble3rival2 = "";

  String doble4player1 = "";
  String doble4player2 = "";
  String doble4rival1 = "";
  String doble4rival2 = "";

  String doble5player1 = "";
  String doble5player2 = "";
  String? doble5rival1;
  String? doble5rival2;

  String singlePlayer = "";
  String? singleRival;

  String? surface;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show();
    await getPlayers();
    await getCategories();
    EasyLoading.dismiss();
  }

  getCategories() async {
    final list = await getCategoriesFromStorage();
    setState(() {
      categories = list;
    });
  }

  getPlayers() async {
    final result = await listPlayers();

    if (result.isFailure) {
      return;
    }

    setState(() {
      players = result.getValue();
    });
  }

  goBack() {
    setState(() {
      step--;
    });
  }

  isClashWith5Dobles() {
    final list = ["5MM", "6MM"];
    return list.firstWhereOrNull(
                (element) => element == widget.clash.categoryName) ==
            null
        ? false
        : true;
  }

  void goStepTwo({
    required doble1player1,
    required doble1player2,
    required doble1rival1,
    required doble1rival2,
    required doble2player1,
    required doble2player2,
    required doble2rival1,
    required doble2rival2,
    required doble3player1,
    required doble3player2,
    required doble3rival1,
    required doble3rival2,
    required doble4player1,
    required doble4player2,
    required doble4rival1,
    required doble4rival2,
    required surface,
    doble5player1,
    doble5player2,
    doble5rival1,
    doble5rival2,
    singlePlayer,
    singleRival,
  }) {
    setState(() {
      this.doble1player1 = doble1player1;
      this.doble1player2 = doble1player2;
      this.doble1rival1 = doble1rival1;
      this.doble1rival2 = doble1rival2;
      this.doble2player1 = doble2player1;
      this.doble2player2 = doble2player2;
      this.doble2rival1 = doble2rival1;
      this.doble2rival2 = doble2rival2;
      this.doble3player1 = doble3player1;
      this.doble3player2 = doble3player2;
      this.doble3rival1 = doble3rival1;
      this.doble3rival2 = doble3rival2;
      this.doble4player1 = doble4player1;
      this.doble4player2 = doble4player2;
      this.doble4rival1 = doble4rival1;
      this.doble4rival2 = doble4rival2;
      this.doble5player1 = doble5player1;
      this.doble5player2 = doble5player2;
      this.doble5rival1 = doble5rival1;
      this.doble5rival2 = doble5rival2;
      this.singlePlayer = singlePlayer;
      this.singleRival = singleRival;
      this.surface = surface;
      step++;
    });
  }

  goStepFour() {
    setState(() {
      step++;
    });
  }

  Widget renderSteps() {
    if (step == 2) {
      final data = {
        'doble1player1': doble1player1,
        'doble1player2': doble1player2,
        'doble1rival1': doble1rival1,
        'doble1rival2': doble1rival2,
        'doble2player1': doble2player1,
        'doble2player2': doble2player2,
        'doble2rival1': doble2rival1,
        'doble2rival2': doble2rival2,
        'doble3player1': doble3player1,
        'doble3player2': doble3player2,
        'doble3rival1': doble3rival1,
        'doble3rival2': doble3rival2,
        'doble4player1': doble4player1,
        'doble4player2': doble4player2,
        'doble4rival1': doble4rival1,
        'doble4rival2': doble4rival2,
        'doble5player1': doble5player1,
        'doble5player2': doble5player2,
        'doble5rival1': doble5rival1,
        'doble5rival2': doble5rival2,
        'singlePlayer': singlePlayer,
        'singleRival': singleRival,
        "surface": surface,
      };

      return ListMatchesPreview(
        clash: widget.clash,
        categoryWith5dobles: isClashWith5Dobles(),
        players: players,
        goBack: goBack,
        data: data,
      );
    }
    return MatchesForm(
      players: players,
      goStepTwo: goStepTwo,
      doble1player1: doble1player1,
      doble1player2: doble1player2,
      doble1rival1: doble1rival1,
      doble1rival2: doble1rival2,
      doble2player1: doble2player1,
      doble2player2: doble2player2,
      doble2rival1: doble2rival1,
      doble2rival2: doble2rival2,
      doble3rival1: doble3rival1,
      doble3rival2: doble3rival2,
      doble3player1: doble3player1,
      doble3player2: doble3player2,
      doble4rival1: doble4rival1,
      doble4rival2: doble4rival2,
      doble4player1: doble4player1,
      doble4player2: doble4player2,
      doble5rival1: doble5rival1,
      doble5rival2: doble5rival2,
      doble5player1: doble4player1,
      doble5player2: doble5player2,
      singleRival: singleRival,
      singlePlayer: singlePlayer,
      categoryWith5dobles: isClashWith5Dobles(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return renderSteps();
  }
}
