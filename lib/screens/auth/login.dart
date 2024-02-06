import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/auth/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool value) async {
        return;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Container(
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
                          child:
                              Theme.of(context).brightness == Brightness.light
                                  ? SvgPicture.asset(
                                      'assets/logo_light_bg.svg',
                                      width: 250,
                                      height: 150,
                                    )
                                  : SvgPicture.asset(
                                      'assets/logo_dark_bg.svg',
                                      width: 250,
                                      height: 100,
                                    ),
                        ),
                        const Text(
                          "Desbloquea el juego",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
