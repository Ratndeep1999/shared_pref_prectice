import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/core/constants/app_strings.dart';
import 'package:shared_pref_prectice/data/local/shared_pref_service.dart';
import '../Widgets/label_text_widget.dart';
import '../core/app/app_routes.dart';

/// SplashPage class (mutable/state data changeable)
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

/// State class
class _SplashPageState extends State<SplashPage> {
  /// shared pref object
  SharedPrefService prefService = SharedPrefService();

  @override
  void initState() {
    initSharedPref();
    _moveToNextScreen();
    super.initState();
  }

  /// initialize shared preference
  initSharedPref() async {
    await prefService.initSharedPref();
  }

  /// Navigate after 3 seconds
  void _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    /// get bool value
    final bool? isLoggedIn = prefService.getPrefBool(
      key: SharedPrefService.kIsLoggedIn,
    );
    Navigator.pushReplacementNamed(
      context,
      /// check where to navigate
      isLoggedIn == true ? AppRoutes.home : AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LabelTextWidget(
              label: AppStrings.splashTitle,
              fontSize: 30,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    ),
  );
}
