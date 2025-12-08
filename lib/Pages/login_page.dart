import 'package:flutter/material.dart';
import '../Widgets/filled_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          /// Button
          FilledButtonWidget(
            buttonLabel: "Loggin...",
            onPress: () {},
          )
        ],
      ),
    );
  }
}
