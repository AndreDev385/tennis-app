// --dart-define=VARIABLE_NAME=VALUE
abstract class Environment {
  static const apiUrl = String.fromEnvironment(
    "API_URL",
    defaultValue: "https://gamemind-app-7ce0a0ff4c64.herokuapp.com/api/v1/",
    // defaultValue: "http://localhost:3000/api/v1/",
  );

  static const webSockets = String.fromEnvironment(
    "WS_URL",
    defaultValue: "ws://gamemind-app-7ce0a0ff4c64.herokuapp.com",
    // defaultValue: "ws://localhost:3000",
  );
}
