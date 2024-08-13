import 'dart:convert';

import 'package:tennis_app/dtos/home_ad_dto.dart';
import 'package:tennis_app/services/api.dart';

Future<List<HomeAdDto>> listHomeAds() async {
  final response = await Api.get("ads/home/");

  List<dynamic> body = jsonDecode(response.body);

  if (response.statusCode != 200) {
    return [];
  }

  return body.map((e) {
    return HomeAdDto.fromJson(e);
  }).toList();
}
