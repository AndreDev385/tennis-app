import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/league/statistics.dart';
import '../../../domain/shared/utils.dart';
import '../../../providers/game_rules.dart';
import '../../../styles.dart';
import 'advanced_buttons.dart';


class AdvancedPlaceButtons extends StatefulWidget {
  final bool isFirstServe;

  final Function() resetRally;
  final Function() servicePoint;
  final Function({
    required bool noForcedError,
    required bool winner,
  }) placePoint;
  final Function(int value) setPlace;
  final int rally;
  final bool? winPoint;
  final int? selectedPlayer;
  final void Function(Steps value) setStep;

  const AdvancedPlaceButtons({
    super.key,
    required this.setStep,
    required this.rally,
    required this.placePoint,
    required this.setPlace,
    required this.isFirstServe,
    required this.resetRally,
    required this.servicePoint,
    this.selectedPlayer = 0,
    this.winPoint,
  });

  @override
  State<AdvancedPlaceButtons> createState() => _AdvancedPlaceButtonsState();
}

class _AdvancedPlaceButtonsState extends State<AdvancedPlaceButtons> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    bool showFailedReturningButton() {
      if (gameProvider.match!.mode == GameMode.single) {
        return gameProvider.match!.servingTeam == 0 &&
                widget.winPoint == true ||
            gameProvider.match!.servingTeam == 1 && widget.winPoint == false;
      }
      return (gameProvider.match!.isPlayerReturning(widget.selectedPlayer!) &&
              widget.winPoint == false) ||
          (gameProvider.match!.isPlayerServing(widget.selectedPlayer!) &&
              widget.winPoint == true);
    }

    bool showSuccessReturningButton() {
      if (gameProvider.match!.mode == GameMode.single) {
        return gameProvider.match?.servingTeam == 1 && widget.winPoint == true;
      }
      return gameProvider.match!.isPlayerReturning(widget.selectedPlayer!) &&
          widget.winPoint == true;
    }

    bool rallyForReturnLost() {
      return widget.rally == 0;
    }

    bool rallyForReturnWin() {
      return widget.rally < 2;
    }

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      height: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.regularBorderRadius,
                            ),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          widget.setStep(Steps.errors);
                          widget.setPlace(PlacePoint.bckg);
                        },
                        child: Text(
                          "Fondo / Approach",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 4),
                      height: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MyTheme.regularBorderRadius,
                            ),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          widget.setStep(Steps.errors);
                          widget.setPlace(PlacePoint.mesh);
                        },
                        child: Text(
                          "Malla",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if ((showFailedReturningButton() && rallyForReturnLost()) ||
                (showSuccessReturningButton() && rallyForReturnWin()))
              Expanded(
                child: Row(
                  children: [
                    if (showFailedReturningButton() && rallyForReturnLost())
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          height: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  MyTheme.regularBorderRadius,
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () => widget.servicePoint(),
                            child: Text(
                              "Saque no devuelto",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    if (showSuccessReturningButton() && rallyForReturnWin())
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          height: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  MyTheme.regularBorderRadius,
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              widget.setStep(Steps.errors);
                              widget.setPlace(PlacePoint.wonReturn);
                            },
                            child: Text(
                              "Devolución ganada", // Devolución ganadora
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
