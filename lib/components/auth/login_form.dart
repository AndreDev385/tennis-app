import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../screens/auth/forget_password.dart';
import '../../screens/auth/sign_in.dart';
import '../../screens/home.dart';
import '../../services/user/login_service.dart';
import '../shared/button.dart';
import '../shared/toast.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Correo electrónico",
                  prefixIcon: Icon(Icons.email)),
              onSaved: (value) {
                email = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingresa tu correo";
                }
                return null;
              },
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: "Contraseña", prefixIcon: Icon(Icons.lock)),
            obscureText: true,
            enableSuggestions: false,
            onSaved: (value) {
              password = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ingresa tu contraseña";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 32),
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ForgetPassword.route);
                },
                child: Text(
                  "Olvidaste tu contraseña?",
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          MyButton(
            text: "Iniciar Sesión",
            onPress: () => handleLogin(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("No tienes una cuenta?"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SigningPage.route);
                    },
                    child: Text(
                      "Regístrate",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.primary,
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MyHomePage.route);
              },
              child: Text(
                "Continuar como invitado",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      LoginRequest request = LoginRequest(email: email, password: password);

      EasyLoading.show();
      login(request).then((value) {
        EasyLoading.dismiss();
        if (value.isFailure) {
          showMessage(context, value.error!, ToastType.error);
          return;
        }
        Navigator.of(context).pushNamed("/home");
      });
    }
  }
}
