import 'package:flutter/material.dart';

class ScreenArguments {
  final String gameId;

  ScreenArguments(this.gameId);
}

class GameDetail extends StatelessWidget {
  const GameDetail({super.key});

  static const route = "/game-detail";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Resultado"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Detalle"),
            TextButton(
                onPressed: () {
                  print(args.gameId);
                },
                child: const Text("Text"))
          ],
        ),
      ),
    );
  }
}
