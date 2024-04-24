import 'package:flutter/material.dart';
import 'package:tennis_app/components/game_score/score_board.dart';

class TournamentMatchDetail extends StatelessWidget {
  static const route = "/tournament-match-detail";

  final String matchId;

  const TournamentMatchDetail({
    super.key,
    required this.matchId,
  });

  @override
  Widget build(BuildContext context) {
    print("${this.matchId}");

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(), //ScoreBoard(),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Pareja vs"),
                    Tab(text: "J1 vs J2"),
                    Tab(text: "J3 vs J4"),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Text("1"),
                  Text("2"),
                  Text("3"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
