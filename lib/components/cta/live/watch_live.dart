import 'package:flutter/material.dart';

import 'package:tennis_app/components/cta/live/live_connection.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';

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
  bool showMore = false;

  changeShowMore() {
    setState(() {
      showMore = !showMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final WatchLiveArgs args =
        ModalRoute.of(context)!.settings.arguments as WatchLiveArgs;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const AppBarTitle(
          icon: Icons.live_tv,
          title: "Live",
        ),
      ),
      body: LiveConnection(
        matchId: args.matchId,
        showMore: showMore,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(
          showMore ? Icons.remove : Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        label: Text(
          showMore ? "Mostrar Menos" : "Mostrar Mas",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: () => changeShowMore(),
      ),
    );
  }
}
