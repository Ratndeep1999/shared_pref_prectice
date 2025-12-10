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



}