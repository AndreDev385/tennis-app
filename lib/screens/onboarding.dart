import 'package:flutter/material.dart';

import 'package:tennis_app/components/shared/logo.dart';
import 'package:tennis_app/screens/auth/login.dart';
import 'package:tennis_app/screens/auth/sign_in.dart';
import 'package:tennis_app/styles.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const route = 'onboarding-page';

  static const points = [
    [
      TextSpan(
        text: "Maneja ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MyTheme.largeTextSize,
        ),
      ),
      TextSpan(
        text: "tu data y porcentaje de efectividad para los entrenamientos",
        style: TextStyle(
          fontSize: MyTheme.largeTextSize,
        ),
      )
    ],
    [
      TextSpan(
        text: "Identifica ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MyTheme.largeTextSize,
        ),
      ),
      TextSpan(
        text: "tus fortalezas y debilidades",
        style: TextStyle(
          fontSize: MyTheme.largeTextSize,
        ),
      )
    ],
    [
      TextSpan(
        text: "Descubre ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MyTheme.largeTextSize,
        ),
      ),
      TextSpan(
        text: "el verdadero jugador que eres",
        style: TextStyle(
          fontSize: MyTheme.largeTextSize,
        ),
      ),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.only(top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bienvenido a",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: MyTheme.titleTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Logo(isLightTheme: false),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Somos la primera app en Venezuela que mide y registra las estadísticas de los jugadores en los partidos de tenis.",
                        style: TextStyle(
                          fontSize: MyTheme.largeTextSize,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ...points.asMap().entries.map((entry) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: ListPoint(
                              idx: entry.key + 1,
                              spans: entry.value,
                            ),
                          );
                        }),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(24),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            MyTheme.regularBorderRadius,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  MyTheme.regularBorderRadius,
                                ),
                              ),
                            ),
                            child: Text(
                              "Iniciar Sesión",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.route);
                            },
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MyTheme.regularBorderRadius),
                                side: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            child: Text("Regístrate"),
                            onPressed: () {
                              Navigator.pushNamed(context, SigningPage.route);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListPoint extends StatelessWidget {
  final int idx;
  final List<TextSpan> spans;

  const ListPoint({
    super.key,
    required this.idx,
    required this.spans,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                "$idx",
                style: TextStyle(
                  fontSize: MyTheme.titleTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            child: RichText(
              text: TextSpan(children: spans),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
