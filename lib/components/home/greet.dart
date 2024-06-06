import 'package:flutter/material.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/styles.dart';

class HomeGreet extends StatelessWidget {
  final UserDto? user;

  const HomeGreet({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    String text = user != null
        ? "Hola, ${user!.firstName.split(' ')[0]}!"
        : "Bienvenido!";

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: MyTheme.titleTextSize,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
