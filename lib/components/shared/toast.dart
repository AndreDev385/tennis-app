import 'package:flutter/material.dart';

enum ToastType { success, info, error }

class ToastMessage extends StatelessWidget {
  const ToastMessage({super.key, required this.type, required this.message});

  final String message;
  final ToastType type;

  @override
  Widget build(BuildContext context) {
    String title;
    Color backgroundColor;

    switch (type) {
      case ToastType.success:
        title = "Exito!";
        backgroundColor = Colors.green;
        break;
      case ToastType.info:
        title = "Info!";
        backgroundColor = Colors.yellow;
        break;
      case ToastType.error:
        title = "Error!";
        backgroundColor = Colors.red;
        break;
    }

    return SnackBar(
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 80,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

showMessage(BuildContext context, String message, ToastType type) {
  ScaffoldMessenger.of(context).showSnackBar(ToastMessage(
    type: type,
    message: message,
  ).build(context) as SnackBar);
}
