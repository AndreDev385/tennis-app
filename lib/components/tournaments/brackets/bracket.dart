import 'package:flutter/material.dart';
import 'package:tennis_app/components/tournaments/brackets/bracket_card.dart';
import 'package:tennis_app/domain/tournament/bracket.dart';

class BracketTree extends StatefulWidget {
  final List<Bracket> bracketPair;

  BracketTree({
    super.key,
    required this.bracketPair,
  });

  @override
  State<BracketTree> createState() => _BracketTreeState();
}

class _BracketTreeState extends State<BracketTree> {
  double? bracketLineHeight;

  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateHeight());
  }

  _calculateHeight() {
    setState(() {
      bracketLineHeight = _key.currentContext!.size!.height / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              key: _key,
              children: [
                BracketCard(
                  bracket: widget.bracketPair[0],
                ),
                if (widget.bracketPair.length == 2)
                  BracketCard(
                    bracket: widget.bracketPair[1],
                  ),
              ],
            ),
          ),
          if (widget.bracketPair[0].deep != 1)
            Container(
              margin: EdgeInsets.only(left: 8),
              width: 10,
              height: bracketLineHeight,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                  bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                  right: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                ),
              ),
            ),
          if (widget.bracketPair[0].deep != 1)
            Container(
              width: 10,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
