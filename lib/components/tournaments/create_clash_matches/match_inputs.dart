import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/services/tournaments/clash/create_clash_matches.dart';
import 'package:tennis_app/utils/format_player_name.dart';

import '../../../domain/tournament/participant.dart';

class MatchInputs extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<Participant> t1Participants;
  final List<Participant> t2Participants;
  final MatchCreationData data;
  final Function(MatchCreationData data, int idx) setData;
  final int idx;

  MatchInputs({
    super.key,
    required this.idx,
    required this.formKey,
    required this.t1Participants,
    required this.t2Participants,
    required this.data,
    required this.setData,
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

  String displayName(Participant p) {
    return "${formatName(p.firstName, p.lastName)} ${p.ci}";
  }

  bool playerAlreadySelected(String displayName) {
    List<String?> selected = [
      p1DisplayName,
      p2DisplayName,
      p3DisplayName,
      p4DisplayName
    ];

    final exist = selected.where((r) => r == displayName).toList();

    return exist.length >= 2;
  }

  String mapDisplayNameToParticipantId(String dislplayName, bool isTeam1) {
    String ci = dislplayName.split(" ").last;

    Participant? participant;

    if (isTeam1) {
      participant = widget.t1Participants.where((p) {
        return p.ci == ci;
      }).toList()[0];
    } else {
      participant = widget.t2Participants.where((p) {
        return p.ci == ci;
      }).toList()[0];
    }

    return participant.participantId;
  }

  @override
  void initState() {
    super.initState();
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
              widget.setData(
                MatchCreationData(
                  mode: isDouble ? GameMode.double : GameMode.single,
                  p1Id: widget.data.p1Id,
                  p2Id: widget.data.p2Id,
                  p3Id: widget.data.p3Id,
                  p4Id: widget.data.p4Id,
                ),
                widget.idx,
              );
              setState(() {
                isDouble = bool;
              });
            },
            title: Text(isDouble ? "Doble" : "Single"),
          ),
          Row(
            children: [
              Expanded(
                // p1
                child: SearchChoices.single(
                  onChanged: (value) {
                    setState(() {
                      p1DisplayName = value;
                    });
                    widget.setData(
                      MatchCreationData(
                        mode: isDouble ? GameMode.double : GameMode.single,
                        p1Id: mapDisplayNameToParticipantId(value, true),
                        p2Id: widget.data.p2Id,
                        p3Id: widget.data.p3Id,
                        p4Id: widget.data.p4Id,
                      ),
                      widget.idx,
                    );
                  },
                  value: p1DisplayName,
                  isExpanded: true,
                  hint: "Jugador",
                  searchFn: searchFn,
                  validator: (value) {
                    if (value == null) {
                      return "Elige un jugador";
                    }
                    if (playerAlreadySelected(value)) {
                      return "Elige otro jugador";
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
                //p2
                child: SearchChoices.single(
                  onChanged: (value) {
                    setState(() {
                      p2DisplayName = value;
                    });
                    widget.setData(
                      MatchCreationData(
                        mode: isDouble ? GameMode.double : GameMode.single,
                        p1Id: widget.data.p1Id,
                        p2Id: mapDisplayNameToParticipantId(value!, false),
                        p3Id: widget.data.p3Id,
                        p4Id: widget.data.p4Id,
                      ),
                      widget.idx,
                    );
                  },
                  value: p2DisplayName,
                  isExpanded: true,
                  hint: "Jugador",
                  searchFn: searchFn,
                  validator: (value) {
                    if (value == null) {
                      return "Elige un jugador";
                    }
                    if (playerAlreadySelected(value)) {
                      return "Elige otro jugador";
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
                  //p3
                  child: SearchChoices.single(
                    onChanged: (value) {
                      setState(() {
                        p3DisplayName = value;
                      });
                      widget.setData(
                        MatchCreationData(
                          mode: isDouble ? GameMode.double : GameMode.single,
                          p1Id: widget.data.p1Id,
                          p2Id: widget.data.p2Id,
                          p3Id: mapDisplayNameToParticipantId(value!, true),
                          p4Id: widget.data.p4Id,
                        ),
                        widget.idx,
                      );
                    },
                    value: p3DisplayName,
                    isExpanded: true,
                    hint: "Jugador",
                    searchFn: searchFn,
                    validator: (value) {
                      if (value == null && isDouble) {
                        return "Elige un jugador";
                      }
                      if (playerAlreadySelected(value!)) {
                        return "Elige otro jugador";
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
                  //p4
                  child: SearchChoices.single(
                    onChanged: (value) {
                      setState(() {
                        p4DisplayName = value;
                      });
                      widget.setData(
                        MatchCreationData(
                          mode: isDouble ? GameMode.double : GameMode.single,
                          p1Id: widget.data.p1Id,
                          p2Id: widget.data.p2Id,
                          p3Id: widget.data.p3Id,
                          p4Id: mapDisplayNameToParticipantId(value!, false),
                        ),
                        widget.idx,
                      );
                    },
                    value: p4DisplayName,
                    isExpanded: true,
                    hint: "Jugador",
                    searchFn: searchFn,
                    validator: (value) {
                      if (value == null && isDouble) {
                        return "Elige un jugador";
                      }
                      if (playerAlreadySelected(value!)) {
                        return "Elige otro jugador";
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
        ],
      ),
    );
  }
}
