import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/user/edit_profile.dart';

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
    EasyLoading.show();
    StorageHandler st = await createStorageHandler();

    String jsonUser = st.getUser();

    if (jsonUser.isEmpty) {
      EasyLoading.dismiss();
      EasyLoading.showError("Inicia sesión para cargar tus datos de perfil");
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
    handleSubmit() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        EasyLoading.show();

        final data = {
          "firstName": firstName,
          "lastName": lastName,
          "email": email
        };

        editProfile(data).then((value) {
          EasyLoading.dismiss();
          if (value.isFailure) {
            showMessage(context, value.error!, ToastType.error);
            return;
          }
          showMessage(context, value.getValue(), ToastType.success);
          Navigator.of(context).pop();
        }).catchError((e) {
          EasyLoading.dismiss();
          showMessage(context, "Ha ocurrido un error", ToastType.error);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Editar Perfil"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(32),
          width: double.maxFinite,
          child: Form(
            key: formKey,
            child: Column(
              children: [
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
                MyButton(text: "Editar perfil", onPress: () => handleSubmit())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
