import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/club_dto.dart';
import 'package:tennis_app/dtos/journey_dto.dart';
import 'package:tennis_app/providers/tracker_state.dart';
import 'package:tennis_app/services/clash/create_clash.dart';
import 'package:tennis_app/services/list_categories.dart';
import 'package:tennis_app/services/clubs/list_clubs.dart';
import 'package:tennis_app/services/list_journeys.dart';

import 'tracker/tracker_cta.dart';

class CreateClash extends StatefulWidget {
  const CreateClash({
    super.key,
    required this.currentClub,
  });

  final ClubDto currentClub;

  @override
  State<CreateClash> createState() => _CreateClashState();
}

class _CreateClashState extends State<CreateClash> {
  final formKey = GlobalKey<FormState>();
  List<ClubDto> clubs = [];
  List<CategoryDto> categories = [];
  List<JourneyDto> journeys = [];
  List<String> teams = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"];

  // form data
  late String categoryId;
  String? rivalClubId;
  late String clubTeam;
  late String rivalClubTeam;
  late String host;
  String? journey;

  @override
  void initState() {
    EasyLoading.show();
    getData();
    super.initState();
  }

  getData() async {
    await getClubs();
    await getCategories();
    await getJourneys();
    EasyLoading.dismiss();
  }

  getCategories() async {
    final result = await listCategories({});

    if (result.isFailure) {
      return;
    }

    setState(() {
      categories = result.getValue();
    });
  }

  getJourneys() async {
    final result = await listJourneys();

    if (result.isFailure) {
      return;
    }

    setState(() {
      journeys = result.getValue();
    });
  }

  getClubs() async {
    Map<String, String> query = {};
    final result = await listClubs(query);
    if (result.isFailure) {
      return;
    }
    List<ClubDto> clubs = result.getValue();
    setState(() {
      this.clubs = clubs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final trackerProvider = Provider.of<TrackerState>(context);

    List<DropdownMenuItem> renderHostList() {
      if (journey == null || rivalClubId == null) {
        return [];
      }
      if (journey == "Final") {
        return clubs
            .map(
              (e) => DropdownMenuItem(
                value: e.clubId,
                child: Text(e.name),
              ),
            )
            .toList();
      }

      ClubDto rivalClub =
          clubs.where((element) => element.clubId == rivalClubId).toList()[0];

      if (rivalClub.clubId == widget.currentClub.clubId) {
        return [
          DropdownMenuItem(
            value: widget.currentClub.clubId,
            child: Text(widget.currentClub.name),
          )
        ];
      }

      return [
        DropdownMenuItem(
          value: widget.currentClub.clubId,
          child: Text(widget.currentClub.name),
        ),
        DropdownMenuItem(
          value: rivalClubId,
          child: Text(rivalClub.name),
        ),
      ];
    }

    void handleCreateClash(BuildContext context) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        EasyLoading.show(status: "Creando encuentro");

        TeamForClash team1 = TeamForClash(
          name: clubTeam,
          clubId: trackerProvider.currentClub!.clubId,
        );

        TeamForClash team2 = TeamForClash(
          name: rivalClubTeam,
          clubId: rivalClubId!,
        );

        CreateClashDto dto = CreateClashDto(
          categoryId: categoryId,
          team1: team1,
          team2: team2,
          host: host,
          journey: journey!,
        );

        createClash(dto).then((value) {
          EasyLoading.dismiss();
          if (value.isFailure) {
            showMessage(
              context,
              value.error ?? "Ha ocurrido un error",
              ToastType.error,
            );
            return;
          }
          showMessage(
            context,
            "Encuentro creado exitosamente",
            ToastType.success,
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TrackerCTA(
                club: widget.currentClub,
              ),
            ),
          );
          EasyLoading.dismiss();
        }).catchError((e) {
          showMessage(
            context,
            "Ha ocurrido un error",
            ToastType.error,
          );
          EasyLoading.dismiss();
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Crear Encuentro"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Categoría",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                items: categories
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.categoryId,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    categoryId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Elige una categoría";
                  }
                  return null;
                },
              ),
              /*DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Club",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                items: clubsWithSubscription
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.clubId,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    clubId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Elige un club subscrito";
                  }
                  return null;
                },
              ),*/
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Club Rival",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                items: clubs
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.clubId,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    rivalClubId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Elige un club rival";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Equipo",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    items: teams
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        clubTeam = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Elige el equipo del club subscrito";
                      }
                      return null;
                    },
                  )),
                  const Padding(padding: EdgeInsets.only(right: 4, left: 4)),
                  Expanded(
                      child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Equipo rival",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    items: teams
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        rivalClubTeam = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Elige el equipo del club rival";
                      }
                      return null;
                    },
                  )),
                ],
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Jornada",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                items: journeys
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.name,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    journey = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Elige una jornada";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Anfitrión",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                items: renderHostList(),
                onChanged: (dynamic value) {
                  setState(() {
                    host = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Elige el club anfitrión";
                  }
                  return null;
                },
              ),
              MyButton(
                text: "Aceptar",
                onPress: () => handleCreateClash(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
