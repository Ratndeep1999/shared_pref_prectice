import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shared_pref_prectice/Widgets/filled_button_widget.dart';
import 'package:shared_pref_prectice/Widgets/text_form_field_widget.dart';
import 'package:shared_pref_prectice/core/constants/app_strings.dart';
import 'package:shared_pref_prectice/core/utils/validators.dart';
import 'package:shared_pref_prectice/data/local/shared_pref_service.dart';
import '../Widgets/label_text_widget.dart';
import '../Widgets/phone_number_field-widget..dart';
import '../core/helpers/form_fields.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  SharedPrefService prefService = SharedPrefService();

  /// Parameters
  late final FormFields fields;
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
    initSharedPref();
    fields = FormFields();
    super.initState();
  }

  @override
  void dispose() {
    fields.dispose();
    super.dispose();
  }

  /// initialize shared pref
  Future<void> initSharedPref() async {
    await prefService.initSharedPref();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: LabelTextWidget(
        label: AppStrings.signupTitle,
        fontColor: Colors.black,
      ),
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
                  LabelTextWidget(label: AppStrings.fullName, fontSize: 15),
                  TextFormFieldWidget(
                    controller: fields.fullNameController,
                    hintText: AppStrings.yourFullName,
                    keyboardType: TextInputType.name,
                    focusNode: fields.fullNameNode,
                    nextFocus: fields.emailNode,
                    autoFocus: true,
                    validator: Validators.fullName,
                    onSaved: (fName) => _fullName = fName!.trim().toLowerCase(),
                  ),
                  const SizedBox(height: 20),

                  /// Email Section
                  LabelTextWidget(label: "Enter Email Address", fontSize: 15),
                  TextFormFieldWidget(
                    controller: fields.emailController,
                    hintText: "Enter Your Email Address",
                    keyboardType: TextInputType.emailAddress,
                    focusNode: fields.emailNode,
                    nextFocus: fields.usernameNode,
                    validator: Validators.email,
                    onSaved: (email) => _email = email!.trim().toLowerCase(),
                  ),
                  const SizedBox(height: 20),

                  /// User name Section
                  LabelTextWidget(label: AppStrings.username, fontSize: 15),
                  TextFormFieldWidget(
                    controller: fields.usernameController,
                    hintText: AppStrings.yourUsername,
                    keyboardType: TextInputType.name,
                    focusNode: fields.usernameNode,
                    nextFocus: fields.passwordNode,
                    validator: Validators.username,
                    onSaved: (uName) => _userName = uName!.trim().toLowerCase(),
                  ),
                  const SizedBox(height: 20),

                  /// Password Section
                  LabelTextWidget(label: AppStrings.password, fontSize: 15),
                  TextFormFieldWidget(
                    controller: fields.passwordController,
                    hintText: AppStrings.yourPassword,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: fields.passwordNode,
                    nextFocus: fields.confPasswordNode,
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
                    label: AppStrings.confirmPassword,
                    fontSize: 15,
                  ),
                  TextFormFieldWidget(
                    controller: fields.confPasswordController,
                    hintText: AppStrings.passwordAgain,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: fields.confPasswordNode,
                    nextFocus: fields.phoneNode,
                    isSuffixIcon: true,
                    suffixIcon: _isPassConfPassSame
                        ? Icons.check_circle
                        : Icons.cancel,
                    suffixIconColor: _isPassConfPassSame
                        ? Color(0xFF93c743)
                        : Color(0xFFFF4C4C),
                    onChanged: _onChangedConfPassword,
                    validator: (value) => Validators.confirmPassword(
                      value,
                      fields.passwordController.text,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Mobile No. Section
                  LabelTextWidget(label: AppStrings.phone, fontSize: 15),
                  PhoneNumberFieldWidget(
                    controller: fields.phoneController,
                    focusNode: fields.phoneNode,
                    onSaved: (PhoneNumber? num) =>
                        _mobileNo = "${num!.countryCode} ${num.number}",
                  ),
                  const SizedBox(height: 20),

                  /// Signup Button
                  Center(
                    child: FilledButtonWidget(
                      buttonLabel: AppStrings.createButton,
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
    if (fields.passwordController.text != fields.confPasswordController.text)
      return;
    _formKey.currentState!.save();
    _saveUserInfoInSharedPref();
    await showProgressIndicator();
    Navigator.pop(context);
  }

  /// Save user details in shared pref
  _saveUserInfoInSharedPref() {
    prefService.saveUserInfo(
      fullName: _fullName,
      emailId: _email,
      userName: _userName,
      password: _password,
      phoneNo: _mobileNo,
    );
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
      _isPassConfPassSame = (fields.passwordController.text == confPassword)
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
