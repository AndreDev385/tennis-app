import 'package:flutter/material.dart';

import '../../components/auth/sigin_form.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  static const route = '/sigin';

  final scaffKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
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
                        "Registrate",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      )),
                ],
              )),
          const SignInForm()
        ]),
      ),
    );
  }
}
