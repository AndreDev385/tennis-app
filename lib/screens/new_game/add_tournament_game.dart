import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/screens/tournaments/track_practice_match.dart';
import 'package:uuid/v4.dart';

import 'package:tennis_app/components/new_regular_game/config_form.dart';
import 'package:tennis_app/components/new_regular_game/players_form.dart';
import 'package:tennis_app/domain/shared/game.dart';
import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/domain/tournament/participant.dart';
import 'package:tennis_app/domain/tournament/participant_tracker.dart';
import 'package:tennis_app/domain/tournament/tournament_match.dart';
import 'package:tennis_app/domain/tournament/tournament_match_stats.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/domain/shared/set.dart';

class AddTournamentGame extends StatefulWidget {
  const AddTournamentGame({super.key});

  static const route = "practice-tournament-game";

  @override
  State<StatefulWidget> createState() {
    return _AddTournamentGame();
  }
}

class _AddTournamentGame extends State<AddTournamentGame> {
  int formStep = 1;

  bool superTiebreak = false;
  int setsQuantity = 3;

  String surface = Surfaces.hard;
  String gameMode = GameMode.single;
  int setType = GamesPerSet.regular;

  String direction = "";

  bool goldenPoint = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TournamentMatchProvider>(context);

    void back() {
      setState(() {
        formStep--;
      });
    }

    void next({
      required String mode,
      required int setsQuantity,
      required String surface,
      required int setType,
      required String direction,
    }) {
      setState(() {
        gameMode = mode;
        this.setsQuantity = setsQuantity;
        this.surface = surface;
        this.setType = setType;
        this.direction = direction;
        formStep++;
      });
    }

    void createGame({
      required String me,
      required String rival,
      required String partner,
      required String rival2,
    }) {
      var match = TournamentMatch(
        matchId: UuidV4().toString(),
        tournamentId: UuidV4().toString(),
        mode: gameMode,
        setsQuantity: setsQuantity,
        surface: surface,
        gamesPerSet: setType,
        participant1: Participant(
          firstName: me,
          lastName: "x",
          userId: "",
          participantId: "",
          ci: "",
        ),
        participant2: Participant(
          firstName: rival,
          lastName: "x",
          userId: "",
          participantId: "",
          ci: "",
        ),
        participant3: Participant(
          firstName: partner,
          lastName: "x",
          userId: "",
          participantId: "",
          ci: "",
        ),
        participant4: Participant(
          firstName: rival2,
          lastName: "x",
          userId: "",
          participantId: "",
          ci: "",
        ),
        currentGame: Game(),
        tracker: TournamentMatchStats(
          trackerId: "",
          matchId: "",
          player1: ParticipantStats.skeleton(),
          player2: ParticipantStats.skeleton(),
          player3:
              gameMode == GameMode.double ? ParticipantStats.skeleton() : null,
          player4:
              gameMode == GameMode.double ? ParticipantStats.skeleton() : null,
        ),
        sets: List.generate(setsQuantity, (index) => Set(setType: setType)),
        goldenPoint: goldenPoint,
      );

      provider.startTrackingMatch(match, false);

      //navigate
      Navigator.pushNamed(context, TrackPracticeMatch.route);
    }

    showStep() {
      if (formStep == 2) {
        return PlayersForm(back: back, createGame: createGame, mode: gameMode);
      } else {
        // step == 1
        return ConfigForm(next: next);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Partido de práctica"),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: showStep(),
      ),
    );
  }
}
