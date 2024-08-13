import 'package:flutter/material.dart';
import 'package:tennis_app/styles.dart';

class TablesNameRow extends StatelessWidget {
  final String namesFirstSide;
  final String namesSecondSide;

  const TablesNameRow({
    super.key,
    required this.namesFirstSide,
    required this.namesSecondSide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Table(
        border: const TableBorder(
          horizontalInside: BorderSide(
            width: .5,
            color: Colors.grey,
          ),
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(1.5),
        },
        children: [
          TableRow(children: [
            TableCell(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  namesFirstSide,
                  style: TextStyle(
                    fontSize: MyTheme.smallTextSize,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                //color: Colors.yellow[100],
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  "Nombres",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MyTheme.smallTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  namesSecondSide,
                  style: TextStyle(
                    fontSize: MyTheme.smallTextSize,
                  ),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
