import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/dtos/player_dto.dart';

class CreateMatchsStepThree extends StatefulWidget {
  const CreateMatchsStepThree({
    super.key,
    required this.categoryWith5dobles,
    required this.players,
    required this.goStepFour,
    required this.goBack,
    required this.doble5player1,
    required this.doble5player2,
    required this.doble5rival1,
    required this.doble5rival2,
    required this.singlePlayer,
    required this.singleRival,
  });

  final bool categoryWith5dobles;

  final String? doble5player1;
  final String? doble5player2;
  final String? doble5rival1;
  final String? doble5rival2;

  final String? singlePlayer;
  final String? singleRival;

  final Function goBack;
  final Function goStepFour;
  final List<PlayerDto> players;

  @override
  State<CreateMatchsStepThree> createState() => _CreateMatchsStepThreeState();
}

class _CreateMatchsStepThreeState extends State<CreateMatchsStepThree> {
  final formKey = GlobalKey<FormState>();

  String? doble5player1;
  String? doble5player2;
  String? doble5rival1;
  String? doble5rival2;

  String? singlePlayer;
  String? singleRival;

  handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      widget.goStepFour(
        singlePlayer: singlePlayer,
        singleRival: singleRival,
        doble5player1: doble5player1,
        doble5player2: doble5player2,
        doble5rival1: doble5rival1,
        doble5rival2: doble5rival2,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!widget.categoryWith5dobles)
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Single",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Jugador",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          items: widget.players
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.playerId,
                                  child: Text(
                                      "${e.user.firstName} ${e.user.lastName}"),
                                ),
                              )
                              .toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              singlePlayer = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Elige un jugador";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Rival",
                          ),
                          onSaved: (dynamic value) {
                            setState(() {
                              singleRival = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nombre del jugador";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (widget.categoryWith5dobles)
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Doble 5",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Jugador 1",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          items: widget.players
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.playerId,
                                  child: Text(
                                      "${e.user.firstName} ${e.user.lastName}"),
                                ),
                              )
                              .toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              doble5player1 = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Elige un jugador";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Rival 1",
                          ),
                          onChanged: (dynamic value) {
                            setState(() {
                              doble5rival1 = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nombre del jugador";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Jugador 2",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          items: widget.players
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.playerId,
                                  child: Text(
                                      "${e.user.firstName} ${e.user.lastName}"),
                                ),
                              )
                              .toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              doble5player2 = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Elige un jugador";
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Rival 2",
                          ),
                          onChanged: (dynamic value) {
                            setState(() {
                              doble5rival2 = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nombre del jugador";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: MyButton(
                        onPress: () => widget.goBack(),
                        text: "Volver",
                        block: false,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: MyButton(
                        text: "Continuar",
                        onPress: () => handleSubmit(),
                        block: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
