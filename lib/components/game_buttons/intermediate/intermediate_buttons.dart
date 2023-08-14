import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/advanced/advanced_buttons.dart';
import 'package:tennis_app/components/game_buttons/game_end.dart';
import 'package:tennis_app/components/game_buttons/service/double_service.dart';
import 'package:tennis_app/components/game_buttons/service/single_service.dart';
import 'package:tennis_app/components/game_buttons/super_tiebreak.dart';
import '../../../domain/match.dart';

import 'package:tennis_app/domain/game_rules.dart';
import 'initial_buttons.dart';
import 'win_lost_point.dart';
import 'error_buttons.dart';
import 'place_buttons.dart';


class IntermediateButtons extends StatefulWidget {
  const IntermediateButtons({super.key});

  @override
  State<IntermediateButtons> createState() => _IntermediateButtons();
}

class _IntermediateButtons extends State<IntermediateButtons> {
  Steps buttonOptions = Steps.initial;
  bool? winPoint;
  int? selectedPlayer;
  int? place;
  int serviceNumber = 1;

  void setStep(Steps value) {
    setState(() {
      buttonOptions = value;
    });
  }

  void selectPlayer(int player) {
    setState(() {
      selectedPlayer = player;
    });
  }

  void setWinPoint(bool win) {
    setState(() {
      winPoint = win;
    });
  }

  void setPlace(int value) {
    setState(() {
      place = value;
    });
  }

  void firstService() {
    setState(() {
      serviceNumber = 1;
    });
  }

  void secondService() {
    setState(() {
      serviceNumber = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);
    Match? match = gameProvider.match;

    void placePoint({bool noForcedError = false}) {
      gameProvider.placePoint(
        place: place!,
        selectedPlayer: selectedPlayer ?? 0,
        winPoint: winPoint!,
        isFirstServe: serviceNumber == 1,
        noForcedError: noForcedError,
      );
      firstService();
    }

    bool setSingleService = gameProvider.match?.singleServeFlow == null &&
        gameProvider.match?.mode == GameMode.single;

    bool doubleServicecFirstStep =
        gameProvider.match?.doubleServeFlow == null &&
            gameProvider.match?.mode == GameMode.double;

    bool doubleServiceSecondStep =
        gameProvider.match?.doubleServeFlow?.isFlowComplete == false &&
            gameProvider.match?.doubleServeFlow?.actualSetOrder == 1;

    bool doubleNextSetFlow =
        gameProvider.match?.doubleServeFlow?.setNextFlow == true;

    if ((match!.currentSetIdx + 1) == match.setsQuantity &&
        match.superTiebreak == null) {
      return const ChooseSuperTieBreak();
    }

    if (match.matchFinish == true) {
      return const GameEnd();
    }

    if (setSingleService) {
      return const SetSingleService();
    }
    if (doubleServicecFirstStep) {
      return SetDoubleService(
        initialStep: 0,
      );
    }
    if (doubleServiceSecondStep || doubleNextSetFlow) {
      return SetDoubleService(
        initialStep: 1,
      );
    }
    if (buttonOptions == Steps.initial) {
      return IntermediateInitialButtons(
        setStep: setStep,
        selectPlayer: selectPlayer,
        setWinPoint: setWinPoint,
        serviceNumber: serviceNumber,
        firstService: firstService,
        secondService: secondService,
      );
    }
    if (buttonOptions == Steps.winOrLose) {
      return WinLosePoint(
        setStep: setStep,
        setWinPoint: setWinPoint,
      );
    }
    if (buttonOptions == Steps.place) {
      return PlaceButtons(
        setStep: setStep,
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
        placePoint: placePoint,
        setPlace: setPlace,
        isFirstServe: serviceNumber == 1,
        firstService: firstService,
      );
    }
    if (buttonOptions == Steps.errors) {
      return ErrorButtons(
        setStep: setStep,
        selectedPlayer: selectedPlayer,
        placePoint: placePoint,
      );
    }
    return IntermediateInitialButtons(
      serviceNumber: serviceNumber,
      setStep: setStep,
      setWinPoint: setWinPoint,
      selectPlayer: selectPlayer,
      firstService: firstService,
      secondService: secondService,
    );
  }
}
