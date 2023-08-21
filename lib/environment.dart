// --dart-define=VARIABLE_NAME=VALUE
abstract class Environment {
  static const apiUrl = String.fromEnvironment(
    "API_URL",
    defaultValue: "http://localhost:3000/api/v1/", //https://gamemind-app-7ce0a0ff4c64.herokuapp.com/api/v1/
  );
}
