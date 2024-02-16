String formatDate(DateTime date) {
  final day = date.day;
  final month = date.month;
  final year = date.year;
  return "$day/$month/$year";
}
