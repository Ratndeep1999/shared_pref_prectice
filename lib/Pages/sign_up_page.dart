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
import '../core/helpers/password_validator_helper.dart';
import '../core/helpers/signup_helper.dart';

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
  bool _isBothPassSame = false;
  bool isPasswordVisible = false;
  bool _isSigning = false;
  bool _isFormValid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fields = FormFields();
  }

  @override
  void dispose() {
    fields.dispose();
    super.dispose();
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
                  LabelTextWidget(label: AppStrings.email, fontSize: 15),
                  TextFormFieldWidget(
                    controller: fields.emailController,
                    hintText: AppStrings.yourEmail,
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
                    suffixTap: () => setState(() => isPasswordVisible = !isPasswordVisible),
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
                    suffixIcon: _isBothPassSame ? Icons.check_circle : Icons.cancel,
                    suffixIconColor: _isBothPassSame ? Color(0xFF93c743) : Color(0xFFFF4C4C),
                    onChanged: _onChangedConfPassword,
                    validator: (value) => Validators.confirmPassword(value, fields.passwordController.text,),
                  ),
                  const SizedBox(height: 20),

                  /// Mobile No. Section
                  LabelTextWidget(label: AppStrings.phone, fontSize: 15),
                  PhoneNumberFieldWidget(
                    controller: fields.phoneController,
                    focusNode: fields.phoneNode,
                    onSaved: (PhoneNumber? num) => _mobileNo = "${num!.countryCode} ${num.number}",
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

  Future<void> signupPress() async {
    FocusScope.of(context).unfocus();

    final result = SignUpHelper.validateAndSave(
      formKey: _formKey,
      password: fields.passwordController.text,
      confirmPassword: fields.confPasswordController.text,
    );

    if (!result.isValid) return;

    setState(() => _isSigning = true);
    await Future.delayed(const Duration(seconds: 3));
    _saveSignedUpUser();
    if (!mounted) return;
    Navigator.popUntil(context, (route) => route.isFirst);
    setState(() => _isSigning = false);
  }

  /// Save user details in shared pref
  _saveSignedUpUser() async {
    await prefService.saveSignedUpUser(fullName: _fullName, emailId: _email,
      userName: _userName, password: _password, phoneNo: _mobileNo,
    );
  }

  /// handles changes in the confirm-password field
  void _onChangedConfPassword(String confPassword) {
    final result = PasswordValidatorHelper.validate(
      password: fields.passwordController.text,
      confirmPassword: confPassword,
      formKey: _formKey,
    );

    setState(() {
      _isBothPassSame = result.isPasswordSame;
      _isFormValid = result.isFormValid;
    });
  }
}
