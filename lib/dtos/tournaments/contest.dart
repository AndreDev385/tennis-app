import 'dart:core';

import 'package:tennis_app/dtos/category_dto.dart';
import 'package:tennis_app/dtos/tournaments/inscribed.dart';

class Summation {
  final String letter;
  final int value;

  const Summation({
    required this.letter,
    required this.value,
  });

  Summation.fromJson(Map<String, dynamic> json)
      : letter = json['letter'],
        value = json['value'];
}

class Contest {
  final String contestId;
  final String tournamentId;
  final String mode;
  final int categoryType;
  final Summation? summation;
  final CategoryDto? category;
  final InscribedList? inscribed;

  const Contest({
    required this.contestId,
    required this.tournamentId,
    required this.mode,
    required this.categoryType,
    required this.summation,
    required this.category,
    required this.inscribed,
  });

  Contest.fromJson(Map<String, dynamic> json)
      : contestId = json['contestId'],
        tournamentId = json['tournamentId'],
        mode = json['mode'],
        categoryType = json['categoryType'],
        summation = json['summation'] != null
            ? Summation.fromJson(json['summation'])
            : null,
        category = json['category'] != null
            ? CategoryDto.fromJson(json['category'])
            : null,
        inscribed = json['inscribed'] != null
            ? InscribedList.fromJson(json['inscribed'], json['mode'])
            : null;
}
