import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/clash/clash_card_leading.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/screens/app/cta/team_detail.dart';

class TeamCard extends StatelessWidget {
  const TeamCard({
    super.key,
    required this.team,
  });

  final TeamDto team;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            TeamDetail.route,
            arguments: TeamDetailArgs(team),
          );
        },
        child: SizedBox(
          height: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClashCardLeading(categoryName: team.category.name),
              const Padding(padding: EdgeInsets.only(right: 16)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          team.category.fullName,
                          style: TextStyle(
                            fontSize: team.category.fullName.length > 15 ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 4, bottom: 4)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Equipo: ${team.name}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: const Row(
                  children: [Text("Ver mas"), Icon(Icons.arrow_forward_ios)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
