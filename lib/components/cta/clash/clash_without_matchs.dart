import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/cta/create_clash_matchs.dart';

class ClashWithoutMatchs extends StatefulWidget {
  const ClashWithoutMatchs({super.key, required this.clash});

  final ClashDto clash;

  @override
  State<ClashWithoutMatchs> createState() => _ClashWithoutMatchsState();
}

class _ClashWithoutMatchsState extends State<ClashWithoutMatchs> {
  bool canTrack = false;

  @override
  void initState() {
    isTracker();
    super.initState();
  }

  isTracker() async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String rawUser = storage.getString("user") ?? "";

    UserDto user = UserDto.fromJson(jsonDecode(rawUser));

    setState(() {
      canTrack = user.canTrack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: canTrack
            ? Container(
                margin: const EdgeInsets.all(16),
                child: MyButton(
                  text: "Crear partidos",
                  onPress: () => Navigator.of(context).pushNamed(
                    CreateClashMatchs.route,
                    arguments: CreateClashMatchsArgs(widget.clash),
                  ),
                ),
              )
            : const Text(
                "Se están configurando los partidos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }
}
