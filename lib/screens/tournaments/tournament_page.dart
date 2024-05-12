import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/components/tournaments/tournament_page/draw.dart';
import 'package:tennis_app/components/tournaments/tournament_page/matches.dart';
import 'package:tennis_app/components/tournaments/tournament_page/participants.dart';
import 'package:tennis_app/dtos/tournaments/contest.dart';
import 'package:tennis_app/providers/curr_tournament_provider.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/screens/home.dart';
import 'package:tennis_app/screens/tournaments/track_tournament_match.dart';
import 'package:tennis_app/services/tournaments/contest/get_contest.dart';
import 'package:tennis_app/services/tournaments/contest/list_contest.dart';
import 'package:tennis_app/utils/format_contest_title.dart';

import '../../components/tournaments/participant_card.dart';
import '../../dtos/tournaments/inscribed.dart';
import '../../services/storage.dart';
import '../../utils/state_keys.dart';

class TournamentPage extends StatefulWidget {
  final CurrentTournamentProvider tournamentProvider;

  const TournamentPage({
    super.key,
    required this.tournamentProvider,
  });

  @override
  State<StatefulWidget> createState() => _TournamentPage();
}

class _TournamentPage extends State<TournamentPage> {
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
    "pendingMatch": false,
  };

  List<Contest> contests = [];

  int _selectedIndex = 0;

  _checkForPendingMatch(StorageHandler st) {
    String? matchStr = st.getTournamentMatch();

    setState(() {
      if (matchStr == null) {
        state['pendingMatch'] = false;
      } else {
        state['pendingMatch'] = true;
      }
    });
  }

  _getTournamentContests() async {
    final result = await listContest(
      widget.tournamentProvider.currT!.tournamentId,
    );

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error;
        state[StateKeys.loading] = false;
      });
    }

    if (widget.tournamentProvider.contest == null) {
      if (result.getValue().length > 0) {
        await _getContestData(result.getValue()[0].contestId);
      }
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

    widget.tournamentProvider.setContest(result.getValue());

    setState(() {
      state[StateKeys.loading] = false;
    });
  }

  _getData() async {
    StorageHandler st = await createStorageHandler();

    await _checkForPendingMatch(st);
    await _getTournamentContests();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<TournamentMatchProvider>(context);

    void resumeMatch(BuildContext context) async {
      final result = await gameProvider.restorePendingMatch();

      if (result.isFailure) {
        showMessage(
          context,
          "Ha ocurrido un error al recuperar le partido",
          ToastType.error,
        );
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TournamentMatchTracker()),
      );
    }

    resumePendingMatch() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text(
                "Continuar partido",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content:
                  Text("Deseas continuar el partido que tienes pendiente?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
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
                    resumeMatch(context);
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.tournamentProvider.currT!.name),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MyHomePage()),
              (route) => route.isFirst,
            );
          },
        ),
        actions: [
          if (state['pendingMatch'])
            IconButton(
              onPressed: () => resumePendingMatch(),
              icon: Icon(
                Icons.play_arrow,
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _getData();
        },
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            constraints: BoxConstraints(maxWidth: 768),
            child: render(),
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

  render() {
    if (state[StateKeys.loading]) {
      final fakeParticipants = List.filled(10, InscribedParticipant.skeleton());
      return ListView(
        children: fakeParticipants.map((r) {
          return ParticipantCard(inscribed: r);
        }).toList(),
      );
    }
    if ((state[StateKeys.error] as String).length > 0) {
      return Text(
        "Ha ocurrido un error",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).colorScheme.error,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    if (contests.length < 1) {
      return Text(
        "No hay competencias",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      );
    }
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                TextButton(
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
                  onPressed: () => selectContest(),
                  child: Row(
                    children: [
                      Text(
                        "${widget.tournamentProvider.contest != null ? formatContestTitle(widget.tournamentProvider.contest!) : ""}",
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
          child: renderSections(_selectedIndex),
        )
      ],
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

  renderSections(int idx) {
    return <Widget>[
      /* players */
      ParticipantsList(
        loading: state[StateKeys.loading],
        mode: widget.tournamentProvider.contest?.mode,
        inscribed: widget.tournamentProvider.contest?.inscribed,
      ),
      /* end players */
      TournamentMatchesSection(
        contestId: widget.tournamentProvider.contest!.contestId,
        loading: state[StateKeys.loading],
      ),
      DrawSection(
        contestId: widget.tournamentProvider.contest!.contestId,
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
