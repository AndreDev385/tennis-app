import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/match/couple_vs.dart';
import 'package:tennis_app/components/cta/match/match_header.dart';
import 'package:tennis_app/components/cta/match/single_vs.dart';
import 'package:tennis_app/domain/game_rules.dart';
import 'package:tennis_app/dtos/match_dtos.dart';
import 'package:tennis_app/services/get_match_by_id.dart';

class MatchResultContainer extends StatefulWidget {
  const MatchResultContainer({
    super.key,
    required this.matchId,
    required this.showMore,
  });

  final String matchId;
  final bool showMore;

  @override
  State<MatchResultContainer> createState() => _MatchResultContainerState();
}

class _MatchResultContainerState extends State<MatchResultContainer> {
  MatchDto? match;
  String rivalBreakPts = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(status: "Cargando...");
    await getMatch();
    EasyLoading.dismiss();
  }

  getMatch() async {
    final result = await getMatchById(widget.matchId);

    if (result.isFailure) {
      return;
    }

    setState(() {
      match = result.getValue();
    });
  }

  renderVs(MatchDto match) {
    return match.mode == GameMode.double
        ? CoupleVs(
            match: match,
            showMore: widget.showMore,
            rivalBreakPts: rivalBreakPts,
          )
        : SingleVs(
            match: match,
            rivalBreakPts: rivalBreakPts,
            showMore: widget.showMore,
          );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: match?.tracker != null
            ? Column(
                children: [
                  MatchHeader(
                    matchState: match!,
                  ),
                  renderVs(match!),
                ],
              )
            : null,
      ),
    );
  }
}
