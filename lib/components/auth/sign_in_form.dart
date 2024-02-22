import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/shared/button.dart';

import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/screens/app/home.dart';
import 'package:tennis_app/services/user/login_service.dart';
import '../../services/user/register_service.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String password2 = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Nombre", prefixIcon: Icon(Icons.person)),
              onSaved: (value) {
                firstName = value!;
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
                  labelText: "Apellido", prefixIcon: Icon(Icons.person)),
              onSaved: (value) {
                lastName = value!;
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
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Correo electrónico",
                  prefixIcon: Icon(Icons.email)),
              onSaved: (value) {
                email = value!;
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
                  labelText: "Contraseña", prefixIcon: Icon(Icons.password)),
              obscureText: true,
              enableSuggestions: false,
              onSaved: (value) {
                password = value!;
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
                  prefixIcon: Icon(Icons.password)),
              obscureText: true,
              enableSuggestions: false,
              onSaved: (value) {
                password2 = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Repite tu contraseña";
                }
                formKey.currentState!.save();
                if (value != password) {
                  return "Las contraseñas no coinciden";
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48, bottom: 32),
            child: MyButton(
              text: "Crear Cuenta",
              onPress: () => handleRegister(context),
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void handleRegister(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      RegisterRequest data = RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      LoginRequest request = LoginRequest(email: email, password: password);

      EasyLoading.show();
      register(data).then((value) {
        if (value.success) {
          login(request).then((value) {
            EasyLoading.dismiss();
            if (value.isFailure) {
              showMessage(context, value.error!, ToastType.error);
            } else {
              showMessage(
                context,
                "Te damos la bienvenida $firstName!",
                ToastType.success,
              );
              Navigator.of(context).pushNamed(MyHomePage.route);
            }
          });
        } else {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(ToastMessage(
            type: ToastType.error,
            message: value.message,
          ).build(context) as SnackBar);
        }
      }).catchError(
        (e) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            const ToastMessage(
              type: ToastType.error,
              message: "No hay conexión",
            ).build(context) as SnackBar,
          );
        },
      );
    }
  }
}
