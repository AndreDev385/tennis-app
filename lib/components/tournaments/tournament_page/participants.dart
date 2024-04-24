import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tennis_app/components/tournaments/participant_card.dart';
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
    print("$inscribed inscribed");

    return Skeletonizer(
      enabled: this.loading,
      child: render(),
    );
  }

  render() {
    if (inscribed == null && loading) {
      final fakeParticipants = List.filled(10, InscribedParticipant.skeleton());
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        children: fakeParticipants.map((r) {
          return ParticipantCard(inscribed: r);
        }).toList(),
      );
    }
    if (inscribed == null) {
      return Center(
        child: Text(
          "No hay participantes inscritos",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    if (mode == GameMode.single) {
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        children: inscribed!.participants!.map((r) {
          return ParticipantCard(inscribed: r);
        }).toList(),
      );
    }
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: inscribed!.couples!.map((r) {
        return Container();
      }).toList(),
    );
  }
}
