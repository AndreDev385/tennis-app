import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/tournaments/clash_card/clash_card.dart';
import 'package:tennis_app/components/tournaments/match_card/match_card.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/dtos/tournaments/contest_clash.dart';
import 'package:tennis_app/services/tournaments/clash/paginate.dart';
import 'package:tennis_app/services/tournaments/match/paginate_match.dart';

import '../../../utils/state_keys.dart';

class TournamentMatchesSection extends StatefulWidget {
  final String contestId;
  final bool showClashes;

  const TournamentMatchesSection({
    super.key,
    required this.contestId,
    required this.showClashes,
  });

  @override
  State<StatefulWidget> createState() => _TournamentMatches();
}

class _TournamentMatches extends State<TournamentMatchesSection> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.success: false,
    StateKeys.error: "",
    'final': false,
  };

  ScrollController _scrollController = ScrollController();
  List<TournamentMatch> _matches = [];
  List<ContestClash> _clashes = [];
  int _page = 0;

  _paginateClashes({bool initialSearch = false}) async {
    int limit = 5;

    final result = await paginateContestClashes({
      'contestId': widget.contestId,
      'limit': "$limit",
      'offset': "${initialSearch ? 0 : _page * limit}",
    });

    if (result.isFailure) {
      setState(() {
        state[StateKeys.loading] = false;
        state[StateKeys.error] = result.error!;
      });
      return;
    }

    setState(() {
      state[StateKeys.loading] = false;

      int count = result.getValue().count;

      if (initialSearch) {
        _clashes = result.getValue().rows;
        _matches = [];
        return;
      }

      // find mode
      _clashes.addAll(result.getValue().rows);

      final LAST_RESULT = result.getValue().rows.isEmpty ||
          _clashes.length == count ||
          result.getValue().rows.length < limit;

      if (LAST_RESULT) {
        state['final'] = true;
      }
    });
  }

  void _paginateMatches({bool initialSearch = false}) async {
    int limit = 10;

    final query = {
      'contestId': widget.contestId,
      'offset': "${initialSearch ? 0 : _page * limit}",
    };

    final result = await paginateTournamentMatches(query);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.loading] = false;
        state[StateKeys.error] = result.error;
      });
      return;
    }
    setState(() {
      state[StateKeys.loading] = false;
      int count = result.getValue().count;

      if (initialSearch) {
        _clashes = [];
        _matches = result.getValue().rows;
        return;
      }

      // find more
      _matches.addAll(result.getValue().rows);

      final LAST_RESULT = result.getValue().rows.isEmpty ||
          _matches.length == count ||
          result.getValue().rows.length < limit;

      if (LAST_RESULT) {
        state['final'] = true;
      }
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _page++;
      });

      if (!state['final']) {
        _paginateClashes();
      }
    }
  }

  @override
  void initState() {
    if (widget.showClashes) {
      _paginateClashes();
    } else {
      _paginateMatches();
    }
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TournamentMatchesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contestId != widget.contestId) {
      if (widget.showClashes) {
        _paginateClashes(initialSearch: true);
      } else {
        _paginateMatches(initialSearch: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: state[StateKeys.loading],
      child: render(),
    );
  }

  renderClashes() {
    if (state[StateKeys.loading]) {
      final fakeClashes = List.filled(20, ContestClash.skeleton());
      return ListView(
        children: fakeClashes.map((c) {
          return ContestClashCard(clash: c);
        }).toList(),
      );
    }
    if (_clashes.length == 0) {
      return Center(
        child: Text(
          "No se han registrado encuentros",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return ListView(
      children: _clashes.map((c) {
        return ContestClashCard(clash: c);
      }).toList(),
    );
  }

  renderMatches() {
    if (state[StateKeys.loading]) {
      final fakeMatches = List.filled(4, TournamentMatch.skeleton());
      return ListView(
        children: fakeMatches.map((m) {
          return TournamentMatchCard(match: m);
        }).toList(),
      );
    }
    if (_matches.length == 0) {
      return Center(
        child: Text(
          "No se han registrado partidos",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: _matches.length + 1,
      itemBuilder: (context, idx) {
        if (idx < _matches.length) {
          return TournamentMatchCard(match: _matches[idx]);
        } else if (state['final']) {
          return Container();
        } else {
          return Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  render() {
    if (widget.showClashes) {
      return renderClashes();
    }
    return renderMatches();
  }
}
