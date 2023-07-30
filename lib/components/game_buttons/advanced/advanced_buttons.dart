import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/advanced/place_buttons.dart';
import 'package:tennis_app/components/game_buttons/game_end.dart';
import 'package:tennis_app/components/game_buttons/intermediate/error_buttons.dart';
import 'package:tennis_app/components/game_buttons/intermediate/win_lost_point.dart';
import 'package:tennis_app/components/game_buttons/service/double_service.dart';
import 'package:tennis_app/components/game_buttons/service/single_service.dart';
import 'package:tennis_app/components/game_buttons/super_tiebreak.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import '../intermediate/intermediate_buttons.dart';
import 'initial_buttons.dart';

class Rally {
  static const serve = 2;
  static const short = 4;
  static const medium = 9;
}

class AdvancedButtons extends StatefulWidget {
  const AdvancedButtons({
    super.key,
    this.updateMatch,
    this.finishMatchData,
    this.finishMatch,
  });

  final Function? finishMatchData;
  final Function? updateMatch;
  final Function? finishMatch;

  @override
  State<AdvancedButtons> createState() => _AdvancedButtons();
}

class _AdvancedButtons extends State<AdvancedButtons> {
  Steps buttonOptions = Steps.initial;
  bool? winPoint;
  int? selectedPlayer;
  int? place;
  int serviceNumber = 1;
  int rally = 0;

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

  void incrementRally() {
    setState(() {
      rally++;
    });
  }

  void decrementRally() {
    if (rally == 0) {
      return;
    }
    setState(() {
      rally--;
    });
  }

  void resetRally() {
    setState(() {
      rally = 0;
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
        rally: rally,
      );
      firstService();
      resetRally();
      if (widget.updateMatch != null) {
        widget.updateMatch!();
      }
    }

    void servicePoint() {
      setStep(Steps.initial);
      gameProvider.servicePoint(
        isFirstServe: serviceNumber == 1,
      );
      if (widget.updateMatch != null) {
        widget.updateMatch!();
      }
      firstService();
      resetRally();
    }

    void ace() {
      gameProvider.ace(serviceNumber == 1);
      if (widget.updateMatch != null) {
        widget.updateMatch!();
      }
      firstService();
      resetRally();
    }

    void secondServiceAndDobleFault() {
      setState(() {
        if (serviceNumber == 2) {
          firstService();
          resetRally();
          gameProvider.doubleFault();
          if (widget.updateMatch != null) {
            widget.updateMatch!();
          }
        } else {
          secondService();
        }
      });
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
      return GameEnd(
        finishMatchData: widget.finishMatchData,
        finishMatchEvent: widget.finishMatch,
      );
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
      return AdvancedInitialButtons(
        ace: ace,
        secondServiceAndDobleFault: secondServiceAndDobleFault,
        setStep: setStep,
        selectPlayer: selectPlayer,
        setWinPoint: setWinPoint,
        serviceNumber: serviceNumber,
        firstService: firstService,
        secondService: secondService,
        incrementRally: incrementRally,
        decrementRally: decrementRally,
        resetRally: resetRally,
        rally: rally,
      );
    }
    if (buttonOptions == Steps.winOrLose) {
      return WinLosePoint(
        setStep: setStep,
        setWinPoint: setWinPoint,
      );
    }
    if (buttonOptions == Steps.place) {
      return AdvancedPlaceButtons(
        setStep: setStep,
        setPlace: setPlace,
        placePoint: placePoint,
        isFirstServe: serviceNumber == 1,
        selectedPlayer: selectedPlayer,
        winPoint: winPoint,
        rally: rally,
        resetRally: resetRally,
        servicePoint: servicePoint,
      );
    }
    if (buttonOptions == Steps.errors) {
      return ErrorButtons(
        setStep: setStep,
        selectedPlayer: selectedPlayer,
        placePoint: placePoint,
      );
    }
    return AdvancedInitialButtons(
      ace: ace,
      secondServiceAndDobleFault: secondServiceAndDobleFault,
      setStep: setStep,
      selectPlayer: selectPlayer,
      setWinPoint: setWinPoint,
      serviceNumber: serviceNumber,
      firstService: firstService,
      secondService: secondService,
      incrementRally: incrementRally,
      decrementRally: decrementRally,
      resetRally: resetRally,
      rally: rally,
    );
  }
}
