import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/game_buttons/advanced/advanced_buttons.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/domain/statistics.dart';

class AdvancedPlaceButtons extends StatefulWidget {
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

  final bool isFirstServe;
  final Function() resetRally;
  final Function() servicePoint;
  final Function() placePoint;
  final Function(int value) setPlace;
  final int rally;
  final bool? winPoint;
  final int? selectedPlayer;
  final void Function(Steps value) setStep;

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
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.setStep(Steps.errors);
                          widget.setPlace(PlacePoint.bckg);
                        },
                        child: const Text(
                          "Fondo / Approach",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, bottom: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.setStep(Steps.errors);
                          widget.setPlace(PlacePoint.mesh);
                        },
                        child: const Text(
                          "Malla",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8, top: 8),
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.setStep(Steps.initial);
                          widget.setPlace(PlacePoint.winner);
                          widget.placePoint();
                        },
                        child: const Text(
                          "Winner (Fondo / Approach)",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  if (showFailedReturningButton() && rallyForReturnLost())
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8, top: 8),
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => widget.servicePoint(),
                          child: const Text(
                            "Saque no devuelto",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  if (showSuccessReturningButton() && rallyForReturnWin())
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8, top: 8),
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.setStep(Steps.errors);
                            widget.setPlace(PlacePoint.wonReturn);
                          },
                          child: const Text(
                            "Devolución ganada", // Devolución ganadora
                            style: TextStyle(
                              fontSize: 24,
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
