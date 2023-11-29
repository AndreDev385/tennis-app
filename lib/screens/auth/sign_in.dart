import 'package:flutter/material.dart';

import '../../components/auth/sign_in_form.dart';

class SigningPage extends StatelessWidget {
  SigningPage({super.key});

  static const route = '/sign-in';

  final scaffKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Title(
                      color: Colors.black,
                      child: const Text(
                        "Regístrate",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SignInForm()
            ]),
          ),
        ),
      ),
    );
  }
}
