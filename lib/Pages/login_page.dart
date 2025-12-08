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
  late final TextEditingController _emailOrUsernameController;
  late final TextEditingController _passwordController;

  /// Nodes
  late final FocusNode _emailOrUsernameNode;
  late final FocusNode _passwordNode;

  /// Parameters
  final String _emailOrUsername = '';
  final String _password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailOrUsernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailOrUsernameNode = FocusNode();
    _passwordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailOrUsernameController.dispose();
    _passwordController.dispose();
    _emailOrUsernameNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LabelTextWidget(label: "Login Page", fontColor: Colors.black),
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
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),

                    /// email or username input field
                    TextFormFieldWidget(
                      controller: _emailOrUsernameController,
                      hintText: 'Enter Your Details',
                    ),

                    const SizedBox(height: 100),

                    /// Password Section
                    LabelTextWidget(
                      label: 'Enter Password',
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),

                    /// password input field
                    TextFormFieldWidget(
                      controller: _passwordController,
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
