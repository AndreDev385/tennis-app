import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    super.key,
    required this.value,
    this.retryFunction,
  });

  final String value;
  final Function? retryFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (retryFunction != null)
          ElevatedButton(
            child: Text("Volver a intentar"),
            onPressed: () => retryFunction!(),
          )
      ],
    );
  }
}
