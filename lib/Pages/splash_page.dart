import 'package:flutter/material.dart';
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
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  /// Navigate after 3 seconds
  void _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    _navigateToLoginPage();
  }

  /// Navigate to LoginPage
  _navigateToLoginPage() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LabelTextWidget(
              label: "Splash Page...",
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
