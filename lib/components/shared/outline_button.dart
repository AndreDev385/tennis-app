import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.background,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onPressed: () => onPressed(),
    );
  }
}
