import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/screens/app/home.dart';
import 'package:tennis_app/services/user/change_password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  static const route = "/change-password";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();

  String password = "";
  String confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    handleSubmit() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        EasyLoading.show();
        changePassword(password).then((value) {
          if (value.isFailure) {
            EasyLoading.dismiss();
            showMessage(context, value.error!, ToastType.error);
            return;
          }
          EasyLoading.dismiss();
          showMessage(context, value.getValue(), ToastType.success);
          Navigator.of(context).pushNamed(MyHomePage.route);
        }).catchError((e) {
          EasyLoading.dismiss();
          showMessage(context, "Ha ocurrido un error", ToastType.error);
        });
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Cambiar contraseña"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 24)),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Contraseña",
                        prefixIcon: Icon(Icons.password)),
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
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Repetir contraseña",
                        prefixIcon: Icon(Icons.password)),
                    onSaved: (value) {
                      confirmPassword = value!;
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 24),
                ),
                MyButton(
                    text: "Cambiar contraseña", onPress: () => handleSubmit())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
