import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/advanced/place_buttons.dart';
import 'package:tennis_app/components/game_buttons/basic_buttons.dart';
import 'package:tennis_app/components/game_buttons/game_end.dart';
import 'package:tennis_app/components/game_buttons/intermediate/error_buttons.dart';
import 'package:tennis_app/components/game_buttons/intermediate/win_lost_point.dart';
import 'package:tennis_app/components/game_buttons/service/double_service.dart';
import 'package:tennis_app/components/game_buttons/service/single_service.dart';
import 'package:tennis_app/components/game_buttons/super_tiebreak.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/match.dart';
import 'initial_buttons.dart';

enum Steps {
  initial,
  winOrLose,
  place,
  errors,
}

class Rally {
  static const serve = 2;
  static const short = 4;
  static const medium = 9;
}

class AdvancedButtons extends StatefulWidget {
  const AdvancedButtons(
      {super.key,
      this.updateMatch,
      this.finishMatchData,
      this.finishMatch,
      this.renderRally = true,
      this.basicButtons = false});

  final bool renderRally;
  final bool basicButtons;

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

    Future<void> modalBuilder(Function goBack) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Estas seguro de eliminar el punto anterior?"),
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
                    goBack();
                    Navigator.of(context).pop();
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

    buttonStepBack() {
      setState(() {
        if (buttonOptions == Steps.initial) {
          return;
        }
        if (buttonOptions == Steps.winOrLose) {
          buttonOptions = Steps.initial;
        }
        if (buttonOptions == Steps.place) {
          buttonOptions = Steps.initial;
        }
        if (buttonOptions == Steps.errors) {
          buttonOptions = Steps.place;
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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary),
              onPressed: gameProvider.canGoBack
                  ? () => modalBuilder(gameProvider.goBack)
                  : null,
              child: Text(
                "Regresar",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            if (!widget.basicButtons)
              ElevatedButton(
                onPressed: buttonOptions == Steps.initial
                    ? null
                    : () => buttonStepBack(),
                child: const Text("Paso atrás"),
              )
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 16)),
        if ((match!.currentSetIdx + 1) == match.setsQuantity &&
            match.superTiebreak == null)
          const ChooseSuperTieBreak()
        else if (match.matchFinish == true)
          GameEnd(
            finishMatchData: widget.finishMatchData,
            finishMatchEvent: widget.finishMatch,
          )
        else if (setSingleService)
          const SetSingleService()
        else if (doubleServicecFirstStep)
          SetDoubleService(
            initialStep: 0,
          )
        else if (doubleServiceSecondStep || doubleNextSetFlow)
          SetDoubleService(
            initialStep: 1,
          )
        else if (widget.basicButtons)
          const BasicButtons()
        else if (buttonOptions == Steps.initial)
          AdvancedInitialButtons(
            renderRally: widget.renderRally,
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
          )
        else if (buttonOptions == Steps.winOrLose)
          WinLosePoint(
            setStep: setStep,
            setWinPoint: setWinPoint,
          )
        else if (buttonOptions == Steps.place)
          AdvancedPlaceButtons(
            setStep: setStep,
            setPlace: setPlace,
            placePoint: placePoint,
            isFirstServe: serviceNumber == 1,
            selectedPlayer: selectedPlayer,
            winPoint: winPoint,
            rally: rally,
            resetRally: resetRally,
            servicePoint: servicePoint,
          )
        else if (buttonOptions == Steps.errors)
          ErrorButtons(
            setStep: setStep,
            selectedPlayer: selectedPlayer,
            placePoint: placePoint,
          )
      ],
    );
  }
}
