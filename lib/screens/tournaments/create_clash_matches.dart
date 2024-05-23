import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/tournaments/create_clash_matches/match_inputs.dart';
import 'package:tennis_app/domain/shared/utils.dart';
import 'package:tennis_app/domain/tournament/participant.dart';
import 'package:tennis_app/dtos/tournaments/contest_clash.dart';
import 'package:tennis_app/services/tournaments/clash/create_clash_matches.dart';
import 'package:tennis_app/services/tournaments/participants/paginate.dart';
import 'package:tennis_app/utils/state_keys.dart';

class CreateClashMatches extends StatefulWidget {
  final ContestClash clash;
  final int matchesPerClash;

  const CreateClashMatches({
    super.key,
    required this.clash,
    required this.matchesPerClash,
  });

  @override
  State<CreateClashMatches> createState() => _CreateClashMatchesState();
}

class _CreateClashMatchesState extends State<CreateClashMatches> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> state = {
    StateKeys.loading: true,
    StateKeys.error: "",
  };
  List<Participant> t1Participants = [];
  List<Participant> t2Participants = [];

  List<String> surfaces = [
    Surfaces.hard,
    Surfaces.clay,
    Surfaces.grass,
  ];

  RequestData? formData;

  _getParticipants(List<String> participantIds, bool team1) async {
    final result = await paginateParticipants(
      limit: 999,
      offset: 0,
      participantIds: participantIds,
    );

    if (result.isFailure) {
      setState(() {
        state[StateKeys.loading] = false;
        state[StateKeys.error] = result.error;
      });
    }

    setState(() {
      state[StateKeys.loading] = false;
      if (team1) {
        t1Participants = result.getValue().rows;
      } else {
        t2Participants = result.getValue().rows;
      }
    });
  }

  _getData() async {
    await Future.wait<void>([
      _getParticipants(widget.clash.team1.participantsIds, true),
      _getParticipants(widget.clash.team2.participantsIds, false),
    ]);
  }

  @override
  void initState() {
    _getData();
    setState(() {
      formData = RequestData(
          clashId: widget.clash.contestClashId,
          matches: List.filled(widget.matchesPerClash, MatchCreationData()),
          surface: Surfaces.hard);
    });
    super.initState();
  }

  _handleSubmit() async {
    //final result = await createClashMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear partidos"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                /* Input Group */
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: "Superficie",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  items: surfaces.map((e) {
                    return DropdownMenuItem(
                        value: e, child: Text(e.capitalizeFirst!));
                  }).toList(),
                  value: formData?.surface,
                  onChanged: (dynamic value) {
                    setState(() {
                      formData?.surface = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Elige una superficie";
                    }
                    return null;
                  },
                ),
                ...formData!.matches.asMap().entries.map((entry) {
                  return MatchInputs(
                    idx: entry.key,
                    formKey: formKey,
                    t1Participants: t1Participants,
                    t2Participants: t2Participants,
                    data: entry.value,
                  );
                }),
                /* End Input Group */
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: MyButton(
                    text: "Aceptar",
                    onPress: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
