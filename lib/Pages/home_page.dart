import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Pages/login_page.dart';
import 'package:shared_pref_prectice/Widgets/filled_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            /// Logout Button
            FilledButtonWidget(
              buttonLabel: "Logout",
              onPress: () => _navigateToLoginPage(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Method to Navigate LoginPage()
  _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
