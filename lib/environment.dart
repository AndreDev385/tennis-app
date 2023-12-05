// --dart-define=VARIABLE_NAME=VALUE
abstract class Environment {
  static const apiUrl = String.fromEnvironment(
    "API_URL",
    //defaultValue: "https://gamemind-app-7ce0a0ff4c64.herokuapp.com/api/v1/",
    //defaultValue:"https://gamemind-app-test-73231707e870.herokuapp.com/api/v1/",
    defaultValue: "http://localhost:3000/api/v1/", // local
  );

  static const webSockets = String.fromEnvironment(
    "WS_URL",
    //defaultValue: "ws://gamemind-app-7ce0a0ff4c64.herokuapp.com",
    //defaultValue: "ws://gamemind-app-test-73231707e870.herokuapp.com",
    defaultValue: "ws://localhost:3000", // local
  );
}
