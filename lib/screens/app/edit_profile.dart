import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/dtos/user_dto.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  static const route = "/edit-profile";

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();

  late String firstName;
  late String lastName;
  late String email;

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

    UserDto user = UserDto.fromJson(jsonDecode(jsonUser));
    setState(() {
      firstName = user.firstName;
      lastName = user.lastName;
      email = user.email;
    });

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(32),
          width: double.maxFinite,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  "Editar perfil",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 24)),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Nombre", prefixIcon: Icon(Icons.person)),
                    onSaved: (value) {
                      firstName = value!;
                    },
                    initialValue: firstName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingresa tu nombre";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Apellido", prefixIcon: Icon(Icons.person)),
                    onSaved: (value) {
                      lastName = value!;
                    },
                    initialValue: lastName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingresa tu apellido";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Correo electrónico",
                        prefixIcon: Icon(Icons.email)),
                    onSaved: (value) {
                      email = value!;
                    },
                    initialValue: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingresa tu correo";
                      }
                      return null;
                    },
                  ),
                ),
                MyButton(text: "Editar perfil", onPress: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
