import 'package:flutter/material.dart';

import 'package:tennis_app/components/cta/live/live_connection.dart';

class WatchLiveArgs {
  final String matchId;

  const WatchLiveArgs(this.matchId);
}

class WatchLive extends StatefulWidget {
  const WatchLive({super.key});

  static const route = '/watch-live';

  @override
  State<WatchLive> createState() => _WatchLiveState();
}

class _WatchLiveState extends State<WatchLive> {
  @override
  Widget build(BuildContext context) {
    final WatchLiveArgs args =
        ModalRoute.of(context)!.settings.arguments as WatchLiveArgs;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Live"),
      ),
      body: LiveConnection(matchId: args.matchId),
    );
  }
}
