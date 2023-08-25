import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/screens/auth/signin.dart';
import 'package:tennis_app/services/send_recovery_password_code.dart';

class SendCode extends StatefulWidget {
  const SendCode({
    super.key,
    required this.nextStep,
    required this.saveEmail,
  });

  final Function nextStep;
  final Function saveEmail;

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  final formKey = GlobalKey<FormState>();

  String email = "";

  @override
  Widget build(BuildContext context) {
    handleSubmit(BuildContext context) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        EasyLoading.show(status: "Cargando...");
        sendRecoveryPasswordCode(email).then((value) {
          if (value.isFailure) {
            showMessage(context, value.error!, ToastType.error);
            EasyLoading.dismiss();
            return;
          }
          widget.saveEmail(email);
          EasyLoading.dismiss();
          showMessage(context, value.getValue(), ToastType.success);
          widget.nextStep();
        }).catchError((e) {
          showMessage(context, "Ha ocurrido un error", ToastType.error);
          EasyLoading.dismiss();
        });
      }
    }

    return Column(
      children: [
        Title(
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            "¿Olvidaste tu contraseña?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 42)),
        const Text(
          "No te preocupes, te enviaremos un código de verificación a tu correo electrónico.",
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
              MyButton(
                text: "Enviar código",
                onPress: () => handleSubmit(context),
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
            ],
          ),
        ),
      ],
    );
  }
}
