import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPress,
    this.block = true,
    this.color = MyTheme.purple,
  });

  final Color color;
  final bool block;
  final String text;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text),
      onPressed: () => onPress(),
    );
  }
}
