import 'package:tennis_app/dtos/sets_dto.dart';
import 'package:tennis_app/dtos/tracker_dto.dart';

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
