import 'package:flutter/material.dart';
import '../Widgets/label_text_widget.dart';
import 'login_page.dart';

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

  /// Method that navigate to next page after 3 sec of delayed
  void _moveToNextScreen() {
    Future.delayed(Duration(seconds: 30), () => _navigateToLoginPage());
  }

  /// Method that navigate to LoginPage()
  _navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
