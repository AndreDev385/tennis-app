import 'dart:convert';

import 'package:tennis_app/dtos/tournaments/tournament_ad.dart';
import 'package:tennis_app/services/api.dart';

Future<List<TournamentAd>> listTournamentAds(String tournamentId) async {
  final response = await Api.get("tournament/ads/$tournamentId");

  if (response.statusCode != 200) {
    //handle error
    return [];
  }

  List<dynamic> list = jsonDecode(response.body);

  return list.map((r) => TournamentAd.fromJson(r)).toList();
}
