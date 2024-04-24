import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/league/statistics.dart';
import 'package:tennis_app/domain/shared/serve_flow.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';

import '../../domain/shared/utils.dart';
import '../game_buttons/game_end.dart';
import '../game_buttons/service/double_service.dart';
import '../game_buttons/service/single_service.dart';
import '../game_buttons/super_tiebreak.dart';
import 'howLost.dart';
import 'howWon.dart';
import 'initial.dart';
import 'whoLost.dart';
import 'wonWithReturn.dart';

class FullStatsTracker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FullStatsTracker();
}

enum Steps {
  initial,
  howWon,
  whoLost,
  howLost,
  wonWithReturn,
}

class _FullStatsTracker extends State<FullStatsTracker> {
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

    void setRally(int value) {
      if (value < 0) return;
      setState(() {
        rally = value;
      });
    }

    void ace() {
      gameProvider.ace(serviceNumber == 1);
      setRally(0);
      setState(() {
        serviceNumber = 1;
      });
    }

    void doubleFault() {
      gameProvider.doubleFault();
      setRally(0);
      setState(() {
        serviceNumber = 1;
      });
    }

    void servicePoint() {
      gameProvider.servicePoint(isFirstServe: serviceNumber == 1);
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

    void setStep(Steps value) {
      setState(() {
        this.actualStep = value;
      });
    }

    void setWinner(bool value) {
      setState(() {
        winner = value;
      });
    }

    void stepBack() {
      if (actualStep == Steps.wonWithReturn) {
        setState(() {
          returnWon = false;
          actualStep = Steps.initial;
        });
      }
      if (actualStep == Steps.howWon) {
        setState(() {
          actualStep = Steps.initial;
        });
      }
      if (actualStep == Steps.whoLost) {
        if (this.returnWon) {
          setState(() {
            actualStep = Steps.wonWithReturn;
          });
          return;
        }
        setState(() {
          actualStep = Steps.howWon;
        });
      }
      if (actualStep == Steps.howLost) {
        setState(() {
          actualStep = Steps.whoLost;
        });
      }
    }

    render() {
      if (actualStep == Steps.howWon) {
        return HowWon(
          setStep: setStep,
          setWinner: setWinner,
          winner: winner,
          setPlace1: setPlace1,
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
          setStep: setStep,
          setWinner: setWinner,
        );
      }
      return InitialButtons(
        rally: rally,
        ace: ace,
        setRally: setRally,
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
              child: Text(
                "Regresar",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            ElevatedButton(
              onPressed: actualStep == Steps.initial ? null : stepBack,
              child: Text(
                "Paso atrás",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 8)),
        if ((match.currentSetIdx + 1) == match.setsQuantity &&
            match.superTiebreak == null)
          const ChooseSuperTieBreak()
        else if (match.matchFinish == true)
          GameEnd(
              //finishMatchData: widget.finishMatchData,
              //finishMatchEvent: widget.finishMatch,
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
