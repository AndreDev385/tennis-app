import 'package:flutter/material.dart';

import '../../utils/format_player_name.dart';

class Avatar extends StatelessWidget {
  final String firstName;
  final String lastName;

  const Avatar({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(formatInitials(firstName, lastName)),
      radius: 24,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
