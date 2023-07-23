import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/domain/game_rules.dart';

class SetSingleService extends StatefulWidget {
  const SetSingleService({super.key});

  @override
  State<SetSingleService> createState() => _SetSingleServiceState();
}

class _SetSingleServiceState extends State<SetSingleService> {
  bool me = true;

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameRules>(context);

    setServe() {
      gameProvider.setSingleService(me ? 0 : 1);
    }

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        height: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: me
                                  ? Colors.blue[900]
                                  : Theme.of(context).colorScheme.primary),
                          onPressed: () {
                            setState(() {
                              me = true;
                            });
                          },
                          child: Text(
                            "${gameProvider.match?.player1}",
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        height: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: !me
                                  ? Colors.blue[900]
                                  : Theme.of(context).colorScheme.primary),
                          onPressed: () {
                            setState(() {
                              me = false;
                            });
                          },
                          child: Text(
                            "${gameProvider.match?.player2}",
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => setServe(),
              child: const Text("Continuar"),
            )
          ],
        ),
      ),
    );
  }
}
