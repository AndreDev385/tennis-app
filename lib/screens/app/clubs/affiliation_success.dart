import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tennis_app/screens/auth/login.dart';
import 'package:tennis_app/services/storage.dart';
import 'package:tennis_app/styles.dart';

class AffiliationSuccess extends StatelessWidget {
  const AffiliationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    logOut() async {
      StorageHandler st = await createStorageHandler();
      st.logOut();
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              size: 100,
              color: MyTheme.green,
            ),
            Text(
              "Tu afiliación al club se ha completado exitosamente!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            Text(
              textAlign: TextAlign.center,
              "Sera necesario que inicies sesión nuevamente para actualizar tus credenciales.",
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  logOut();
                  Navigator.of(context).pushNamed(LoginPage.route);
                },
                child: Text(
                  "Continuar",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
