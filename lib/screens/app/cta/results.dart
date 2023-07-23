import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/clash/clash_card.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/list_clash.dart';

class ClashResults extends StatefulWidget {
  const ClashResults({super.key});

  @override
  State<ClashResults> createState() => _ClashResultsState();
}

class _ClashResultsState extends State<ClashResults> {
  List<ClashDto> _clashs = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    EasyLoading.show(status: "Cargando...");
    await _listClashResults();
    EasyLoading.dismiss();
  }

  _listClashResults() async {
    Map<String, String> query = {
      'isFinish': 'true',
    };

    final result = await listClash(query);

    if (result.isFailure) {
      print("${result.error}");
      return;
    }

    print("${result.getValue()}");

    setState(() {
      _clashs = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
            children: _clashs
                .asMap()
                .entries
                .map(
                  (entry) => ClashCard(clash: entry.value),
                )
                .toList()),
      ),
    );
  }
}
