import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/auth/sign_in_form_step2.dart';
import 'package:tennis_app/components/shared/logo.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/screens/home.dart';
import 'package:tennis_app/services/user/login_service.dart';
import 'package:tennis_app/services/user/register_service.dart';
import 'package:tennis_app/styles.dart';

import '../../components/auth/sign_in_form_step1.dart';

class SigningPage extends StatefulWidget {
  SigningPage({super.key});

  static const route = '/sign-in';

  @override
  State<SigningPage> createState() => _SigningPageState();
}

class _SigningPageState extends State<SigningPage> {
  int step = 1;

  stepTwo() {
    setState(() {
      step = 2;
    });
  }

  goBack() {
    setState(() {
      step = 1;
    });
  }

  final firstForm = GlobalKey<FormState>();
  final secondForm = GlobalKey<FormState>();

  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String password2 = "";
  String ciType = "";
  String ciValue = "";

  setFirstName(String value) {
    setState(() {
      firstName = value;
    });
  }

  setLastName(String value) {
    setState(() {
      lastName = value;
    });
  }

  setEmail(String value) {
    setState(() {
      email = value;
    });
  }

  setPassword(String value) {
    setState(() {
      password = value;
    });
  }

  setPassword2(String value) {
    setState(() {
      password2 = value;
    });
  }

  setCiType(String value) {
    setState(() {
      ciType = value;
    });
  }

  setCiValue(String value) {
    setState(() {
      ciValue = value;
    });
  }

  final scaffKey = GlobalKey<ScaffoldState>();

  void handleSubmitFirstStep() {
    if (firstForm.currentState!.validate()) {
      firstForm.currentState!.save();
      stepTwo();
    }
  }

  void handleSubmitSecondStep(BuildContext context) {
    if (secondForm.currentState!.validate()) {
      secondForm.currentState!.save();

      RegisterRequest data = RegisterRequest(
        firstName: firstName,
        ci: "${ciType}${ciValue.trim()}",
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Logo(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Title(
                      color: Colors.black,
                      child: const Text(
                        "Regístrate",
                        style: TextStyle(
                          fontSize: MyTheme.titleTextSize,
                        ),
                      ),
                    ),
                  ),
                  if (step == 1)
                    SignInFormStepOne(
                      data: {
                        "firstName": firstName,
                        "lastName": lastName,
                        "ciType": ciType,
                        "ciValue": ciValue,
                      },
                      setFirstName: setFirstName,
                      setLastName: setLastName,
                      setCiType: setCiType,
                      setCiValue: setCiValue,
                      stepTwo: handleSubmitFirstStep,
                      formKey: firstForm,
                    ),
                  if (step == 2)
                    SignInFormStepTwo(
                      submit: handleSubmitSecondStep,
                      formKey: secondForm,
                      setEmail: setEmail,
                      goBack: goBack,
                      setPassword: setPassword,
                      setPassword2: setPassword2,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
