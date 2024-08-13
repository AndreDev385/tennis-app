import 'package:flutter/material.dart';

class HelpText extends StatelessWidget {
  const HelpText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        this.text,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
