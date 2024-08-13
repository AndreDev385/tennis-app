import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const OutlineButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      child: child,
      onPressed: () => onPressed(),
    );
  }
}
