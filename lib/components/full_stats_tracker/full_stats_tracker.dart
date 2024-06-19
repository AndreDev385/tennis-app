import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/full_stats_tracker/finish_game.dart';
import 'package:tennis_app/domain/league/statistics.dart';
import 'package:tennis_app/domain/shared/serve_flow.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';

import '../../domain/shared/utils.dart';
import '../game_buttons/service/double_service.dart';
import '../game_buttons/service/single_service.dart';
import '../game_buttons/super_tiebreak.dart';
import 'howLost.dart';
import 'howWon.dart';
import 'initial.dart';
import 'whoLost.dart';
import 'wonWithReturn.dart';

enum Steps {
  initial,
  howWon,
  whoLost,
  howLost,
  wonWithReturn,
}

class FullStatsTracker extends StatefulWidget {
  final Function finishTransmition;
  final Function updateTransmition;

  const FullStatsTracker({
    super.key,
    required this.finishTransmition,
    required this.updateTransmition,
  });

  @override
  State<StatefulWidget> createState() => _FullStatsTracker();
}

class _FullStatsTracker extends State<FullStatsTracker> {
  List<Steps> previousSteps = [Steps.initial];
  Steps actualStep = Steps.initial;
  int serviceNumber = 1;

  bool winner = false;
  bool returnWon = false;

  int? playerWhoWon;
  int? playerWhoLost;

  int? place1;
  int rally = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<TournamentMatchProvider>(context);
    TournamentMatch match = gameProvider.match!;

    bool setSingleService = gameProvider.match?.singleServeFlow == null &&
        gameProvider.match?.mode == GameMode.single;

    bool doubleServiceFirstStep = gameProvider.match?.doubleServeFlow == null &&
        gameProvider.match?.mode == GameMode.double;

    bool doubleServiceSecondStep =
        gameProvider.match?.doubleServeFlow?.isFlowComplete == false &&
            gameProvider.match?.doubleServeFlow?.actualSetOrder == 1;

    bool doubleNextSetFlow =
        gameProvider.match?.doubleServeFlow?.setNextFlow == true;

    bool chooseFinalSetType = (match.currentSetIdx + 1) == match.setsQuantity &&
        match.superTiebreak == null;

    bool matchIsOver = match.matchFinish == true;

    void setRally(int value) {
      if (value < 0) return;
      setState(() {
        rally = value;
      });
    }

    void ace() {
      gameProvider.ace(serviceNumber == 1);
      widget.updateTransmition();
      setRally(0);
      setState(() {
        serviceNumber = 1;
      });
    }

    void doubleFault() {
      gameProvider.doubleFault();
      widget.updateTransmition();
      setRally(0);
      setState(() {
        serviceNumber = 1;
      });
    }

    void servicePoint() {
      gameProvider.servicePoint(isFirstServe: serviceNumber == 1);
      widget.updateTransmition();
      setRally(0);
      setState(() {
        serviceNumber = 1;
      });
    }

    void placePoint(int place2, bool error) {
      gameProvider.placePoint(
        place1: place1!,
        place2: place2,
        isFirstServe: serviceNumber == 1,
        rally: rally,
        winner: winner,
        noForcedError: error,
        selectedPlayer1: playerWhoWon!,
        selectedPlayer2: playerWhoLost!,
      );
      widget.updateTransmition();
      setRally(0);
      setState(() {
        serviceNumber = 1;
      });
    }

    void secondService() {
      setState(() {
        serviceNumber = 2;
      });
    }

    void setPlace1(int place) {
      setState(() {
        place1 = place;
      });
    }

    void setPlayerWhoLost(int player) {
      setState(() {
        playerWhoLost = player;
      });
    }

    void setPlayerWhoWon(int player) {
      setState(() {
        playerWhoWon = player;
        if (match.mode == GameMode.single) {
          playerWhoLost =
              player == PlayersIdx.me ? PlayersIdx.rival : PlayersIdx.me;
        }
      });
    }

    void setReturnWon(bool value) {
      setState(() {
        returnWon = value;
        place1 = PlacePoint.wonReturn;
      });
    }

    void setWinner(bool value) {
      setState(() {
        winner = value;
      });
    }

    void setStep(Steps value) {
      setState(() {
        if (value == Steps.initial) {
          this.previousSteps = [Steps.initial];
        } else {
          this.previousSteps.add(value);
        }
        this.actualStep = value;
      });
    }

    void stepBack() {
      setState(() {
        this.previousSteps.removeLast();
        this.actualStep = this.previousSteps.last;
      });
    }

    render() {
      if (actualStep == Steps.howWon) {
        return HowWon(
          setStep: setStep,
          setWinner: setWinner,
          setPlace1: setPlace1,
          isSingle: match.mode == GameMode.single,
        );
      }
      if (actualStep == Steps.whoLost) {
        return WhoLost(
          setStep: setStep,
          playerWhoWon: playerWhoWon!,
          setPlayerWhoLost: setPlayerWhoLost,
        );
      }
      if (actualStep == Steps.howLost) {
        return HowLost(
          setStep: setStep,
          winner: winner,
          placePoint: placePoint,
        );
      }
      if (actualStep == Steps.wonWithReturn) {
        return WonWithReturn(
          isSingle: match.mode == GameMode.single,
          setStep: setStep,
          setWinner: setWinner,
        );
      }
      return InitialButtons(
        rally: rally,
        ace: ace,
        setRally: setRally,
        setPlace1: setPlace1,
        serviceNumber: serviceNumber,
        secondService: secondService,
        doubleFault: doubleFault,
        setStep: setStep,
        setReturnWon: setReturnWon,
        setPlayerWhoWon: setPlayerWhoWon,
        servicePoint: servicePoint,
      );
    }

    void goBack() {
      gameProvider.goBack();
      setState(() {
        actualStep = Steps.initial;
        serviceNumber = 1;

        winner = false;
        returnWon = false;

        playerWhoWon = null;
        playerWhoLost = null;

        place1 = null;
        rally = 0;
      });
      widget.updateTransmition();
    }

    Future<void> modalBuilder(Function goBack) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Estas seguro de eliminar el punto anterior?"),
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
                    goBack();
                    Navigator.of(context).pop();
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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
              ),
              onPressed:
                  gameProvider.canGoBack ? () => modalBuilder(goBack) : null,
              child: Text("Regresar"),
            ),
            ElevatedButton(
              onPressed: actualStep == Steps.initial ? null : stepBack,
              child: Text("Paso atrás"),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 8)),
        if (chooseFinalSetType)
          const ChooseSuperTieBreak(isTournamentProvider: true)
        else if (matchIsOver)
          FinishMatch(
            finishTrasmition: widget.finishTransmition,
          )
        else if (setSingleService)
          const SetSingleService(isTournamentProvider: true)
        else if (doubleServiceFirstStep || doubleNextSetFlow)
          SetDoubleService(
            initialStep: 0,
            isTournamentProvider: true,
          )
        else if (doubleServiceSecondStep)
          SetDoubleService(
            initialStep: 1,
            isTournamentProvider: true,
          )
        else
          render(),
      ],
    );
  }
}
