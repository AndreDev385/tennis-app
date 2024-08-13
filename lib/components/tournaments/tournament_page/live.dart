import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/tournaments/match_card/match_card.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/services/tournaments/match/paginate_match.dart';

import '../../../utils/state_keys.dart';

class TournamentLiveMatches extends StatefulWidget {
  final String tournamentId;

  const TournamentLiveMatches({
    super.key,
    required this.tournamentId,
  });

  @override
  State<StatefulWidget> createState() => _TournamentMatches();
}

class _TournamentMatches extends State<TournamentLiveMatches> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.success: false,
    StateKeys.error: "",
    'final': false,
  };

  ScrollController _scrollController = ScrollController();
  List<TournamentMatch> _matches = [];
  int _page = 0;

  void _paginateMatches({bool initialSearch = false}) async {
    int limit = 10;

    final query = {
      'tournamentId': widget.tournamentId,
      'offset': "${initialSearch ? 0 : _page * limit}",
      "status": "1",
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
        _paginateMatches();
      }
    }
  }

  @override
  void initState() {
    _paginateMatches();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: state[StateKeys.loading],
      child: renderMatches(),
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
          "No hay transmisiones en vivo",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () async {
        return _paginateMatches(initialSearch: true);
      },
      child: ListView.builder(
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
      ),
    );
  }
}
