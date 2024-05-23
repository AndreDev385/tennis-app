import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:tennis_app/services/tournaments/clash/create_clash_matches.dart';
import 'package:tennis_app/utils/format_player_name.dart';

import '../../../domain/tournament/participant.dart';

class MatchInputs extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<Participant> t1Participants;
  final List<Participant> t2Participants;
  final MatchCreationData data;
  final int idx;

  MatchInputs({
    super.key,
    required this.idx,
    required this.formKey,
    required this.t1Participants,
    required this.t2Participants,
    required this.data,
  });

  @override
  State<MatchInputs> createState() => _MatchInputsState();
}

class _MatchInputsState extends State<MatchInputs> {
  bool isDouble = true;

  String? p1DisplayName;
  String? p2DisplayName;
  String? p3DisplayName;
  String? p4DisplayName;

  List<int> searchFn(String keyword, items) {
    List<int> ret = [];

    if (items != null && keyword.isNotEmpty) {
      for (var i = 0; i < items.length; i++) {
        if (items[i].value.toLowerCase().contains(keyword.toLowerCase())) {
          ret.add(i);
        }
      }
    } else {
      ret = Iterable<int>.generate(items.length).toList();
    }
    return (ret);
  }

  displayName(Participant p) {
    return "${formatName(p.firstName, p.lastName)} ${p.ci}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            "Partido Nro. ${widget.idx + 1}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SwitchListTile(
            value: isDouble,
            onChanged: (bool) {
              setState(() {
                isDouble = bool;
              });
            },
            title: Text(isDouble ? "Doble" : "Single"),
          ),
          Row(
            children: [
              Expanded(
                child: SearchChoices.single(
                  onChanged: (value) {
                    setState(() {
                      p1DisplayName = value;
                    });
                  },
                  isExpanded: true,
                  value: p1DisplayName,
                  hint: "Jugador",
                  searchFn: searchFn,
                  validator: (value) {
                    if (value == null) {
                      return "Elige un jugador";
                    }
                    return null;
                  },
                  items: widget.t1Participants.map((p) {
                    return DropdownMenuItem(
                      value: displayName(p),
                      child: Text(
                        displayName(p),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
              Expanded(
                child: SearchChoices.single(
                  onChanged: (value) {
                    setState(() {
                      p2DisplayName = value;
                    });
                  },
                  value: p2DisplayName,
                  isExpanded: true,
                  hint: "Jugador",
                  searchFn: searchFn,
                  validator: (value) {
                    if (value == null) {
                      return "Elige un jugador";
                    }
                    return null;
                  },
                  items: widget.t2Participants.map((p) {
                    return DropdownMenuItem(
                      value: displayName(p),
                      child: Text(
                        displayName(p),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          if (isDouble)
            Row(
              children: [
                Expanded(
                  child: SearchChoices.single(
                    onChanged: (value) {
                      setState(() {
                        p3DisplayName = value;
                      });
                    },
                    value: p3DisplayName,
                    isExpanded: true,
                    hint: "Jugador",
                    searchFn: searchFn,
                    items: widget.t1Participants.map((p) {
                      return DropdownMenuItem(
                        value: displayName(p),
                        child: Text(
                          displayName(p),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Expanded(
                  child: SearchChoices.single(
                    onChanged: (value) {
                      setState(() {
                        p4DisplayName = value;
                      });
                    },
                    value: p4DisplayName,
                    isExpanded: true,
                    hint: "Jugador",
                    searchFn: searchFn,
                    items: widget.t2Participants.map((p) {
                      return DropdownMenuItem(
                        value: displayName(p),
                        child: Text(
                          displayName(p),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
