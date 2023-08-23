import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/services/change_forgotten_password.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({
    super.key,
    required this.code,
  });

  final String code;

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final formKey = GlobalKey<FormState>();

  String password = "";
  String confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    handleSubmit(BuildContext context) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        final body = {
          "code": widget.code,
          "newPassword": password,
        };

        EasyLoading.show(status: "Cargando...");
        changeForgottenPassword(body).then((value) {
          if (value.isFailure) {
            EasyLoading.dismiss();
            showMessage(context, value.error!, ToastType.error);
          }
          EasyLoading.dismiss();
          showMessage(context, value.getValue(), ToastType.success);
          Navigator.of(context).pop();
        }).catchError((e) {
          EasyLoading.dismiss();
          showMessage(context, "Ha ocurrido un error", ToastType.error);
        });
      }
    }

    return Column(
      children: [
        Title(
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            "Configura tu nueva contraseña",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 42)),
        const Text(
          "Tu nueva contraseña debe ser diferente a tu contraseña anterior.",
          textAlign: TextAlign.center,
        ),
        const Padding(padding: EdgeInsets.only(bottom: 80)),
        Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Nueva contraseña",
                      prefixIcon: Icon(Icons.password)),
                  onSaved: (value) {
                    password = value!;
                  },
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ingresa tu contraseña";
                    }
                    if (value.length < 8) {
                      return "La contrasena debe tener al menos 8 caracteres";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Confirmar nueva contraseña",
                      prefixIcon: Icon(Icons.password)),
                  onSaved: (value) {
                    confirmPassword = value!;
                  },
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirma tu contraseña";
                    }
                    formKey.currentState!.save();
                    if (value != password) {
                      return "Las contraseñas no coinciden";
                    }
                    return null;
                  },
                ),
              ),
              MyButton(
                text: "Cambiar contraseña",
                onPress: () => handleSubmit(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
