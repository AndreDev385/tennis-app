import 'dart:convert';

import 'package:tennis_app/dtos/home_ad_dto.dart';
import 'package:tennis_app/services/api.dart';

Future<List<HomeAdDto>> listHomeAds() async {
  final response = await Api.get("add/home");

  if (response.statusCode != 200) {
    return [];
  }

  List<dynamic> body = jsonDecode(response.body);

  return body.map((e) {
    return HomeAdDto.fromJson(e);
  }).toList();
}
