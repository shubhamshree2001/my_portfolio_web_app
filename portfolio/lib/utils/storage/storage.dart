import 'package:get_storage/get_storage.dart';

class Storage {
  // Storage._privateConstructor();

  final _box = GetStorage();

  Future<void> setTheme(bool darkTheme) async {
    await _box.write(StorageKeys.DARK_THEME, darkTheme);
  }

  Future<bool> getTheme() async =>
      await _box.read(StorageKeys.DARK_THEME) ?? false;

  Future<void> setHasSeenOnboarding(bool val) async {
    await _box.write(StorageKeys.hasSeenOnboarding, val);
  }

  Future<bool> getHasSeenOnboarding() async {
    var val = await _box.read(StorageKeys.hasSeenOnboarding);
    return val ?? false;
  }

  Future<void> setLastLoggedSymptom(String val) async {
    await _box.write(StorageKeys.logSymptom, val.toString());
  }

  Future<String> getLastLoggedSymptom() async {
    var val = await _box.read(StorageKeys.logSymptom);
    return val ?? '';
  }

  Future<void> setIsLogin(bool isLogin) async {
    await _box.write(StorageKeys.isLoginUser, isLogin);
  }

  Future<bool> getIsLogin() async {
    var isLogin = await _box.read(StorageKeys.isLoginUser) ?? false;
    return isLogin != null && isLogin;
  }

  Future<void> setIsGuestLogin(bool isLogin) async {
    await _box.write(StorageKeys.isGuestUser, isLogin);
  }

  Future<bool> getIsGuestLogin() async {
    var isGuestLogin = await _box.read(StorageKeys.isGuestUser) ?? false;
    return isGuestLogin != null && isGuestLogin;
  }

  Future<void> setAccessToken(String accessToken) async {
    await _box.write(StorageKeys.accessToken, accessToken);
  }

  Future<String> getAccessToken() async {
    var accessToken = await _box.read(StorageKeys.accessToken);
    return accessToken ?? "";
  }

  Future<void> setRefreshToken(String refreshToken) async {
    await _box.write(StorageKeys.refreshToken, refreshToken);
  }

  Future<String> getRefreshToken() async {
    var refreshToken = await _box.read(StorageKeys.refreshToken);
    return refreshToken ?? "";
  }

// static void setUser(User user) =>
//     _box.write(StorageKeys.USER_DETAILS, user.toJson());

// static User? getUser() {
//   final json = _box.read(StorageKeys.USER_DETAILS);
//   if (json != null) {
//     return User.fromJson(json);
//   } else {
//     return null;
//   }
// }
}

class StorageKeys {
  static const DARK_THEME = 'dark_theme';
  static const USER_DETAILS = 'user_details';
  static const hasSeenOnboarding = 'hasSeenOnboarding';
  static const logSymptom = 'logSymptom';
  static const isLoginUser = "isLogin";
  static const isGuestUser = "isGuestLogin";
  static const accessToken = "accessToken";
  static const refreshToken = "refreshToken";
}
