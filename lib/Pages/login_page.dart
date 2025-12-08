import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Widgets/label_text_widget.dart';
import '../Widgets/filled_button_widget.dart';
import '../Widgets/text_form_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  /// Controllers
  late final TextEditingController emailOrUsernameController;
  late final TextEditingController passwordController;

  /// Parameters
  final String emailOrUsername = '';
  final String password = '';

  @override
  void initState() {
    emailOrUsernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Username or Email Section
              LabelTextWidget(label: 'Enter EmailId or Username'),
              /// email or username input field
              TextFormFieldWidget(
                controller: emailOrUsernameController,
              ),

              SizedBox(height: 100),

              SizedBox(height: 50),

              /// Button
              FilledButtonWidget(buttonLabel: "Loggin...", onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
