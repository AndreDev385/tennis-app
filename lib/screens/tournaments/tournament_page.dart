import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:tennis_app/components/shared/slider.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/components/tournaments/tournament_page/draw.dart';
import 'package:tennis_app/components/tournaments/tournament_page/matches.dart';
import 'package:tennis_app/components/tournaments/tournament_page/participants.dart';
import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/dtos/tournaments/contest.dart';
import 'package:tennis_app/dtos/tournaments/tournament_ad.dart';
import 'package:tennis_app/providers/curr_tournament_provider.dart';
import 'package:tennis_app/providers/tournament_match_provider.dart';
import 'package:tennis_app/screens/home.dart';
import 'package:tennis_app/screens/tournaments/track_tournament_match.dart';
import 'package:tennis_app/services/tournaments/contest/get_contest.dart';
import 'package:tennis_app/services/tournaments/contest/list_contest.dart';
import 'package:tennis_app/services/tournaments/list_ads.dart';
import 'package:tennis_app/styles.dart';
import 'package:tennis_app/utils/format_contest_title.dart';
import '../../services/storage.dart';
import '../../utils/state_keys.dart';

class TournamentPage extends StatefulWidget {
  final CurrentTournamentProvider tournamentProvider;
  final bool updateContest;

  const TournamentPage({
    super.key,
    required this.tournamentProvider,
    required this.updateContest,
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
  List<TournamentAd> ads = [];

  Contest? _selectedContest;
  int _selectedSectionIdx = 1;
  int _selectedContestIdx = 0;

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
      widget.tournamentProvider.tournament!.tournamentId,
    );

    if (result.isFailure) {
      setState(() {
        state[StateKeys.error] = result.error;
        state[StateKeys.loading] = false;
      });
      return;
    }

    if (widget.tournamentProvider.contest == null || widget.updateContest) {
      if (result.getValue().length > 0) {
        await _getContestData(result.getValue()[0].contestId);
        widget.tournamentProvider.setIdx(0);
        setState(() {
          _selectedContestIdx = 0;
        });
      }
    } else {
      setState(() {
        _selectedContest = widget.tournamentProvider.contest;
        _selectedContestIdx = widget.tournamentProvider.selectedIdx;
      });
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
      _selectedContest = result.getValue();
    });
  }

  _listTournamentAds() async {
    final result = await listTournamentAds(
      widget.tournamentProvider.tournament!.tournamentId,
    );

    setState(() {
      ads = result;
    });
  }

  _getData() async {
    StorageHandler st = await createStorageHandler();

    await _checkForPendingMatch(st);
    await _getTournamentContests();
    await _listTournamentAds();
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
        title: Text(widget.tournamentProvider.tournament!.name),
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
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          constraints: BoxConstraints(maxWidth: 768),
          child: render(),
        ),
      ),
      bottomNavigationBar: state[StateKeys.loading]
          ? null
          : BottomNavigationBar(
              unselectedItemColor: Theme.of(context).colorScheme.onBackground,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              showUnselectedLabels: true,
              currentIndex: _selectedSectionIdx,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: "Participantes",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports_tennis),
                  label: "Partidos/Live",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_tree),
                  label: "Draw",
                ),
                /*BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil",
            ),*/
              ],
            ),
    );
  }

  render() {
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
    if (contests.length < 1 && !state[StateKeys.loading]) {
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
    final contestList = state[StateKeys.loading]
        ? List.filled(6, Contest.skeleton())
        : contests;
    return Skeletonizer(
      enabled: state[StateKeys.loading],
      child: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          if (ads.length > 0)
            SliverToBoxAdapter(
              child: CardSlider(
                cards: ads.map((a) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        MyTheme.cardBorderRadius,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Image.asset(
                        a.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(bottom: 16),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  GroupButton(
                    controller: GroupButtonController(
                      selectedIndex: _selectedContestIdx,
                    ),
                    options: GroupButtonOptions(
                      borderRadius: BorderRadius.circular(
                        MyTheme.regularBorderRadius,
                      ),
                      unselectedColor: Theme.of(context).colorScheme.secondary,
                      unselectedTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    onSelected: (_, int, bool) {
                      _getContestData(contests[int].contestId);
                      setState(() {
                        _selectedContestIdx = int;
                        widget.tournamentProvider.setIdx(int);
                      });
                    },
                    buttons: contestList.map((c) {
                      return formatContestTitle(c);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: renderSections(_selectedSectionIdx),
          )
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedSectionIdx = index;
    });
  }

  renderSections(int idx) {
    return <Widget>[
      /* players */
      ParticipantsList(
        loading: state[StateKeys.loading],
        mode: contests.isEmpty ? "" : contests[_selectedContestIdx].mode,
        inscribed: _selectedContest?.inscribed,
      ),
      /* end players */
      TournamentMatchesSection(
        contestId:
            contests.isEmpty ? "" : contests[_selectedContestIdx].contestId,
        showClashes: widget.tournamentProvider.contest?.mode == GameMode.team,
      ),
      DrawSection(
        contestId:
            contests.isEmpty ? "" : contests[_selectedContestIdx].contestId,
      ),
      //Text("4")
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
