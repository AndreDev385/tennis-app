import 'package:flutter/material.dart';

import '../../domain/shared/utils.dart';
import '../shared/button.dart';

class SelectStatistics extends StatefulWidget {
  final void Function(String value) selectStatisticsAndStartGame;
  final void Function() back;

  const SelectStatistics({
    super.key,
    required this.selectStatisticsAndStartGame,
    required this.back,
  });

  @override
  State<SelectStatistics> createState() => _SelectStatisticsState();
}

class _SelectStatisticsState extends State<SelectStatistics> {
  String? selectedStatistics;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: Title(
            color: Colors.black,
            child: const Text(
              "Estadísticas",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedStatistics = Statistics.basic;
              });
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                minimumSize: const Size.fromHeight(120),
                backgroundColor: selectedStatistics == Statistics.basic
                    ? Colors.blue
                    : null),
            child: const Column(
              children: [
                Text(
                  "Básicas",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "marcador, games y puntos",
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedStatistics = Statistics.intermediate;
              });
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              minimumSize: const Size.fromHeight(120),
              backgroundColor: selectedStatistics == Statistics.intermediate
                  ? Colors.blue
                  : null,
            ),
            child: const Column(
              children: [
                Text(
                  "Intermedias",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "saque, devolución, malla y fondo",
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedStatistics = Statistics.advanced;
              });
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                minimumSize: const Size.fromHeight(120),
                backgroundColor: selectedStatistics == Statistics.advanced
                    ? Colors.blue
                    : null),
            child: const Column(
              children: [
                Text(
                  "Avanzadas",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "longitud del rally",
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: MyButton(
                    text: "Volver",
                    color: Theme.of(context).colorScheme.error,
                    block: false,
                    onPress: () => widget.back(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: MyButton(
                    text: "Continuar",
                    block: false,
                    onPress: () {
                      if (selectedStatistics != null) {
                        widget
                            .selectStatisticsAndStartGame(selectedStatistics!);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void select(BuildContext context, Statistics value) {
    // Function that sets Statistics;
    Navigator.of(context).pop();
  }
}
