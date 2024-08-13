import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';
import '../shared/button.dart';

class SignInFormStepTwo extends StatefulWidget {
  final Function(String value) setEmail;
  final Function(String value) setPassword;
  final Function(String value) setPassword2;
  final GlobalKey<FormState> formKey;
  final Function() goBack;
  final Function(BuildContext c) submit;

  const SignInFormStepTwo({
    super.key,
    required this.submit,
    required this.goBack,
    required this.setEmail,
    required this.setPassword,
    required this.setPassword2,
    required this.formKey,
  });

  @override
  SignInFormStepTwoState createState() {
    return SignInFormStepTwoState();
  }
}

class SignInFormStepTwoState extends State<SignInFormStepTwo> {
  String password = "";
  String password2 = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Correo",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          MyTheme.regularBorderRadius,
                        ),
                      ),
                    ),
                  ),
                  onSaved: (value) {
                    widget.setEmail(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ingresa un correo";
                    }
                    bool valid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!valid) {
                      return "Email invalido";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          MyTheme.regularBorderRadius,
                        ),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  onSaved: (value) {
                    widget.setPassword(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ingresa una contraseña";
                    }
                    if (value.length < 8) {
                      return "La contraseña debe tener al menos 8 caracteres";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Repetir contraseña",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          MyTheme.regularBorderRadius,
                        ),
                      ),
                    ),
                  ),
                  obscureText: true,
                  enableSuggestions: false,
                  onChanged: (value) {
                    setState(() {
                      password2 = value;
                    });
                  },
                  onSaved: (value) {
                    widget.setPassword2(value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Repite tu contraseña";
                    }
                    widget.formKey.currentState!.save();
                    if (value != password) {
                      return "Las contraseñas no coinciden";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                        text: "Crear",
                        onPress: () => widget.submit(context),
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
