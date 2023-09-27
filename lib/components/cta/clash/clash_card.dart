import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/cta/clash/clash_without_matchs.dart';
import 'package:tennis_app/components/shared/loading_ring.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'clash_card_leading.dart';
import 'clash_card_title.dart';
import 'match_inside_card.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/services/list_matchs.dart';

class ClashCard extends StatefulWidget {
  const ClashCard({
    super.key,
    required this.clash,
    this.loadOnClick = true,
  });

  final ClashDto clash;
  final bool loadOnClick;

  @override
  State<ClashCard> createState() => _ClashCardState();
}

class _ClashCardState extends State<ClashCard> {
  List<MatchDto> _matchs = [];
  UserDto? user;

  bool hasBeenOpen = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getData();
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
      return;
    }

    setState(() {
      _matchs = result.getValue();
      loading = false;
    });
  }

  _getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? user = storage.getString("user");
    if (user == null) {
      return;
    }
    setState(() {
      this.user = UserDto.fromJson(jsonDecode(user));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> renderMatches() {
      if (loading == true)
        return [
          Container(
            padding: EdgeInsets.all(16),
            child: LoadingRing(),
          ),
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

  int liveMatchs() {
    int lives = 0;
    for (var i = 0; i < _matchs.length; i++) {
      if (_matchs[i].isLive) {
        lives++;
      }
    }
    return lives;
  }
}
