import 'package:tennis_app/domain/shared/set.dart';
import 'package:tennis_app/domain/tournament/tournament_match_stats.dart';
import 'package:tennis_app/dtos/sets_dto.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';

TrackerDto calculateStatsBySet({
  required Sets sets,
  required List<bool> options,
  required TrackerDto total,
}) {
  for (var i = 0; i < options.length - 1; i++) {
    if (options[i] == true) {
      // i == 0
      if (sets.list[i].stats == null) {
        return total;
      }

      if (i == 0) {
        return sets.list[i].stats!;
      }

      if (sets.list[i - 1].stats == null || sets.list[i].stats == null) {
        return total;
      }

      return TrackerDto.calculate(
        first: sets.list[i].stats!,
        second: sets.list[i - 1].stats!,
      );
    }
  }
  return total;
}

TournamentMatchStats tournamentMatchStatsBySet({
  required List<Set<Stats>> sets,
  required List<bool> options,
  required TournamentMatchStats total,
}) {
  for (var i = 0; i < options.length - 1; i++) {
    if (options[i] == true) {
      // i == 0
      if (sets[i].stats == null) {
        return total;
      }

      if (i == 0) {
        return sets[i].stats!;
      }

      if (sets[i - 1].stats == null || sets[i].stats == null) {
        return total;
      }

      return TournamentMatchStats.calculate(
        first: sets[i].stats,
        second: sets[i - 1].stats,
      );
    }
  }
  return total;
}
