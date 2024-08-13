import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../dtos/clash_dtos.dart';
import '../../../dtos/user_dto.dart';
import '../../../screens/cta/create_clash_matchs.dart';
import '../../../services/storage.dart';
import '../../shared/button.dart';

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
    StorageHandler st = await createStorageHandler();

    String rawUser = st.getUser() ?? "";

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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }
}
