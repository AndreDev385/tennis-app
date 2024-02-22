import 'package:flutter/material.dart';
import 'package:tennis_app/components/results/players_row.dart';
import 'package:tennis_app/components/results/result_table/advanced/rally_table.dart';
import 'package:tennis_app/components/results/result_table/basic_table.dart';
import 'package:tennis_app/components/results/result_table/domain_partner_vs_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/place_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/return_table.dart';
import 'package:tennis_app/components/results/result_table/intermediate/service_table.dart';
import 'package:tennis_app/components/results/result_table/resume_points_table.dart';
import 'package:tennis_app/domain/game_rules.dart';

import 'package:tennis_app/domain/match.dart';

class AdvancedResult extends StatefulWidget {
  const AdvancedResult({
    super.key,
    required this.match,
    required this.showRally,
  });

  final Match match;
  final bool showRally;

  @override
  State<AdvancedResult> createState() => _AdvancedResult();
}

class _AdvancedResult extends State<AdvancedResult> {
  List<bool> _selectedTable = [true, false];

  void changeTable(int index) {
    setState(() {
      for (int i = 0; i < _selectedTable.length; i++) {
        _selectedTable[i] = i == index;
      }
    });
  }

  List<Widget> renderTables() {
    if (_selectedTable[0]) {
      return [
        if (widget.match.mode == GameMode.double)
          SelectTableToggle(
            changeTable: changeTable,
            selectedTable: _selectedTable,
            isDouble: widget.match.mode == GameMode.double,
          ),
        PlayersRow(
          player1: widget.match.player1,
          player2: widget.match.player2,
          player3: widget.match.player3,
          player4: widget.match.player4,
        ),
        ServiceTable(match: widget.match),
        ReturnTable(match: widget.match),
        ResumePointsTable(match: widget.match),
        BasicTableGames(match: widget.match),
        if (widget.showRally) RallyTable(match: widget.match),
        PlaceTable(match: widget.match),
      ];
    }
    return [
      if (widget.match.mode == GameMode.double)
        SelectTableToggle(
          changeTable: changeTable,
          selectedTable: _selectedTable,
          isDouble: widget.match.mode == GameMode.double,
        ),
      DomainPartnerVsTable(match: widget.match)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: renderTables(),
    );
  }
}

class SelectTableToggle extends StatelessWidget {
  const SelectTableToggle({
    super.key,
    required this.selectedTable,
    required this.changeTable,
    required this.isDouble,
  });

  final bool isDouble;
  final List<bool> selectedTable;
  final Function changeTable;

  @override
  Widget build(BuildContext context) {
    return !isDouble
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ToggleButtons(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    minWidth: 150,
                    maxWidth: 200,
                  ),
                  onPressed: (index) => changeTable(index),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  isSelected: selectedTable,
                  children: [
                    Text(
                      "Pareja vs Pareja",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Jugador vs Jugador",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
