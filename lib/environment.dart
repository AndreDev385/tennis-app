// --dart-define=VARIABLE_NAME=VALUE
abstract class Environment {
  static const apiUrl = String.fromEnvironment(
    "API_URL",
    defaultValue: "http://localhost:3000/api/v1/",
  );
}
