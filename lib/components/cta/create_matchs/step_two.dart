import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/dtos/player_dto.dart';

class CreateMatchsStepTwo extends StatefulWidget {
  const CreateMatchsStepTwo({
    super.key,
    required this.players,
    required this.goStepThree,
    required this.goBack,
    required this.doble3player1,
    required this.doble3player2,
    required this.doble3rival1,
    required this.doble3rival2,
    required this.doble4player1,
    required this.doble4player2,
    required this.doble4rival1,
    required this.doble4rival2,
  });

  final String doble3player1;
  final String doble3player2;
  final String doble3rival1;
  final String doble3rival2;

  final String doble4player1;
  final String doble4player2;
  final String doble4rival1;
  final String doble4rival2;

  final Function goBack;
  final Function goStepThree;
  final List<PlayerDto> players;

  @override
  State<CreateMatchsStepTwo> createState() => _CreateMatchsStepTwoState();
}

class _CreateMatchsStepTwoState extends State<CreateMatchsStepTwo> {
  final formKey = GlobalKey<FormState>();

  String? doble3player1;
  String? doble3player2;
  String? doble3rival1;
  String? doble3rival2;

  String? doble4player1;
  String? doble4player2;
  String? doble4rival1;
  String? doble4rival2;

  handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      widget.goStepThree(
        doble3player1: doble3player1,
        doble3player2: doble3player2,
        doble3rival1: doble3rival1,
        doble3rival2: doble3rival2,
        doble4player1: doble4player1,
        doble4player2: doble4player2,
        doble4rival1: doble4rival1,
        doble4rival2: doble4rival2,
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
              Container(
                margin: const EdgeInsets.only(bottom: 16, top: 32),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Doble 3",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Doble 4",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                            doble4player1 = value;
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
                            doble4rival1 = value;
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
                            doble4player2 = value;
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
                            doble4rival2 = value;
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
