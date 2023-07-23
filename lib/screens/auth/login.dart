import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';

import '../../components/auth/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(top: 32, bottom: 64),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Title(
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Game",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Title(
                              color: MyTheme.yellow,
                              child: const Text(
                                "Mind",
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.yellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Unlock the secrets of the game",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                    ],
                  )),
              const LoginForm(),
            ],
          )),
    ));
  }
}
