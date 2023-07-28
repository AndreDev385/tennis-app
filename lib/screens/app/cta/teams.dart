import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/teams/team_card.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/list_teams.dart';

class Teams extends StatefulWidget {
  const Teams({
    super.key,
    required this.categories,
  });

  final List<CategoryDto> categories;

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  List<TeamDto> teams = [];
  List<String> teamNames = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(status: "Cargando...");
    await listClubTeams();
    EasyLoading.dismiss();
  }

  listClubTeams() async {
    final result = await listTeams();

    if (result.isFailure) {
      print(result.error);
      return;
    }

    setState(() {
      teams = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      const Text("Filtrar por:"),
                    ],
                  ),
                  DropdownButton(
                    items: widget.categories
                        .map((CategoryDto e) => DropdownMenuItem(
                              value: e.categoryId,
                              child: Text(e.name),
                            ))
                        .toList(),
                    onChanged: (dynamic value) {},
                    hint: const Text("Categoria"),
                  ),
                  DropdownButton(
                    items: teamNames
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (dynamic value) {},
                    hint: const Text("Equipo"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: teams.asMap().entries.map((entry) {
                  return TeamCard(
                    team: entry.value,
                  );
                }).toList(),
              ),
            ),
          ],
        ));
  }
}
