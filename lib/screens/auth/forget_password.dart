import 'package:flutter/material.dart';
import 'package:tennis_app/components/auth/forget_password/send_code.dart';
import 'package:tennis_app/components/auth/forget_password/set_new_password.dart';
import 'package:tennis_app/components/auth/forget_password/verify_code.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  static const route = '/forget-password';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  int steps = 1;
  String code = "";
  String email = "";

  saveCode(String code) {
    setState(() {
      this.code = code;
    });
  }

  saveEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  renderSteps() {
    switch (steps) {
      case 1:
        return SendCode(
          nextStep: nextStep,
          saveEmail: saveEmail,
        );
      case 2:
        return VerifyCode(
          nextStep: nextStep,
          goBack: goBack,
          saveCode: saveCode,
          email: email,
        );
      case 3:
        return SetNewPassword(code: code);
      default:
        return SendCode(
          nextStep: nextStep,
          saveEmail: saveEmail,
        );
    }
  }

  nextStep() {
    if (steps == 3) {
      return;
    }
    setState(() {
      steps++;
    });
  }

  goBack() {
    if (steps == 1) {
      return;
    }
    setState(() {
      steps--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: BackButton(
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (steps == 1) {
              Navigator.of(context).pop();
              return;
            }
            goBack();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(32),
          child: Column(
            children: [
              renderSteps(),
            ],
          ),
        ),
      ),
    );
  }
}
