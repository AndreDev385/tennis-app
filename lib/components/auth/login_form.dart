import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/screens/app/home.dart';
import 'package:tennis_app/screens/auth/forget_password.dart';
import 'package:tennis_app/screens/auth/signin.dart';
import 'package:tennis_app/services/login_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  _saveToken(LoginResponse res) async {
    SharedPreferences db = await SharedPreferences.getInstance();

    db.setString("accessToken", res.accessToken);
  }

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
                child: const Text("Olvidaste tu contraseña?"),
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
                    child: const Text(
                      "Regístrate",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
              child: const Text(
                "Continuar como invitado",
                style: TextStyle(fontWeight: FontWeight.bold),
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

      EasyLoading.show(status: "Cargando...");
      login(request)
          .then((value) => {
                EasyLoading.dismiss(),
                if (value.statusCode == 200)
                  {_saveToken(value), Navigator.of(context).pushNamed("/home")}
                else
                  {showMessage(context, value.message, ToastType.error)}
              })
          .catchError((e) {
        EasyLoading.dismiss();
        showMessage(context, "Ha ocurrido un error", ToastType.error);
      });
    }
  }
}
