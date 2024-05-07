import 'package:flutter/material.dart';
import 'package:tennis_app/domain/shared/set.dart';

import '../../../domain/shared/utils.dart';
import '../../../domain/tournament/bracket.dart';
import '../../../services/tournaments/match/create_bracket_match.dart';
import '../../../styles.dart';
import '../../../utils/format_player_name.dart';
import '../../shared/toast.dart';

class BracketCard extends StatelessWidget {
  final Bracket bracket;

  const BracketCard({
    super.key,
    required this.bracket,
  });

  @override
  Widget build(BuildContext context) {
    _buildNameForDisplay(Place place) {
      if (place.couple != null) {
        return "${shortNameFormat(place.couple!.p1.firstName, place.couple!.p1.lastName)} / ${formatName(place.couple!.p2.firstName, place.couple!.p2.lastName)}";
      }
      if (place.participant != null) {
        return "${formatName(place.participant!.firstName, place.participant!.lastName)}";
      }
      return "";
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => modalBuilder(context),
        child: Column(
          children: [
            BracketRow(
              isTop: true,
              hasWon: bracket.match?.matchWon != null
                  ? bracket.match!.matchWon!
                  : false,
              name: _buildNameForDisplay(bracket.rightPlace),
              number: bracket.rightPlace.value,
              sets: bracket.match?.sets,
            ),
            Divider(color: Theme.of(context).colorScheme.secondary, height: .1),
            BracketRow(
              isTop: false,
              hasWon: bracket.match?.matchWon! != null
                  ? !bracket.match!.matchWon!
                  : false,
              name: _buildNameForDisplay(bracket.leftPlace),
              number: bracket.leftPlace.value,
              sets: bracket.match?.sets,
            ),
          ],
        ),
      ),
    );
  }

  createMatch(BuildContext context, String surface) async {
    Navigator.pop(context);
    final result = await createBracketMatch(bracket.id, surface);

    if (result.isFailure) {
      showMessage(context, result.error!, ToastType.error);
      return;
    }

    showMessage(context, "Partido creado con exito!", ToastType.success);
  }

  modalBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          String surface = Surfaces.hard;
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: const Text("Crear partido"),
                content: Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Crea el partido de la llave seleccionada"),
                      DropdownButtonFormField(
                        value: surface,
                        decoration: const InputDecoration(
                          labelText: "Superficie",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        onChanged: (String? value) {
                          print("value: $value");
                          setState(() {
                            surface = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: Surfaces.hard,
                            child: Text(Surfaces.hard),
                          ),
                          DropdownMenuItem(
                            value: Surfaces.clay,
                            child: Text(Surfaces.clay),
                          ),
                          DropdownMenuItem(
                            value: Surfaces.grass,
                            child: Text(Surfaces.grass),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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
                      createMatch(context, surface);
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
            },
          );
        });
  }
}

class BracketRow extends StatelessWidget {
  final bool isTop;
  final bool hasWon;
  final int? number;
  final String name;
  final List<Set<Stats>>? sets;

  const BracketRow({
    super.key,
    required this.name,
    required this.isTop,
    required this.sets,
    this.hasWon = false,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: this.hasWon
              ? Theme.of(context).brightness == Brightness.light
                  ? Colors.greenAccent[100]
                  : Color(0x9900c853)
              : null,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isTop ? 16 : 0),
            topRight: Radius.circular(isTop ? 16 : 0),
            bottomLeft: Radius.circular(isTop ? 0 : 16),
            bottomRight: Radius.circular(isTop ? 0 : 16),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    if (number != null)
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text("$number"),
                      ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        name,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (hasWon) Icon(Icons.check, color: MyTheme.green),
                  ],
                )
              ],
            ),
            if (sets != null && sets!.length > 0)
              Container(
                constraints: BoxConstraints(maxWidth: 84),
                child: Row(
                  children: [
                    ListView.builder(
                      itemCount: sets!.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, idx) {
                        final currSet = sets![idx];

                        int gamesWon;
                        int tiebreakPts;
                        bool wonSet;

                        if (!isTop) {
                          gamesWon = currSet.rivalGames;
                          tiebreakPts = currSet.rivalTiebreakPoints;
                          wonSet = currSet.loseSet;
                        } else {
                          gamesWon = currSet.myGames;
                          tiebreakPts = currSet.myTiebreakPoints;
                          wonSet = currSet.winSet;
                        }

                        bool IS_VOID_SET =
                            currSet.myGames == 0 && currSet.rivalGames == 0;

                        if (IS_VOID_SET) {
                          return SizedBox();
                        }

                        return SizedBox(
                          width: 28,
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$gamesWon",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: wonSet ? FontWeight.bold : null,
                                    color: wonSet
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                                ),
                                if (currSet.tiebreak)
                                  Padding(
                                    padding: EdgeInsets.only(left: 1),
                                    child: Text(
                                      "$tiebreakPts",
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
