import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shared_pref_prectice/Widgets/filled_button_widget.dart';
import 'package:shared_pref_prectice/Widgets/text_form_field_widget.dart';
import 'package:shared_pref_prectice/core/utils/validators.dart';
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
                    validator: Validators.fullName,
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
                    validator: Validators.email,
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
                    validator: Validators.username,
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
                    validator: Validators.password,
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
                    validator: (value) => Validators.confirmPassword(value, _passwordController.text),
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

}
