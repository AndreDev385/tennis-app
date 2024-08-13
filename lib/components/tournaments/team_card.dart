import 'package:flutter/material.dart';
import 'package:tennis_app/components/shared/loading_ring.dart';
import 'package:tennis_app/components/tournaments/avatar.dart';
import 'package:tennis_app/services/tournaments/participants/paginate.dart';
import 'package:tennis_app/utils/format_player_name.dart';
import 'package:tennis_app/utils/state_keys.dart';

import '../../domain/tournament/participant.dart';
import '../../dtos/tournaments/inscribed.dart';
import '../../styles.dart';

class ContestTeamCard extends StatefulWidget {
  final InscribedTeam inscribed;

  const ContestTeamCard({
    super.key,
    required this.inscribed,
  });

  @override
  State<StatefulWidget> createState() {
    return _ContestTeamCard();
  }
}

class _ContestTeamCard extends State<ContestTeamCard> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };
  List<Participant> participants = [];
  bool hasBeenOpen = false;

  findParticipants() async {
    if (widget.inscribed.contestTeam.participantsIds.length == 0) {
      return;
    }
    setState(() {
      state[StateKeys.loading] = true;
    });
    final result = await paginateParticipants(
      limit: 99,
      offset: 0,
      participantIds: widget.inscribed.contestTeam.participantsIds,
    );

    if (result.isFailure) {
      setState(() {
        state[StateKeys.loading] = false;
        state[StateKeys.error] = result.error;
      });
    }

    setState(() {
      state[StateKeys.loading] = false;
      participants = result.getValue().rows;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    renderPlayers() {
      if (state[StateKeys.loading]) {
        return [
          Container(
            padding: EdgeInsets.all(16),
            child: LoadingRing(),
          ),
        ];
      }
      return participants.length == 0
          ? [
              SizedBox(
                height: 60,
                child: Center(
                  child: Text(
                    "Sin participantes inscritos",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ]
          : participants.map((r) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                width: double.maxFinite,
                height: 60,
                child: Row(
                  children: [
                    Avatar(
                      firstName: r.firstName,
                      lastName: r.lastName,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "${formatName(r.firstName, r.lastName)}",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
    }

    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(MyTheme.cardBorderRadius),
      ),
      elevation: 0,
      child: ExpansionTile(
        onExpansionChanged: (bool value) {
          if (!hasBeenOpen) {
            findParticipants();
            setState(() {
              hasBeenOpen = true;
            });
          }
        },
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          width: double.maxFinite,
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Equipo: ${widget.inscribed.contestTeam.name}",
                      style: TextStyle(fontSize: MyTheme.largeTextSize),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.inscribed.position != null)
                      Text(
                        "Nro. ${widget.inscribed.position}",
                        style: TextStyle(fontSize: MyTheme.smallTextSize),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        children: renderPlayers(),
      ),
    );
  }
}
