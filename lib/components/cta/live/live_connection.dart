import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/match/match_header.dart';
import 'package:tennis_app/components/cta/match/match_result.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/components/cta/match/couple_vs.dart';
import 'package:tennis_app/components/cta/match/single_vs.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';
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
    EasyLoading.show(status: "Cargando...");
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
    socket = IO.io("ws://localhost:3000", <String, dynamic>{
      'autoConnect': false,
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
          )
        : SingleVs(
            match: matchState!,
            rivalBreakPts: rivalBreakPts,
            showMore: widget.showMore,
          );
  }

  @override
  Widget build(BuildContext context) {
    modalBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
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
                  child: const Text("Cancelar"),
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
                  child: const Text("Aceptar"),
                ),
              ],
            );
          });
    }

    socket.on("server:match_finish", (data) {
      modalBuilder(context);
    });

    return SingleChildScrollView(
      child: Container(
        child: matchState != null
            ? Column(
                children: [
                  MatchHeader(
                    matchState: matchState!,
                    servingPlayer: servingPlayer,
                    currentGame: game,
                  ),
                  renderVs(),
                ],
              )
            : null,
      ),
    );
  }
}
