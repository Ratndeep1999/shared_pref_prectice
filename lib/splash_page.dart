import 'package:flutter/material.dart';
import 'Widgets/label_text_widget.dart';

/// SplashPage class (mutable/state data changeable)
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

/// State class
class _SplashPageState extends State<SplashPage> {
  /// initState()
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  /// Method that navigate to next page after 3 sec of delayed
  void _moveToNextScreen() {
    Future.delayed(Duration(seconds: 3), () => _navigateToLoginPage());
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
        children: [Center(child: LabelTextWidget(label: "Splash Page"))],
      ),
    ),
  );
}
