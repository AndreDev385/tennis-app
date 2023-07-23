import "package:flutter/material.dart";
import "package:tennis_app/components/shared/button.dart";
import "package:tennis_app/domain/game_rules.dart";

class ConfigForm extends StatefulWidget {
  const ConfigForm({super.key, required this.next});

  final void Function({
    required String mode,
    required int setsQuantity,
    required String surface,
    required int setType,
    required String direction,
  }) next;

  @override
  State<ConfigForm> createState() => _ConfigFormState();
}

class _ConfigFormState extends State<ConfigForm> {
  final configFormKey = GlobalKey<FormState>();

  bool superTiebreak = false;
  int setsQuantity = 3;

  String surface = Surfaces.hard;
  String mode = GameMode.single;
  int setType = GamesPerSet.regular;

  String direction = "";

  @override
  Widget build(BuildContext context) {
    void onSubmit(BuildContext context) {
      if (configFormKey.currentState!.validate()) {
        configFormKey.currentState!.save();
        widget.next(
          mode: mode,
          setType: setType,
          direction: direction,
          setsQuantity: setsQuantity,
          //superTiebreak: superTiebreak,
          surface: surface,
        );
      }
    }

    return Form(
      key: configFormKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Modo de juego",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: GameMode.single,
                  child: Text("Single"),
                ),
                DropdownMenuItem(
                  value: GameMode.double,
                  child: Text("Double"),
                )
              ],
              onChanged: (dynamic value) {
                setState(() {
                  mode = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return "Elige un modo de juego";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Cantidad de sets",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: SetsQuantity.singleSet,
                  child: Text("Uno"),
                ),
                DropdownMenuItem(
                  value: SetsQuantity.bestOfThree,
                  child: Text("Tres"),
                ),
                DropdownMenuItem(
                  value: SetsQuantity.bestOfFive,
                  child: Text("Cinco"),
                )
              ],
              onChanged: (dynamic value) {
                setState(() {
                  setsQuantity = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return "Elige la cantidad de sets";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Tipo de set",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: GamesPerSet.short,
                  child: Text("Corto (4 games)"),
                ),
                DropdownMenuItem(
                  value: GamesPerSet.regular,
                  child: Text("Regular (6 games)"),
                ),
                DropdownMenuItem(
                  value: GamesPerSet.pro,
                  child: Text("Pro (9 games)"),
                )
              ],
              onChanged: (dynamic value) {
                setState(() {
                  setType = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return "Elige el tipo de set";
                }
                return null;
              },
            ),
          ),
          /*Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: CheckboxListTile(
              title: const Text("Super tie break"),
              value: superTiebreak,
              onChanged: (bool? value) {
                setState(() {
                  superTiebreak = value!;
                });
              },
            ),
          ),*/
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Superficie",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: Surfaces.grass,
                  child: Text("Grama"),
                ),
                DropdownMenuItem(
                  value: Surfaces.clay,
                  child: Text("Arcilla"),
                ),
                DropdownMenuItem(
                  value: Surfaces.hard,
                  child: Text("Dura"),
                )
              ],
              onChanged: (dynamic value) {
                setState(() {
                  surface = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return "Elige la superficie";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Dirección",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              onSaved: (String? value) {
                setState(() {
                  direction = value ?? "";
                });
              },
            ),
          ),
          MyButton(
            text: "Continuar",
            onPress: () => onSubmit(context),
          ),
        ],
      ),
    );
  }
}
