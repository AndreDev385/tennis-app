import 'package:flutter/material.dart';
import 'package:tennis_app/components/layout/header.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/screens/app/clubs/affiliation_success.dart';
import 'package:tennis_app/services/user/create_player.dart';
import 'package:tennis_app/services/user/get_my_user_data.dart';
import 'package:tennis_app/utils/state_keys.dart';

class AffiliateClub extends StatefulWidget {
  const AffiliateClub({super.key});

  static const route = "/club-affiliation";

  @override
  State<AffiliateClub> createState() => _AffiliateClub();
}

class _AffiliateClub extends State<AffiliateClub> {
  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> state = {
    StateKeys.loading: false,
  };

  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const Header(),
      appBar: AppBar(
        centerTitle: true,
        title: Title(color: Colors.white, child: const Text("Afiliar")),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: state[StateKeys.loading]
              ? CircularProgressIndicator()
              : Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Código de club",
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (value) {
                            code = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Ingresa un código";
                            }
                            return null;
                          },
                        ),
                      ),
                      MyButton(
                        text: "Afiliarme",
                        onPress: () => handleSubmit(context),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void handleSubmit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        state[StateKeys.loading] = true;
      });

      createPlayer({"code": code}).then((res) => {
            setState(() {
              state[StateKeys.loading] = false;
            }),
            if (res.isFailure)
              {
                showMessage(context, res.error!, ToastType.error),
              }
            else
              {
                showMessage(context, res.getValue(), ToastType.success),
                getMyUserData(),
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AffiliationSuccess(),
                  ),
                )
              }
          });
    }
  }
}
