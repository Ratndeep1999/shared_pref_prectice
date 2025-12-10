import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  /// single static instance
  static final SharedPrefService _instance = SharedPrefService.internal();

  /// private named constructor
  SharedPrefService.internal();

  /// factory constructor that return same instance
  factory SharedPrefService() => _instance;

  /// shared preference object
  static SharedPreferences? _pref;

  /// initialize object
  Future<void> initSharedPref() async {
    _pref = await SharedPreferences.getInstance();
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
    await _pref?.setString(kFullName, fullName);
    await _pref?.setString(kEmailId, emailId);
    await _pref?.setString(kUserName, userName);
    await _pref?.setString(kPassword, password);
    await _pref?.setString(kPhoneNo, phoneNo);
  }

  /// store boolean value into key
  Future<void> savePrefBool({required String key, required bool value}) async {
    await _pref?.setBool(key, value);
  }

  /// store string value into key
  Future<void> savePrefString(
      {required String key, required String value}) async {
    await _pref?.setString(key, value);
  }

  /// return bool value of specific key
  bool getPrefBool({required String key}) {
    return _pref?.getBool(key) ?? false;
  }

  /// return string value of specific key
  String getPrefString({required String key}){
    return _pref?.getString(key) ?? "";
  }
}
