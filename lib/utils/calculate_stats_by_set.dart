import 'package:tennis_app/domain/shared/set.dart';
import 'package:tennis_app/domain/tournament/participant_tracker.dart';
import 'package:tennis_app/domain/tournament/tournament_match_stats.dart';
import 'package:tennis_app/dtos/sets_dto.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';

//TODO: refactor ->> To handle multiple setsQuantity configurations
TrackerDto calculateStatsBySet({
  required Sets sets,
  required List<bool> options,
  required TrackerDto total,
}) {
  if (options[0] == true) {
    return sets.list[0].stats != null ? sets.list[0].stats! : total;
  }

  if (options[1] == true) {
    if (sets.list[1].stats == null || sets.list[0].stats == null) {
      return total;
    }
    return TrackerDto.calculate(
      first: sets.list[1].stats!,
      second: sets.list[0].stats!,
    );
  }

  if (options[2] == true) {
    if (sets.list[1].stats == null || sets.list[2].stats == null) {
      return total;
    }

    return TrackerDto.calculate(
      first: sets.list[2].stats!,
      second: sets.list[1].stats!,
    );
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
