import 'package:flutter/material.dart';

import '../../domain/tournament/participant.dart';
import '../../dtos/match_dtos.dart';
import '../../screens/tournaments/live_tournament_match.dart';
import '../../screens/tournaments/match_detail.dart';
import '../../styles.dart';
import '../../utils/format_player_name.dart';

buildRowName(Participant p1, Participant? p2) {
  if (p2 != null) {
    return "${shortNameFormat(p1.firstName, p1.lastName)} / ${shortNameFormat(p2.firstName, p2.lastName)}";
  }
  return formatName(p1.firstName, p1.lastName);
}

matchActions({
  required BuildContext context,
  required int matchStatus,
  required String matchId,
  required bool userCanTrack,
  required Function askToTrackMatch,
}) {

  if (matchStatus == MatchStatuses.Waiting.index && !userCanTrack) {
    return;
  }

  final ASK_TO_TRACK_MATCH = (MatchStatuses.Waiting.index == matchStatus ||
          MatchStatuses.Paused.index == matchStatus) &&
      userCanTrack;

  final JOIN_LIVE = MatchStatuses.Live.index == matchStatus;

  if (ASK_TO_TRACK_MATCH) {
    askToTrackMatch();
    return;
  }

  if (JOIN_LIVE) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LiveTournamentMatch(
        matchId: matchId,
      ),
    ));
    return;
  }

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TournamentMatchDetail(
        matchId: matchId,
      ),
    ),
  );
}

mapStatusToString(int status, context) {
  String value = "";
  Color color = Theme.of(context).colorScheme.onSurface;

  if (MatchStatuses.Live.index == status) {
    value = "Live";
    color = MyTheme.green;
  }
  if (MatchStatuses.Paused.index == status) value = "Pausado";
  if (MatchStatuses.Waiting.index == status) value = "En espera";
  if (MatchStatuses.Canceled.index == status) value = "Completado w/o";
  if (MatchStatuses.Finished.index == status) value = "Completado";

  Widget w = Row(
    children: [
      Padding(
        padding: EdgeInsets.only(right: 8),
        child: Text("Estado:"),
      ),
      Text(
        value,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    ],
  );

  return w;
}
