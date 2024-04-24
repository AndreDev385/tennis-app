import 'package:flutter/material.dart';
import 'package:tennis_app/components/tournaments/tournament_page/draw.dart';
import 'package:tennis_app/components/tournaments/tournament_page/matches.dart';
import 'package:tennis_app/components/tournaments/tournament_page/participants.dart';
import 'package:tennis_app/dtos/tournaments/contest.dart';
import 'package:tennis_app/dtos/tournaments/tournament.dart';
import 'package:tennis_app/services/tournaments/contest/get_contest.dart';
import 'package:tennis_app/services/tournaments/contest/list_contest.dart';
import 'package:tennis_app/utils/format_contest_title.dart';

import '../../utils/state_keys.dart';

class TournamentPage extends StatefulWidget {
  static const route = "tournament-detail";

  final Tournament tournament;

  const TournamentPage({
    super.key,
    required this.tournament,
  });

  @override
  State<StatefulWidget> createState() => _TournamentPage();
}

class _TournamentPage extends State<TournamentPage> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };

  List<Contest> contests = [];
  Contest? selectedContest;

  int _selectedIndex = 0;

  _getTournamentContests() async {
    final result = await listContest(widget.tournament.tournamentId);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error;
        state[StateKeys.loading] = false;
      });
    }

    if (result.getValue().length > 0) {
      await _getContestData(result.getValue()[0].contestId);
    }

    setState(() {
      contests = result.getValue();
      state[StateKeys.loading] = false;
    });
  }

  _getContestData(String contestId) async {
    setState(() {
      state[StateKeys.error] = "";
      state[StateKeys.loading] = true;
    });

    final result = await getContest(contestId);

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error;
        state[StateKeys.loading] = false;
      });
      return;
    }

    setState(() {
      selectedContest = result.getValue();
      state[StateKeys.loading] = false;
    });
  }

  _getData() async {
    await _getTournamentContests();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.tournament.name),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          constraints: BoxConstraints(maxWidth: 768),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        onPressed: () => selectContest(),
                        child: Row(
                          children: [
                            Text(
                              "${selectedContest != null ? formatContestTitle(selectedContest!) : ""}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).colorScheme.onSurface,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                    ],
                    /* end select category */
                  ),
                ),
              ),
              SliverFillRemaining(
                child: renderSections(_selectedIndex, selectedContest),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Participantes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_tennis),
            label: "Partidos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),
            label: "Draw",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }

  selectContest() => showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Selecciona una competencia",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...contests.map((c) {
                  return InkWell(
                    onTap: () async {
                      await _getContestData(c.contestId);
                      Navigator.pop(context);
                    },
                    child: ListTile(title: Text(formatContestTitle(c))),
                  );
                }).toList(),
              ],
            ),
          );
        },
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  renderSections(int idx, Contest? contest) {
    return <Widget>[
      /* players */
      ParticipantsList(
        mode: contest?.mode,
        loading: state[StateKeys.loading],
        inscribed: contest?.inscribed,
      ),
      /* end players */
      TournamentMatchesSection(
        loading: state[StateKeys.loading],
      ),
      DrawSection(
        contestId: contest?.contestId,
        loading: state[StateKeys.loading],
      ),
      Text("4")
    ][idx];
  }
}

class ContestStages extends StatefulWidget {
  final Contest? contest;

  const ContestStages({
    super.key,
    required this.contest,
  });

  @override
  State<StatefulWidget> createState() => _ContestStages();
}

class _ContestStages extends State<ContestStages> {
  @override
  void didUpdateWidget(covariant ContestStages oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contest != null && oldWidget.contest != widget.contest) {
      //TODO: call find stage
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Text(
            "Tabla",
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).colorScheme.onSurface,
          )
        ],
      ),
    );
  }
}
