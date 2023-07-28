import 'package:flutter/material.dart';
import 'package:tennis_app/components/cta/teams/team_container.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';

class TeamDetailArgs {
  final TeamDto team;

  const TeamDetailArgs(this.team);
}

class TeamDetail extends StatefulWidget {
  const TeamDetail({super.key});

  static const route = 'cta/team-detail';

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  @override
  Widget build(BuildContext context) {
    final TeamDetailArgs args =
        ModalRoute.of(context)!.settings.arguments as TeamDetailArgs;

    return TeamContainer(team: args.team);
  }
}
