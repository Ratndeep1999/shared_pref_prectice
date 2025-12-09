import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Pages/home_page.dart';
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
  late String _emailOrUsername;
  late String _password;
  bool isPasswordVisible = false;
  bool _isLoggin = false;
  bool _isFormValid = false;
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
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailOrUsernameNode,
                      nextFocus: _passwordNode,
                      autoFocus: true,
                      validator: _emailOrUsernameValidation,
                      onSaved: _saveEmailOrUsername,
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
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: _passwordNode,
                      validator: _passwordValidation,
                      onSaved: _savePassword,
                      onChanged: (_) => checkFormValidity(),
                      obscureText: !isPasswordVisible,
                      isSuffixIcon: true,
                      suffixIcon: isPasswordVisible
                          ? Icons.lock_open
                          : Icons.lock,
                      suffixTap: suffixTap,
                    ),

                    const SizedBox(height: 80),

                    /// Login Button
                    FilledButtonWidget(
                      buttonLabel: "Loggin...",
                      buttonColor: _isFormValid ? null : Colors.purple.shade200,
                      isClicked: _isLoggin,
                      onPress: _isFormValid ? loginPress : () {},
                    ),

                    const SizedBox(height: 30),

                    /// Signup Text Button
                    InkWell(
                      onTap: ()=>_navigateToSignupPage(),
                      child: LabelTextWidget(
                        label: "Don't Have Account? Create Account",
                      ),
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

  /// Method to Check Login Credentials
  void loginPress() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    debugPrint("Email/Username: $_emailOrUsername");
    debugPrint("Password: $_password");
    await showProgressIndicator();
    _navigateToHomePage();
  }

  /// Method to show Progress Indicator
  showProgressIndicator() async {
    setState(() {
      _isLoggin = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isLoggin = false;
    });
  }

  /// Method to check Form Validation
  void checkFormValidity() {
    /// If validate then return true other wise false
    final isValid = _formKey.currentState?.validate() ?? false;

    /// trigger when isValid = true
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  /// Method to Navigate Signup page
  void _navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  /// Method to Validate Email or Username
  String? _emailOrUsernameValidation(String? value) {
    String? emailOrUsername = value?.trim().toLowerCase();
    if (emailOrUsername == null || emailOrUsername.isEmpty) {
      return 'Please enter your email or username';
    }
    if (emailOrUsername.length < 4) {
      return 'Minimum 4 char is must';
    }
    // if (_takenUsernames.contains(userName)) {
    //   return 'Username is already taken';
    // }
    return null;
  }

  /// Method to Validate Password
  String? _passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter your password";
    }
    if (password.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (password.contains(' ')) {
      return "Space is not allowed";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must contain at least one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must contain at least one lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "Password must contain at least one number";
    }
    if (!RegExp(r'[!@\$&*~_]').hasMatch(password)) {
      return "Password must contain at least one special character (!@#\$&*~_)";
    }
    return null;
  }

  /// Method to save email or password
  void _saveEmailOrUsername(String? emailOrUsername) {
    _emailOrUsername = emailOrUsername!.trim().toLowerCase();
  }

  /// Method to save Password
  void _savePassword(String? password) {
    _password = password!.trim();
  }

  /// Method to make Suffix Icon dynamic
  void suffixTap() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  /// Method to Navigate Signup Page
  void _navigateToSignupPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }
}
