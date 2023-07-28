import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/layout/header.dart';
import 'package:tennis_app/components/shared/button.dart';
import 'package:tennis_app/components/shared/toast.dart';
import 'package:tennis_app/dtos/club_dto.dart';
import 'package:tennis_app/services/create_player.dart';
import 'package:tennis_app/services/get_my_user_data.dart';
import 'package:tennis_app/services/list_clubs.dart';
import 'package:tennis_app/services/utils.dart';

class AffiliateClub extends StatefulWidget {
  const AffiliateClub({super.key});

  static const route = "/club-affiliation";

  @override
  State<AffiliateClub> createState() => _AffiliateClub();
}

class _AffiliateClub extends State<AffiliateClub> {
  final formKey = GlobalKey<FormState>();
  bool loading = true;

  var error = {
    "message": "",
    "fail": false,
  };

  String clubId = "";
  String code = "";

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: "Cargando...");

    _getVAT();
  }

  _getVAT() async {
    Map<String, String> query = {
      'symbol': 'VAT',
    };

    Result result = await listClubs(query).catchError((e) {
      setState(() {
        error['fail'] = true;
        error['message'] = "Ha ocurrido un error";
      });
    });

    if (result.isFailure) {
      setState(() {
        error['fail'] = true;
        error['message'] = "Ha ocurrido un error";
      });
      return;
    }

    List<ClubDto> list = result.value;

    setState(() {
      clubId = list[0].clubId;
      loading = false;
      EasyLoading.dismiss();
    });
  }

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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Codigo de club",
                        prefixIcon: Icon(Icons.email)),
                    onSaved: (value) {
                      code = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingresa un codigo";
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

      EasyLoading.show(status: "Cargando...");

      CreatePlayerRequest req = CreatePlayerRequest(code: code, clubId: clubId);

      createPlayer(req)
          .then((res) => {
                EasyLoading.dismiss(),
                if (res.statusCode != 200)
                  {showMessage(context, res.message, ToastType.error)}
                else
                  {
                    showMessage(context, res.message, ToastType.success),
                    getMyUserData(),
                    Navigator.of(context).pushNamed("/cta")
                  }
              })
          .catchError((e) => {EasyLoading.dismiss()});
    }
  }
}
