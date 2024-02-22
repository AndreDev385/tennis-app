import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/shared/appbar_title.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/outline_button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/dtos/user_dto.dart';
import 'package:tennis_app/screens/app/user/change_password.dart';
import 'package:tennis_app/screens/app/user/edit_profile.dart';
import 'package:tennis_app/screens/auth/login.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/services/user/delete_user.dart';

class UserConfig extends StatefulWidget {
  const UserConfig({super.key});

  static const route = '/profile';

  @override
  State<UserConfig> createState() => _ProfileState();
}

class _ProfileState extends State<UserConfig> {
  UserDto? user;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show();
    StorageHandler st = await createStorageHandler();

    String jsonUser = st.getUser() ?? "";

    if (jsonUser.isEmpty) {
      EasyLoading.dismiss();
      EasyLoading.showError("Inicia sesión para cargar tus datos de perfil");
      return;
    }

    setState(() {
      user = UserDto.fromJson(jsonDecode(jsonUser));
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    logOut() async {
      StorageHandler st = await createStorageHandler();
      st.logOut();
      Navigator.of(context).pushNamed(LoginPage.route);
    }

    handleDeleteUser() async {
      final result = await deleteUserAccount();

      if (result.isFailure) {
        return showMessage(context, result.error!, ToastType.error);
      }

      showMessage(context, result.getValue(), ToastType.success);
      logOut();
    }

    modalBuilder(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Estás seguro de eliminar tu cuenta?"),
              content: const Text(
                "Si procedes con esta acción tu cuenta y datos serán eliminados",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    handleDeleteUser();
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    "Eliminar",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: BackButton(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
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
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 16)),
                          Text(
                            user!.email,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
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
                    OutlineButton(
                      text: 'Cambiar contraseña',
                      onPressed: () {
                        Navigator.of(context).pushNamed(ChangePassword.route);
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                    MyButton(
                      text: "Eliminar cuenta",
                      color: Theme.of(context).colorScheme.error,
                      onPress: () => modalBuilder(context),
                    )
                  ],
                ),
              )
            : const Center(),
      ),
    );
  }
}
