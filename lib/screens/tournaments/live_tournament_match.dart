import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../components/tournaments/match_page/result_container.dart';
import '../../domain/tournament/tournament_match.dart';
import '../../environment.dart';
import '../../utils/state_keys.dart';

class LiveTournamentMatch extends StatefulWidget {
  final String matchId;

  const LiveTournamentMatch({
    super.key,
    required this.matchId,
  });

  @override
  State<LiveTournamentMatch> createState() => _LiveTournamentMatch();
}

class _LiveTournamentMatch extends State<LiveTournamentMatch> {
  late IO.Socket socket;

  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };

  TournamentMatch? match;
  bool showMore = false;

  _toggleTable() {
    setState(() {
      showMore = !showMore;
    });
  }

  @override
  void initState() {
    initSocket();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  connectToRoom() {
    Map messageMap = {'message': widget.matchId};
    socket.emit("client:join_tournament_room", messageMap);
  }

  initSocket() {
    socket = IO.io(Environment.webSockets, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });

    socket.connect();

    socket.onConnect((_) {
      print("connected");
      connectToRoom();
    });
    // listen events
    socket.on("server:join_tournament_room", (data) {
      print("join room");
    });

    socket.on("server:update_tournament_match", (data) {
      print("update_match $data");
    });

    socket.onConnectError((e) {
      print("$e connection error");
    });

    socket.onDisconnect((_) {});
  }

  @override
  Widget build(BuildContext context) {
    render() {
      if (match == null) {
        return Skeletonizer(
          child: TournamentMatchResult(
            match: TournamentMatch.skeleton(),
            showMore: showMore,
          ),
        );
      }
      return TournamentMatchResult(
        match: match!,
        showMore: showMore,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: render(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(
          showMore ? Icons.remove : Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        label: Text(
          showMore ? "Mostrar menos" : "Mostrar más",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: () => _toggleTable(),
      ),
    );
  }
}
