import 'package:shared_preferences/shared_preferences.dart';

/// AuthLocalDataSource
///
/// Responsible for storing and retrieving authentication data locally.
///
/// Benefits:
/// - Keeps Controller clean
/// - Single Responsibility
/// - Testable
/// - Easily replaceable with SecureStorage or Hive
class AuthLocalDataSource {
  /// SharedPreferences instance
  final SharedPreferences sharedPreferences;

  /// Constructor with dependency injection
  AuthLocalDataSource({required this.sharedPreferences});

  /// Key for login flag
  static const String _keyIsLoggedIn = 'is_logged_in';

  /// Save login status as true
  Future<void> saveLogin() async {
    await sharedPreferences.setBool(_keyIsLoggedIn, true);
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    return sharedPreferences.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Logout user (clear login flag)
  Future<void> logout() async {
    await sharedPreferences.remove(_keyIsLoggedIn);
  }
}
