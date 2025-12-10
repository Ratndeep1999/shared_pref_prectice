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


}