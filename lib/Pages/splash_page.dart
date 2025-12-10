import 'package:flutter/material.dart';
import '../Widgets/label_text_widget.dart';
import '../features/auth/data/local/auth_local_data_source.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SplashPage class (checks login state and navigates)
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final AuthLocalDataSource authLocalDataSource;

  @override
  void initState() {
    super.initState();
    _initDataSource();
    _moveToNextScreen();
  }

  /// Initialize the AuthLocalDataSource
  void _initDataSource() async {
    final prefs = await SharedPreferences.getInstance();
    authLocalDataSource = AuthLocalDataSource(sharedPreferences: prefs);
  }

  /// Navigate after 3 seconds
  void _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    // Check login state
    final isLoggedIn = await authLocalDataSource.isLoggedIn();

    // Navigate based on login state
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? const HomePage() : const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
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
