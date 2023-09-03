import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/dtos/player_dto.dart';
import 'package:search_choices/search_choices.dart';
import 'package:tennis_app/utils/format_player_name.dart';

class MatchesForm extends StatefulWidget {
  const MatchesForm({
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
    required this.doble4rival1,
    required this.doble4rival2,
    required this.doble4player1,
    required this.doble4player2,
    required this.categoryWith5dobles,
    this.singleRival,
    this.singlePlayer,
    this.doble5rival1,
    this.doble5rival2,
    this.doble5player1,
    this.doble5player2,
    this.surface,
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

  final String doble4player1;
  final String doble4player2;
  final String doble4rival1;
  final String doble4rival2;

  final String? doble5player1;
  final String? doble5player2;
  final String? doble5rival1;
  final String? doble5rival2;

  final String? singlePlayer;
  final String? singleRival;

  final String? surface;

  final bool categoryWith5dobles;

  @override
  State<MatchesForm> createState() => _MatchesFormState();
}

class _MatchesFormState extends State<MatchesForm> {
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

  String doble4player1 = "";
  String doble4player2 = "";
  String doble4rival1 = "";
  String doble4rival2 = "";

  String doble5player1 = "";
  String doble5player2 = "";
  String? doble5rival1 = "";
  String? doble5rival2 = "";

  String singlePlayer = "";
  String? singleRival = "";

  List<String> surfaces = [
    "Grama",
    "Arcilla",
    "Dura",
  ];

  late String surface;

  @override
  void initState() {
    doble1player1 = widget.doble1player1;
    doble1player2 = widget.doble1player2;
    doble1rival1 = widget.doble1rival1;
    doble1rival2 = widget.doble1rival2;

    doble2player1 = widget.doble2player1;
    doble2player2 = widget.doble2player2;
    doble2rival1 = widget.doble2rival1;
    doble2rival2 = widget.doble2rival2;

    doble3player1 = widget.doble3player1;
    doble3player2 = widget.doble3player2;
    doble3rival1 = widget.doble3rival1;
    doble3rival2 = widget.doble3rival2;

    doble4player1 = widget.doble4player1;
    doble4player2 = widget.doble4player2;
    doble4rival1 = widget.doble4rival1;
    doble4rival2 = widget.doble4rival2;

    doble5player1 = widget.doble5player1 ?? "";
    doble5player2 = widget.doble5player2 ?? "";
    doble5rival1 = widget.doble5rival1 ?? "";
    doble5rival2 = widget.doble5rival2 ?? "";

    singlePlayer = widget.singlePlayer ?? "";
    singleRival = widget.singleRival ?? "";

    surface = widget.surface ?? "";
    super.initState();
  }

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
        doble4rival1: doble4rival1,
        doble4rival2: doble4rival2,
        doble4player1: doble4player1,
        doble4player2: doble4player2,
        doble5player1: doble5player1,
        doble5player2: doble5player2,
        doble5rival1: doble5rival1,
        doble5rival2: doble5rival2,
        singlePlayer: singlePlayer,
        singleRival: singleRival,
        surface: surface,
      );
    }
  }

  List<int> searchFn(String keyword, items) {
    List<int> ret = [];

    if (items != null && keyword.isNotEmpty) {
      for (var i = 0; i < items.length; i++) {
        if (items[i].value.toLowerCase().contains(keyword.toLowerCase())) {
          ret.add(i);
        }
      }
    } else {
      ret = Iterable<int>.generate(items.length).toList();
    }
    return (ret);
  }

  mapPlayersToOptions() {
    return widget.players
        .map(
          (e) => DropdownMenuItem(
            value: formatPlayerName(e),
            child: Text(formatPlayerName(e)),
          ),
        )
        .toList();
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
                          child: SearchChoices.single(
                            onChanged: (dynamic value) {
                              setState(() {
                                doble1player1 = value;
                              });
                            },
                            value: doble1player1,
                            searchFn: searchFn,
                            isExpanded: true,
                            hint: "Elige un jugador",
                            validator: (value) {
                              if (value == null) {
                                return "Elige un jugador";
                              }
                              return null;
                            },
                            items: mapPlayersToOptions(),
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
                          child: SearchChoices.single(
                            onChanged: (dynamic value) {
                              setState(() {
                                doble1player2 = value;
                              });
                            },
                            value: doble1player2,
                            searchFn: searchFn,
                            isExpanded: true,
                            hint: "Elige un jugador",
                            validator: (value) {
                              if (value == null) {
                                return "Elige un jugador";
                              }
                              return null;
                            },
                            items: mapPlayersToOptions(),
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
                          child: SearchChoices.single(
                            onChanged: (dynamic value) {
                              setState(() {
                                doble2player1 = value;
                              });
                            },
                            value: doble2player1,
                            searchFn: searchFn,
                            isExpanded: true,
                            hint: "Elige un jugador",
                            validator: (value) {
                              if (value == null) {
                                return "Elige un jugador";
                              }
                              return null;
                            },
                            items: mapPlayersToOptions(),
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
                          child: SearchChoices.single(
                            onChanged: (dynamic value) {
                              setState(() {
                                doble2player2 = value;
                              });
                            },
                            value: doble2player2,
                            searchFn: searchFn,
                            isExpanded: true,
                            hint: "Elige un jugador",
                            validator: (value) {
                              if (value == null) {
                                return "Elige un jugador";
                              }
                              return null;
                            },
                            items: mapPlayersToOptions(),
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
                          child: SearchChoices.single(
                            onChanged: (dynamic value) {
                              setState(() {
                                doble3player1 = value;
                              });
                            },
                            value: doble3player1,
                            searchFn: searchFn,
                            isExpanded: true,
                            hint: "Elige un jugador",
                            validator: (value) {
                              if (value == null) {
                                return "Elige un jugador";
                              }
                              return null;
                            },
                            items: mapPlayersToOptions(),
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
                          child: SearchChoices.single(
                            onChanged: (dynamic value) {
                              setState(() {
                                doble3player2 = value;
                              });
                            },
                            value: doble3player2,
                            searchFn: searchFn,
                            isExpanded: true,
                            hint: "Elige un jugador",
                            validator: (value) {
                              if (value == null) {
                                return "Elige un jugador";
                              }
                              return null;
                            },
                            items: mapPlayersToOptions(),
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
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16, top: 16),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Doble 4",
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
                          child: SearchChoices.single(
                            onChanged: (dynamic value) {
                              setState(() {
                                doble4player1 = value;
                              });
                            },
                            value: doble4player1,
                            searchFn: searchFn,
                            isExpanded: true,
                            hint: "Elige un jugador",
                            validator: (value) {
                              if (value == null) {
                                return "Elige un jugador";
                              }
                              return null;
                            },
                            items: mapPlayersToOptions(),
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
                            initialValue: widget.doble4rival1,
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
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchChoices.single(
                            onChanged: (dynamic value) {
                              setState(() {
                                doble4player2 = value;
                              });
                            },
                            value: doble4player2,
                            searchFn: searchFn,
                            isExpanded: true,
                            hint: "Elige un jugador",
                            validator: (value) {
                              if (value == null) {
                                return "Elige un jugador";
                              }
                              return null;
                            },
                            items: mapPlayersToOptions(),
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
                            initialValue: widget.doble4rival2,
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
                            child: SearchChoices.single(
                              onChanged: (dynamic value) {
                                setState(() {
                                  singlePlayer = value;
                                });
                              },
                              value: singlePlayer,
                              searchFn: searchFn,
                              isExpanded: true,
                              hint: "Elige un jugador",
                              validator: (value) {
                                if (value == null) {
                                  return "Elige un jugador";
                                }
                                return null;
                              },
                              items: mapPlayersToOptions(),
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
                              initialValue: widget.singleRival,
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
                            child: SearchChoices.single(
                              onChanged: (dynamic value) {
                                setState(() {
                                  doble5player1 = value;
                                });
                              },
                              value: doble5player1,
                              searchFn: searchFn,
                              isExpanded: true,
                              hint: "Elige un jugador",
                              validator: (value) {
                                if (value == null) {
                                  return "Elige un jugador";
                                }
                                return null;
                              },
                              items: mapPlayersToOptions(),
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
                              initialValue: widget.doble5rival1,
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
                            child: SearchChoices.single(
                              onChanged: (dynamic value) {
                                setState(() {
                                  doble5player2 = value;
                                });
                              },
                              value: doble5player2,
                              searchFn: searchFn,
                              isExpanded: true,
                              hint: "Elige un jugador",
                              validator: (value) {
                                if (value == null) {
                                  return "Elige un jugador";
                                }
                                return null;
                              },
                              items: mapPlayersToOptions(),
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
                              initialValue: widget.doble5rival2,
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
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Superficie",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                items: surfaces
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    surface = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Elige una superficie";
                  }
                  return null;
                },
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
