import 'package:tennis_app/dtos/tournaments/contest.dart';

String formatContestTitle(Contest c) {
  String? title;
  if (c.categoryType == 1) {
    title = "${c.category?.fullName}";
  } else if (c.categoryType == 0) {
    title = 'Suma ${c.summation?.value}${c.summation?.letter}';
  } else {
    title = "Open";
  }

  return title;
}
