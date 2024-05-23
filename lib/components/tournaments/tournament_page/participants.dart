import 'package:flutter/material.dart';
import 'package:tennis_app/components/tournaments/couple_card.dart';
import 'package:tennis_app/components/tournaments/participant_card.dart';
import 'package:tennis_app/components/tournaments/team_card.dart';
import 'package:tennis_app/dtos/tournaments/inscribed.dart';

import '../../../domain/shared/utils.dart';

class ParticipantsList extends StatelessWidget {
  final bool loading;
  final InscribedList? inscribed;
  final String? mode;

  const ParticipantsList({
    super.key,
    required this.loading,
    required this.inscribed,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    render() {
      if (inscribed == null && loading) {
        final fakeParticipants =
            List.filled(10, InscribedParticipant.skeleton());
        return ListView(
          children: fakeParticipants.map((r) {
            return ParticipantCard(inscribed: r);
          }).toList(),
        );
      }
      List? list;
      if (mode == GameMode.single) {
        list = inscribed?.participants;
      }
      if (mode == GameMode.double) {
        list = inscribed?.couples;
      }
      if (mode == GameMode.team) {
        list = inscribed?.teams;
      }
      if (inscribed == null || list == null || list.isEmpty) {
        return Center(
          child: Text(
            "No hay participantes inscritos",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
      if (mode == GameMode.double) {
        return ListView(
          children: inscribed!.couples!.map((r) {
            return CoupleCard(inscribed: r);
          }).toList(),
        );
      }
      if (mode == GameMode.team) {
        return ListView(
          children: inscribed!.teams!.map((r) {
            return ContestTeamCard(
              inscribed: r,
            );
          }).toList(),
        );
      }
      return ListView(
        children: inscribed!.participants!.map((r) {
          return ParticipantCard(inscribed: r);
        }).toList(),
      );
    }

    return render();
  }
}
