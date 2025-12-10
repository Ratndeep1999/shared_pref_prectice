import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shared_pref_prectice/Widgets/filled_button_widget.dart';
import 'package:shared_pref_prectice/Widgets/text_form_field_widget.dart';
import '../Widgets/label_text_widget.dart';
import '../Widgets/phone_number_field-widget..dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  /// Controllers
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confPasswordController;
  late final TextEditingController _mobileNoController;

  /// Focus Nodes
  late final FocusNode _fullNameNode;
  late final FocusNode _emailNode;
  late final FocusNode _usernameNode;
  late final FocusNode _passwordNode;
  late final FocusNode _confPasswordNode;
  late final FocusNode _mobileNoNode;

  /// Parameters
  late String _fullName;
  late String _email;
  late String _userName;
  late String _password;
  late String _mobileNo;
  bool _isPassConfPassSame = false;
  bool isPasswordVisible = false;
  bool _isSigning = false;
  bool _isFormValid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
    _mobileNoController = TextEditingController();
    _fullNameNode = FocusNode();
    _emailNode = FocusNode();
    _usernameNode = FocusNode();
    _passwordNode = FocusNode();
    _confPasswordNode = FocusNode();
    _mobileNoNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    _mobileNoController.dispose();
    _fullNameNode.dispose();
    _emailNode.dispose();
    _usernameNode.dispose();
    _passwordNode.dispose();
    _confPasswordNode.dispose();
    _mobileNoNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: LabelTextWidget(label: "SignUp Page", fontColor: Colors.black),
      centerTitle: true,
      backgroundColor: Colors.purple,
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: AutofillGroup(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Full Name Section
                  LabelTextWidget(label: "Enter Full Name", fontSize: 15),
                  TextFormFieldWidget(
                    controller: _fullNameController,
                    hintText: "Enter Your Full Name",
                    keyboardType: TextInputType.name,
                    focusNode: _fullNameNode,
                    nextFocus: _emailNode,
                    autoFocus: true,
                    validator: _fullNameValidation,
                    onSaved: (fName) => _fullName = fName!.trim().toLowerCase(),
                  ),
                  const SizedBox(height: 20),

                  /// Email Section
                  LabelTextWidget(label: "Enter Email Address", fontSize: 15),
                  TextFormFieldWidget(
                    controller: _emailController,
                    hintText: "Enter Your Email Address",
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailNode,
                    nextFocus: _usernameNode,
                    validator: _emailValidation,
                    onSaved: (email) => _email = email!.trim().toLowerCase(),
                  ),
                  const SizedBox(height: 20),

                  /// User name Section
                  LabelTextWidget(label: "Enter User Name", fontSize: 15),
                  TextFormFieldWidget(
                    controller: _userNameController,
                    hintText: "Enter Your User Name",
                    keyboardType: TextInputType.name,
                    focusNode: _usernameNode,
                    nextFocus: _passwordNode,
                    validator: _userNameValidation,
                    onSaved: (uName) => _userName = uName!.trim().toLowerCase(),
                  ),
                  const SizedBox(height: 20),

                  /// Password Section
                  LabelTextWidget(label: "Enter Password", fontSize: 15),
                  TextFormFieldWidget(
                    controller: _passwordController,
                    hintText: "Enter Your Password",
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordNode,
                    nextFocus: _confPasswordNode,
                    obscureText: !isPasswordVisible,
                    isSuffixIcon: true,
                    suffixIcon: isPasswordVisible
                        ? Icons.lock_open
                        : Icons.lock,
                    suffixTap: suffixTap,
                    validator: _passwordValidation,
                    onSaved: (password) => _password = password!.trim(),
                  ),
                  const SizedBox(height: 20),

                  /// Conform Password Section
                  LabelTextWidget(
                    label: "Enter Conform Password",
                    fontSize: 15,
                  ),
                  TextFormFieldWidget(
                    controller: _confPasswordController,
                    hintText: "Enter Your Conform Password",
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _confPasswordNode,
                    nextFocus: _mobileNoNode,
                    isSuffixIcon: true,
                    suffixIcon: _isPassConfPassSame
                        ? Icons.check_circle
                        : Icons.cancel,
                    suffixIconColor: _isPassConfPassSame
                        ? Color(0xFF93c743)
                        : Color(0xFFFF4C4C),
                    onChanged: _onChangedConfPassword,
                    validator: _confPasswordValidation,
                  ),
                  const SizedBox(height: 20),

                  /// Mobile No. Section
                  LabelTextWidget(label: "Enter Phone Number", fontSize: 15),
                  PhoneNumberFieldWidget(
                    controller: _mobileNoController,
                    focusNode: _mobileNoNode,
                    onSaved: (PhoneNumber? num) => _mobileNo = "${num!.countryCode} ${num.number}",
                  ),
                  const SizedBox(height: 20),

                  /// Signup Button
                  Center(
                    child: FilledButtonWidget(
                      buttonLabel: "Create Account",
                      isClicked: _isSigning,
                      onPress: _isFormValid ? signupPress : () {},
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

  /// Method to Check User Details
  void signupPress() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    // Check password and confPassword
    if (_passwordController.text != _confPasswordController.text) return;

    _formKey.currentState!.save();
    debugPrint(_fullName);
    debugPrint(_email);
    debugPrint(_userName);
    debugPrint(_password);
    debugPrint(_mobileNo);
    await showProgressIndicator();
    Navigator.pop(context);
  }

  /// Method to show Progress Indicator
  showProgressIndicator() async {
    setState(() {
      _isSigning = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isSigning = false;
    });
  }

  /// Method to make Suffix Icon dynamic
  void suffixTap() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  /// Check Password and Conf-Password same or Not and Validate Form
  void _onChangedConfPassword(String confPassword) {
    setState(() {
      _isPassConfPassSame = (_passwordController.text == confPassword)
          ? true
          : false;
    });

    /// If validate then return true other wise false
    final isValid = _formKey.currentState?.validate() ?? false;

    /// trigger when isValid = true
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  /// Full Name Validation
  String? _fullNameValidation(String? value) {
    final fullName = value?.trim();

    if (fullName == null || fullName.isEmpty) {
      return "Please enter full name";
    }

    if (fullName.length < 4) {
      return "Name is too short";
    }

    // Must contain at least first & last name
    if (!fullName.contains(' ')) {
      return "Please enter first and last name";
    }

    // Allowed characters only
    if (!RegExp(r"^[a-zA-Z]+([ .-][a-zA-Z]+)*$").hasMatch(fullName)) {
      return "Only letters, space, dot and hyphen are allowed";
    }

    return null;
  }

  /// Username Validation (Production Ready)
  String? _userNameValidation(String? value) {
    final userName = value?.trim().toLowerCase();
    if (userName == null || userName.isEmpty) {
      return "Please enter username";
    }
    if (userName.length < 4 || userName.length > 20) {
      return "Username must be 4–20 characters";
    }
    // Must start with a letter
    if (!RegExp(r'^[a-zA-Z]').hasMatch(userName)) {
      return "Username must start with a letter";
    }
    // Allowed characters only
    if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(userName)) {
      return "Only letters, numbers, dot (.) and underscore (_) allowed";
    }
    // No consecutive dots or underscores
    if (RegExp(r'[._]{2,}').hasMatch(userName)) {
      return "No consecutive dots or underscores allowed";
    }
    // Cannot end with dot or underscore
    if (RegExp(r'[._]$').hasMatch(userName)) {
      return "Username cannot end with dot or underscore";
    }
    return null;
  }

  /// Email Validation
  String? _emailValidation(String? value) {
    String? email = value?.trim().toLowerCase();
    if (email == null || email.isEmpty) return 'Please Enter Email Address';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email))
      return "Email address must contain '@' and '.com'";
    return null;
  }

  /// Password Validation
  String? _passwordValidation(String? value) {
    String? password = value?.trim();
    if (password == null || password.isEmpty) return 'Please Enter Password';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (password.contains(' ')) return 'Space is Not Allowed';
    if (!RegExp(r'[A-Z]').hasMatch(password))
      return "Must contain uppercase letter";
    if (!RegExp(r'[a-z]').hasMatch(password))
      return "Must contain lowercase letter";
    if (!RegExp(r'[0-9]').hasMatch(password)) return "Must contain a number";
    if (!RegExp(r'[!@\$&*~_]').hasMatch(password))
      return "Must contain one special character (!@#\$&*~_)";
    return null;
  }

  /// Conform Password Validation
  String? _confPasswordValidation(String? confPassword) {
    if (confPassword == null || confPassword.isEmpty)
      return 'Please Enter Conform Password';
    if (_isPassConfPassSame == false)
      return 'Password And Conform Password is Not Same';
    return null;
  }
}
