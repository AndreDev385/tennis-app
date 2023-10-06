import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/match_result.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/game_dto.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/components/cta/match/couple_vs.dart';
import 'package:tennis_app/components/cta/match/single_vs.dart';
import 'package:tennis_app/dtos/sets_dto.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
import 'package:tennis_app/environment.dart';
import 'package:tennis_app/screens/app/cta/home.dart';
import 'package:tennis_app/services/get_match_by_id.dart';

class LiveConnection extends StatefulWidget {
  const LiveConnection({
    super.key,
    required this.matchId,
    required this.showMore,
  });

  final String matchId;
  final bool showMore;

  @override
  State<LiveConnection> createState() => _LiveConnectionState();
}

class _LiveConnectionState extends State<LiveConnection> {
  late IO.Socket socket;
  MatchDto? matchState;
  GameDto? game;
  int? servingPlayer;
  String? rivalBreakPts;

  @override
  void initState() {
    getData();
    initSocket();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  getData() async {
    EasyLoading.show();
    try {
      await getMatch();
    } catch (e) {
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  getMatch() async {
    final result = await getMatchById(widget.matchId);

    if (result.isFailure) {
      return;
    }

    setState(() {
      matchState = result.getValue();
    });
  }

  initSocket() {
    socket = IO.io(Environment.webSockets, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      connectToRoom();
    });
    // listen events
    socket.on("server:join_room", (data) => {});

    socket.on("server:update_match", (data) {
      setState(() {
        matchState?.sets = Sets.fromJson(data['sets']);
        matchState?.tracker = TrackerDto.fromJson(data['matchStats']);
        game = GameDto.fromJson(data['currentGame']);
        servingPlayer = data['servingPlayer'];
        rivalBreakPts = data['rivalBreakPts'];
      });
    });
  }

  connectToRoom() {
    Map messageMap = {'message': widget.matchId};
    socket.emit("client:join_room", messageMap);
  }

  renderVs() {
    return matchState?.mode == GameMode.double
        ? CoupleVs(
            match: matchState!,
            showMore: widget.showMore,
            rivalBreakPts: rivalBreakPts,
            servingPlayer: servingPlayer,
            currentGame: game,
          )
        : SingleVs(
            match: matchState!,
            rivalBreakPts: rivalBreakPts,
            showMore: widget.showMore,
            servingPlayer: servingPlayer,
            currentGame: game,
          );
  }

  @override
  Widget build(BuildContext context) {
    modalBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("El live ha finalizado"),
              content: const Text("Quieres ver los resultados?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(CtaHomePage.route);
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(
                      MatchResult.route,
                      arguments: MatchResultArgs(widget.matchId),
                    );
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Aceptar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    socket.on("server:match_finish", (data) {
      modalBuilder(context);
    });

    return Container(child: matchState != null ? renderVs() : const Center());
  }
}
