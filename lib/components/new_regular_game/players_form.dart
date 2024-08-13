import "package:flutter/material.dart";
import "package:tennis_app/components/shared/button.dart";

import "../../domain/shared/utils.dart";

class PlayersForm extends StatefulWidget {
  final String mode;

  final void Function() back;
  final void Function({
    required String me,
    required String rival,
    required String partner,
    required String rival2,
  }) createGame;

  const PlayersForm({
    super.key,
    required this.back,
    required this.createGame,
    required this.mode,
  });

  @override
  State<PlayersForm> createState() => _PlayersFormState();
}

class _PlayersFormState extends State<PlayersForm> {
  final singleGameFormKey = GlobalKey<FormState>();
  final doubleGameFormKey = GlobalKey<FormState>();

  String me = "";
  String rival = "";
  String partner = "";
  String rival2 = "";

  @override
  Widget build(BuildContext context) {
    void onSubmitSingleGame() {
      if (singleGameFormKey.currentState!.validate()) {
        singleGameFormKey.currentState!.save();
        widget.createGame(
            me: me, partner: partner, rival: rival, rival2: rival2);
      }
    }

    void onSubmitDoubleGame() {
      if (doubleGameFormKey.currentState!.validate()) {
        doubleGameFormKey.currentState!.save();
        widget.createGame(
            me: me, partner: partner, rival: rival, rival2: rival2);
      }
    }

    if (widget.mode == GameMode.double) {
      return Form(
        key: doubleGameFormKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Jugador",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                onSaved: (String? value) {
                  me = value ?? "";
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el nombre del jugador";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Pareja",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                onSaved: (String? value) {
                  partner = value ?? "";
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el nombre de tu pareja";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Rival",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                onSaved: (String? value) {
                  rival = value ?? "";
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el nombre de tu rival";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Rival 2",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                onSaved: (String? value) {
                  rival2 = value ?? "";
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el nombre de tu segundo rival";
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: MyButton(
                        text: "Volver",
                        onPress: () => widget.back(),
                        color: Theme.of(context).colorScheme.error,
                        block: false,
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
                        onPress: () => onSubmitDoubleGame(),
                        block: false,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return Form(
        key: singleGameFormKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Jugador",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                onSaved: (String? value) {
                  me = value ?? "";
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el nombre del jugador";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Rival",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                onSaved: (String? value) {
                  rival = value ?? "";
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Ingresa el nombre de tu pareja";
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: MyButton(
                        onPress: () => widget.back(),
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
                        onPress: () => onSubmitSingleGame(),
                        block: false,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
