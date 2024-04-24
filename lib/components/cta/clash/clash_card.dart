import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/clash/clash_without_matchs.dart';
import 'package:tennis_app/components/shared/loading_ring.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/services/match/list_matchs.dart';
import 'package:tennis_app/services/storage.dart';

import 'clash_card_leading.dart';
import 'clash_card_title.dart';
import 'match_inside_card.dart';

class ClashCard extends StatefulWidget {
  final ClashDto clash;

  final bool loadOnClick;
  const ClashCard({
    super.key,
    required this.clash,
    this.loadOnClick = true,
  });

  @override
  State<ClashCard> createState() => _ClashCardState();
}

class _ClashCardState extends State<ClashCard> {
  List<MatchDto> _matchs = [];
  UserDto? user;

  bool hasBeenOpen = false;
  Map<String, dynamic> state = {
    'loading': true,
    'error': "",
    "success": false,
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> renderMatches() {
      if (state['loading'])
        return [
          Container(
            padding: EdgeInsets.all(16),
            child: LoadingRing(),
          ),
        ];
      else if (state['error'].length > 0)
        return [
          SizedBox(
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      color: Theme.of(context).colorScheme.error),
                  Text(
                    state['error'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  )
                ],
              ),
            ),
          )
        ];
      return _matchs.isEmpty
          ? [
              ClashWithoutMatchs(
                clash: widget.clash,
              )
            ]
          : _matchs.asMap().entries.map((entry) {
              return MatchInsideClashCard(
                match: entry.value,
                isLast: entry.key == _matchs.length - 1,
                userCanTrack: user != null ? user!.canTrack : false,
              );
            }).toList();
    }

    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: ExpansionTile(
        onExpansionChanged: (bool value) {
          if (!hasBeenOpen) {
            setState(() {
              hasBeenOpen = true;
            });
            if (widget.loadOnClick) {
              _getMatchs();
            }
          }
        },
        tilePadding: const EdgeInsets.only(right: 16),
        title: SizedBox(
          height: 96,
          child: Row(
            children: [
              ClashCardLeading(categoryName: widget.clash.categoryName),
              const Padding(padding: EdgeInsets.only(right: 8)),
              ClashCardTitle(
                vs: "${widget.clash.team1.club.symbol}-${widget.clash.team1.name} vs ${widget.clash.team2.club.symbol}-${widget.clash.team2.name}",
                journey: widget.clash.journey,
                lives: liveMatchs(),
                isFinish: widget.clash.isFinish,
                host: widget.clash.host,
              ),
            ],
          ),
        ),
        children: renderMatches(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  int liveMatchs() {
    int lives = 0;
    for (var i = 0; i < _matchs.length; i++) {
      if (_matchs[i].status == MatchStatuses.Live.index) {
        lives++;
      }
    }
    return lives;
  }

  _getData() async {
    await _getUser();
    if (!widget.loadOnClick) {
      await _getMatchs();
    }
  }

  _getMatchs() async {
    Map<String, String> query = {
      'clashId': widget.clash.clashId,
    };
    final result = await listMatchs(query);

    if (result.isFailure) {
      setState(() {
        state['loading'] = false;
        state['error'] = result.error!;
      });
      return;
    }

    setState(() {
      _matchs = result.getValue();
      state['loading'] = false;
    });
  }

  _getUser() async {
    StorageHandler st = await createStorageHandler();
    String? user = st.getUser();
    if (user == null) {
      return;
    }
    setState(() {
      this.user = UserDto.fromJson(jsonDecode(user));
    });
  }
}
