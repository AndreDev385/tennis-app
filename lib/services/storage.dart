import 'package:shared_preferences/shared_preferences.dart';

class KEYS {
  static const token = "accessToken";
  static const user = "user";
  static const player = "player";
  static const categories = "categories";
  static const seasons = "seasons";
  static const tennis_live = "tennis_live";
  static const tutorial_seen = "tutorial";
}

class StorageHandler {
  SharedPreferences _storage;

  StorageHandler({
    required SharedPreferences storage,
  }) : _storage = storage;

  bool isLoggedIn() {
    String? token = this._storage.getString(KEYS.token);

    return token != null;
  }

  String loadToken() {
    return this._storage.getString(KEYS.token) ?? "";
  }

  void saveToken(String token) {
    _storage.setString(KEYS.token, token);
  }

  void logOut() {
    _storage.remove(KEYS.user);
    _storage.remove(KEYS.token);
    _storage.remove(KEYS.player);
  }

  void saveUser(String userJson) {
    _storage.setString(KEYS.user, userJson);
  }

  getUser() {
    return _storage.getString(KEYS.user);
  }

  void savePlayer(String player) {
    _storage.setString(KEYS.player, player);
  }

  getPlayer() {
    return _storage.getString(KEYS.player);
  }

  void saveCategories(String categories) {
    _storage.setString(KEYS.categories, categories);
  }

  getCategories() {
    return _storage.getString(KEYS.categories);
  }

  void saveSeasons(String seasons) {
    _storage.setString(KEYS.seasons, seasons);
  }

  getSeasons() {
    _storage.getString(KEYS.seasons);
  }

  void saveTennisLiveMatch(String match) {
    _storage.setString(KEYS.tennis_live, match);
  }

  getTennisLiveMatch() {
    return _storage.getString(KEYS.tennis_live);
  }

  void removeTennisLiveMatch() {
    _storage.remove(KEYS.tennis_live);
  }

  void markTutorialSeen() {
    _storage.setBool(KEYS.tutorial_seen, true);
  }

  bool? getTutorial() {
    return _storage.getBool(KEYS.tutorial_seen);
  }
}

Future<StorageHandler> createStorageHandler() async {
  SharedPreferences storage = await SharedPreferences.getInstance();

  return StorageHandler(storage: storage);
}
