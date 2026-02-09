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

class _SplashPageState extends State<SplashPage> {
  SharedPrefService prefService = SharedPrefService();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  /// Navigate after 3 seconds
  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () async {
      final isLoggedIn = await prefService.getPrefBool(
        key: SharedPrefService.kIsLoggedIn,
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        isLoggedIn ? AppRoutes.home : AppRoutes.login,
      );
    });
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
