import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _tokenKey = 'token';
  static const _expiryKey = 'token_expiry';
  static const String _firstTimeInstallKey = 'firstTimeInstall';

  static Future<void> saveToken(String token, DateTime expiryDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_expiryKey, expiryDate.toIso8601String());
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_expiryKey);
  }

  Future<bool> getFirstTimeInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool(_firstTimeInstallKey) ?? true;
    return isFirstTime;
  }

  Future<void> setFirstTimeInstall(bool isFirstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeInstallKey, isFirstTime);
  }

  static Future<DateTime?> getTokenExpiryDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? expiryString = prefs.getString(_expiryKey);
    if (expiryString == null) return null;
    return DateTime.parse(expiryString);
  }
}
