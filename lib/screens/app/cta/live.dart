import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tennis_app/components/cta/clash/clash_card.dart';
import 'package:tennis_app/components/cta/news/carousel.dart';
import 'package:tennis_app/dtos/ad_dto.dart';
import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/clash_dtos.dart';
import 'package:tennis_app/services/list_clash.dart';

class Live extends StatefulWidget {
  const Live({
    super.key,
    required this.categories,
    required this.ads,
  });

  final List<CategoryDto> categories;
  final List<AdDto> ads;

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  List<ClashDto> _clashs = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    EasyLoading.show();
    await _listClashResults();
    EasyLoading.dismiss();
  }

  _listClashResults() async {
    Map<String, String> query = {
      'isFinish': 'false',
    };

    final result = await listClash(query).catchError((e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error al cargar encuentros");
      throw e;
    });

    if (result.isFailure) {
      return;
    }

    setState(() {
      _clashs = result.getValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(children: [
          if (widget.ads.isNotEmpty) AdsCarousel(ads: widget.ads),
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: _clashs
                  .map(
                    (entry) => Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: ClashCard(clash: entry, loadOnClick: false),
                    ),
                  )
                  .toList(),
            ),
          )
        ]),
      ),
    );
  }
}
