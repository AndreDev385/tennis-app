import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/cta/live_tracker/live_tracker.dart';
import 'package:tennis_app/domain/game_rules.dart';

class TrackMatchArgs {
  final String matchId;

  const TrackMatchArgs({required this.matchId});
}

class TrackMatch extends StatelessWidget {
  const TrackMatch({super.key});

  static const route = "/cta/track-match";

  @override
  Widget build(BuildContext context) {
    final TrackMatchArgs args =
        ModalRoute.of(context)!.settings.arguments as TrackMatchArgs;

    final gameProvider = Provider.of<GameRules>(context);

    return DefaultTabController(
      length: 2,
      child: LiveTracker(
        matchId: args.matchId,
        gameProvider: gameProvider,
      ),
    );
  }
}
