import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tennis_app/styles.dart';

import '../shared/button.dart';

class SignInFormStepOne extends StatefulWidget {
  final Map<String, String> data;
  final Function(String value) setFirstName;
  final Function(String value) setLastName;
  final Function(String value) setCiType;
  final Function(String value) setCiValue;
  final Function() stepTwo;

  final GlobalKey<FormState> formKey;

  const SignInFormStepOne({
    required this.stepTwo,
    required this.data,
    required this.setFirstName,
    required this.setLastName,
    required this.setCiType,
    required this.setCiValue,
    required this.formKey,
  });

  @override
  SignInFormStepOneState createState() {
    return SignInFormStepOneState();
  }
}

class SignInFormStepOneState extends State<SignInFormStepOne> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
              initialValue: widget.data["firstName"],
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      MyTheme.regularBorderRadius,
                    ),
                  ),
                ),
              ),
              onSaved: (value) {
                widget.setFirstName(value!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un nombre";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Apellido",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      MyTheme.regularBorderRadius,
                    ),
                  ),
                ),
              ),
              initialValue: widget.data["lastName"],
              onSaved: (value) {
                widget.setLastName(value!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa un apellido";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: "Tipo de documento",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      MyTheme.regularBorderRadius,
                    ),
                  ),
                ),
              ),
              value:
                  widget.data["ciType"]!.isEmpty ? null : widget.data["ciType"],
              onChanged: (String? v) {
                widget.setCiType(v!);
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Elige un tipo de documento";
                }
                return null;
              },
              items: [
                DropdownMenuItem(
                  value: "V",
                  child: Text("Venezolano"),
                ),
                DropdownMenuItem(
                  value: "E",
                  child: Text("Extranjero"),
                ),
                DropdownMenuItem(
                  value: "P",
                  child: Text("Pasaporte"),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Cédula de identidad",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      MyTheme.regularBorderRadius,
                    ),
                  ),
                ),
              ),
              initialValue: widget.data["ciValue"],
              onSaved: (value) {
                widget.setCiValue(value!);
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa tu ci";
                }
                if (!value.isNumericOnly) {
                  return "Ingresa solo dígitos";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: MyButton(
              text: "Siguiente",
              onPress: () => widget.stepTwo(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Ya tienes cuenta?"),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/");
                },
                child: Text(
                  "Inicia sesión",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
