import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/dtos/player_dto.dart';

class CreateMatchsStepOne extends StatefulWidget {
  const CreateMatchsStepOne({
    super.key,
    required this.players,
    required this.goStepTwo,
    required this.doble1player1,
    required this.doble1player2,
    required this.doble1rival1,
    required this.doble1rival2,
    required this.doble2player1,
    required this.doble2player2,
    required this.doble2rival1,
    required this.doble2rival2,
    required this.doble3player1,
    required this.doble3player2,
    required this.doble3rival1,
    required this.doble3rival2,
  });

  final Function goStepTwo;
  final List<PlayerDto> players;

  final String doble1player1;
  final String doble1player2;
  final String doble1rival1;
  final String doble1rival2;
  final String doble2player1;
  final String doble2player2;
  final String doble2rival1;
  final String doble2rival2;
  final String doble3player1;
  final String doble3player2;
  final String doble3rival1;
  final String doble3rival2;

  @override
  State<CreateMatchsStepOne> createState() => _CreateMatchsStepOneState();
}

class _CreateMatchsStepOneState extends State<CreateMatchsStepOne> {
  final formKey = GlobalKey<FormState>();

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

  handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      widget.goStepTwo(
        doble1player1: doble1player1,
        doble1player2: doble1player2,
        doble1rival1: doble1rival1,
        doble1rival2: doble1rival2,
        doble2player1: doble2player1,
        doble2player2: doble2player2,
        doble2rival1: doble2rival1,
        doble2rival2: doble2rival2,
        doble3player1: doble3player1,
        doble3player2: doble3player2,
        doble3rival1: doble3rival1,
        doble3rival2: doble3rival2,
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
          Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16, top: 16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Doble 1",
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
                            dropdownColor:
                                Theme.of(context).colorScheme.surface,
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
                                doble1player1 = value;
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
                            onSaved: (dynamic value) {
                              setState(() {
                                doble1rival1 = value;
                              });
                            },
                            initialValue: widget.doble1rival1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nombre del jugador rival";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
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
                            // value: widget.doble1player2,
                            onChanged: (dynamic value) {
                              setState(() {
                                doble1player2 = value;
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
                            onSaved: (String? value) {
                              setState(() {
                                doble1rival2 = value!;
                              });
                            },
                            initialValue: widget.doble1rival2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nombre del jugador rival";
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
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Doble 2",
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
                            // value: widget.doble2player1,
                            onChanged: (dynamic value) {
                              setState(() {
                                doble2player1 = value;
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
                            initialValue: widget.doble2rival1,
                            onChanged: (dynamic value) {
                              setState(() {
                                doble2rival1 = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nombre del jugador rival";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
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
                            // value: widget.doble2player2,
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
                                doble2player2 = value;
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
                            initialValue: widget.doble2rival2,
                            onSaved: (dynamic value) {
                              setState(() {
                                doble2rival2 = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nombre del jugador rival";
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
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Doble 3",
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
                                doble3player1 = value;
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
                                doble3rival1 = value;
                              });
                            },
                            initialValue: widget.doble3rival1,
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
                                doble3player2 = value;
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
                            initialValue: widget.doble3rival2,
                            onChanged: (dynamic value) {
                              setState(() {
                                doble3rival2 = value;
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
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: MyButton(
              text: "Continuar",
              onPress: () => handleSubmit(),
            ),
          ),
        ],
      ),
    );
  }
}
