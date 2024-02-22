import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/services/user/send_recovery_password_code.dart';
import 'package:tennis_app/services/user/verify_password_code.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({
    super.key,
    required this.nextStep,
    required this.goBack,
    required this.saveCode,
    required this.email,
  });

  final Function saveCode;
  final Function nextStep;
  final Function goBack;
  final String email;

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final formKey = GlobalKey<FormState>();

  String code = "";

  @override
  Widget build(BuildContext context) {
    handleSubmit(BuildContext context) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        EasyLoading.show();
        verifyPasswordCode(code).then((value) {
          if (value.isFailure) {
            EasyLoading.dismiss();
            showMessage(context, value.error!, ToastType.error);
            return;
          }
          EasyLoading.dismiss();
          showMessage(context, value.getValue(), ToastType.success);
          widget.saveCode(code);
          widget.nextStep();
        }).catchError((e) {
          EasyLoading.dismiss();
          showMessage(context, "Ha ocurrido un error", ToastType.error);
        });
      }
    }

    resendCode(BuildContext context) {
      EasyLoading.show();
      sendRecoveryPasswordCode(widget.email).then((value) {
        if (value.isFailure) {
          showMessage(context, value.error!, ToastType.error);
          EasyLoading.dismiss();
          return;
        }
        EasyLoading.dismiss();
        showMessage(context, value.getValue(), ToastType.success);
      }).catchError((e) {
        showMessage(context, "Ha ocurrido un error", ToastType.error);
        EasyLoading.dismiss();
      });
    }

    return Column(
      children: [
        Title(
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            "Ingresa tu código de verificación",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 42)),
        const Image(
          image: AssetImage('assets/email.png'),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 42)),
        const Text(
          "Te hemos enviado un código de verificación a tu correo electrónico",
          textAlign: TextAlign.center,
        ),
        const Padding(padding: EdgeInsets.only(bottom: 42)),
        Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Código de verificación",
                      prefixIcon: Icon(Icons.lock)),
                  onSaved: (value) {
                    code = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ingresa el código";
                    }
                    return null;
                  },
                ),
              ),
              MyButton(
                text: "Validar código",
                onPress: () => handleSubmit(context),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        width: 2, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                child: Text(
                  "Reenviar código",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onPressed: () => resendCode(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
