import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  /// single static instance
  static final SharedPrefService _instance = SharedPrefService.internal();

  /// private named constructor
  SharedPrefService.internal();

  /// factory constructor that return same instance
  factory SharedPrefService() => _instance;

  /// shared preference object
  static SharedPreferences? _prefs;

  /// initialize object
  Future<SharedPreferences> get _instancePrefs async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  /// constants keys
  static const String kFullName = "fullName";
  static const String kEmailId = "emailId";
  static const String kUserName = "userName";
  static const String kPassword = "password";
  static const String kPhoneNo = "phoneNo";
  static const String kIsLoggedIn = "isLoggedIn";

  /// Save User Details
  Future<void> saveUserInfo({
    required String fullName,
    required String emailId,
    required String userName,
    required String password,
    required String phoneNo,
  }) async {
    final prefs = await _instancePrefs;
    await prefs.setString(kFullName, fullName);
    await prefs.setString(kEmailId, emailId);
    await prefs.setString(kUserName, userName);
    await prefs.setString(kPassword, password);
    await prefs.setString(kPhoneNo, phoneNo);
  }

  /// store boolean value into key
  Future<void> savePrefBool({required String key, required bool value}) async {
    final prefs = await _instancePrefs;
    await prefs.setBool(key, value);
  }

  /// store string value into key
  Future<void> savePrefString({
    required String key,
    required String value,
  }) async {
    final prefs = await _instancePrefs;
    await prefs.setString(key, value);
  }

  /// return bool value of specific key
  Future<bool> getPrefBool({required String key}) async {
    final prefs = await _instancePrefs;
    return prefs.getBool(key) ?? false;
  }

  /// return string value of specific key
  Future<String> getPrefString({required String key}) async {
    final prefs = await _instancePrefs;
    return prefs.getString(key) ?? "";
  }

  /// delete the key
  Future<void> removeKey({required String key}) async {
    final prefs = await _instancePrefs;
    prefs.remove(key);
  }

  /// clear all data from shared preferences
  Future<void> clearAll() async {
    final prefs = await _instancePrefs;
    await prefs.clear();
  }
}
