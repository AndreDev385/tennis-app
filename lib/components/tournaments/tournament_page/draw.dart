import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/tournament/bracket.dart';
import '../../../services/tournaments/contest/list_draw_brackets.dart';
import '../../../utils/state_keys.dart';
import '../brackets/bracket.dart';
import '../brackets/filters.dart';

class DrawSection extends StatefulWidget {
  final String? contestId;

  const DrawSection({
    super.key,
    required this.contestId,
  });

  @override
  State<StatefulWidget> createState() => _DrawSection();
}

class _DrawSection extends State<DrawSection> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
  };

  List<List<Bracket>> _drawBrackets = [];
  int? deep;
  int? selectedDeep;

  _getDraw() async {
    if (widget.contestId == null) return;

    setState(() {
      state[StateKeys.loading] = true;
    });

    final result = await listDrawBrackets(widget.contestId!, null);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = "Ha ocurrido un error";
        state[StateKeys.loading] = false;
      });
      return;
    }

    setState(() {
      // Sort list by deep
      deep = _getDeep(result.getValue());
      selectedDeep = deep;
      _drawBrackets = _buildBracketPairs(result.getValue());
      state[StateKeys.loading] = false;
    });
  }

  @override
  void initState() {
    _getDraw();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DrawSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contestId != null &&
        oldWidget.contestId != widget.contestId) {
      _getDraw();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: state[StateKeys.loading],
      child: render(context),
    );
  }

  render(BuildContext context) {
    //TODO: check scroll with more brackets
    if (state[StateKeys.loading]) {
      final fakeBrackets = List.filled(4, Bracket.skeleton());
      final fakePairs = _buildBracketPairs(fakeBrackets);
      return ListView(
        children: [
          BracketsFilters(
            deep: 0,
            setDeep: _changeDeep,
          ),
          ...fakePairs.map((b) {
            return BracketTree(
              bracketPair: b,
            );
          }).toList()
        ],
      );
    }
    if (_drawBrackets.length == 0) {
      return Center(
        child: Text(
          "No se ha creado el draw",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        BracketsFilters(
          deep: deep!,
          setDeep: _changeDeep,
        ),
        ..._drawBrackets.where((b) {
          return b[0].deep == selectedDeep!;
        }).map((b) {
          return BracketTree(
            bracketPair: b,
          );
        }).toList()
      ],
    );
  }

  List<List<Bracket>> _buildBracketPairs(List<Bracket> list) {
    List<List<Bracket>> bracketPairs = [];

    var pairsIdx = 0;
    for (var i = 0; i < list.length; i++) {
      if (i % 2 == 0) {
        bracketPairs.add([list[i]]);
      } else {
        if (list.length - 1 < i) continue;
        bracketPairs[pairsIdx].add(list[i]);
        pairsIdx++;
      }
    }

    return bracketPairs;
  }

  int _getDeep(List<Bracket> list) {
    if (list.length < 1) {
      return 0;
    }

    list.sort((a, b) {
      return b.deep.compareTo(a.deep);
    });

    return list[0].deep;
  }

  _changeDeep(int value) {
    setState(() {
      selectedDeep = value;
    });
  }
}
