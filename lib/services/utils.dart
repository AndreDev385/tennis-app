class PaginateResponse<T> {
  final int count;
  final List<T> rows;

  const PaginateResponse({
    required this.count,
    required this.rows,
  });
}

addSingle(String actual, String key, dynamic value, bool isFirst) {
  if (isFirst) {
    actual += "$key=$value";
  } else {
    actual += "&$key=$value";
  }
  return actual;
}

addArray(String actual, String key, List<dynamic> values, bool isFirst) {
  bool internal = isFirst;
  values.forEach((value) {
    if (internal) {
      actual += "$key=$value";
    } else {
      actual += "&$key=$value";
    }
    internal = false;
  });
  return actual;
}

String mapQueryToUrlString(Map<String, dynamic> query) {
  String url = "?";

  int count = 0;

  query.forEach((key, value) {
    if (value.runtimeType == List<String>) {
      url = addArray(url, key, value, count == 0);
    } else {
      url = addSingle(url, key, value, count == 0);
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
