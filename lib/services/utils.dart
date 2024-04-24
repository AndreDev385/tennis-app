class PaginateResponse<T> {
  final int count;
  final List<T> rows;

  const PaginateResponse({
    required this.count,
    required this.rows,
  });
}

String mapQueryToUrlString(Map<String, dynamic> query) {
  String url = "?";

  int count = 0;

  query.forEach((key, value) {
    if (count == 0) {
      url += "$key=$value";
    } else {
      url += "&$key=$value";
    }
    count++;
  });

  return url;
}

class Result<T> {
  final bool isFailure;
  final T? value;
  final String? error;

  const Result({
    required this.isFailure,
    this.value,
    this.error,
  });

  T getValue() {
    return value!;
  }

  Result.fail(String err)
      : isFailure = true,
        error = err,
        value = null;

  Result.ok(dynamic data)
      : isFailure = false,
        error = null,
        value = data;
}
