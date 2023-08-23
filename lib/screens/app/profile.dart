import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/outline_button.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/change_password.dart';
import 'package:tennis_app/screens/app/edit_profile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  static const route = '/profile';

  @override
  State<UserProfile> createState() => _ProfileState();
}

class _ProfileState extends State<UserProfile> {
  UserDto? user;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(status: "Cargando...");
    SharedPreferences storage = await SharedPreferences.getInstance();

    String jsonUser = storage.getString("user") ?? "";

    if (jsonUser.isEmpty) {
      EasyLoading.dismiss();
      EasyLoading.showError("Inicia sesion para cargar tus datos de perfil");
      return;
    }

    setState(() {
      user = UserDto.fromJson(jsonDecode(jsonUser));
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTitle(
          icon: Icons.settings,
          title: "Configuración",
        ),
      ),
      body: SingleChildScrollView(
        child: user != null
            ? Container(
                width: double.maxFinite,
                margin: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${user!.firstName} ${user!.lastName}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 16)),
                          Text(
                            user!.email,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyButton(
                      text: 'Editar perfil',
                      onPress: () {
                        Navigator.of(context).pushNamed(EditProfile.route);
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                    OutlineButoon(
                      text: 'Cambiar contraseña',
                      onPressed: () {
                        Navigator.of(context).pushNamed(ChangePassword.route);
                      },
                    )
                  ],
                ),
              )
            : const Center(),
      ),
    );
  }
}
