import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userEmailKey = 'user_email';
  static const String _userPasswordKey = 'user_password';

  // Save the access token to SharedPreferences
  static Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
  }

  // Save the refresh token to SharedPreferences
  static Future<void> saveRefreshToken(String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  // Save the user's email to SharedPreferences
  static Future<void> saveUserEmail(String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, userEmail);
  }

  // Save the user's password to SharedPreferences
  static Future<void> saveUserPassword(String userPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userPasswordKey, userPassword);
  }

  // Retrieve the access token from SharedPreferences
  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Retrieve the refresh token from SharedPreferences
  static Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Retrieve the user's email from SharedPreferences
  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // Retrieve the user's password from SharedPreferences
  static Future<String?> getUserPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPasswordKey);
  }

  // Clear the access token from SharedPreferences
  static Future<void> clearAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
  }

  // Clear the refresh token from SharedPreferences
  static Future<void> clearRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_refreshTokenKey);
  }

  // Clear the user's email from SharedPreferences
  static Future<void> clearUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userEmailKey);
  }

  // Clear the user's password from SharedPreferences
  static Future<void> clearUserPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userPasswordKey);
  }
}
