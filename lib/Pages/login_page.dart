import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Pages/sign_up_page.dart';
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
  final _formKey = GlobalKey<FormState>();

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
      appBar: AppBar(
        title: LabelTextWidget(label: "Login Page"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),

                    /// Username or Email Section
                    LabelTextWidget(
                      label: 'Enter EmailId or Username',
                      fontColor: Colors.purple,
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),

                    /// email or username input field
                    TextFormFieldWidget(
                      controller: emailOrUsernameController,
                      hintText: 'Enter Your Details',
                    ),

                    const SizedBox(height: 100),

                    /// Password Section
                    LabelTextWidget(
                      label: 'Enter Password',
                      fontColor: Colors.purple,
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),

                    /// password input field
                    TextFormFieldWidget(
                      controller: passwordController,
                      hintText: 'Enter Your Password',
                    ),

                    const SizedBox(height: 80),

                    /// Button
                    FilledButtonWidget(
                      buttonLabel: "Loggin...",
                      onPress: () {
                        print('Loggin Press');
                        _navigateToSignupPage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Method to Navigate Signup page
  void _navigateToSignupPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }
}
