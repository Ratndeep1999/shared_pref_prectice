import 'package:flutter/material.dart';
import '../Widgets/filled_button_widget.dart';
import '../Widgets/label_text_widget.dart';
import '../Widgets/text_form_field_widget.dart';
import '../core/app/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/helpers/form_fields.dart';
import '../core/helpers/password_validator_helper.dart';
import '../core/utils/validators.dart';
import '../data/local/shared_pref_service.dart';

class GetPasswordPage extends StatefulWidget {
  const GetPasswordPage({super.key});

  @override
  State<GetPasswordPage> createState() => GetPasswordPageState();
}

class GetPasswordPageState extends State<GetPasswordPage> {
  SharedPrefService prefService = SharedPrefService();
  final _formKey = GlobalKey<FormState>();
  late final FormFields fields;
  late String _newPassword;
  String? _password;
  bool isPasswordVisible = false;
  bool _isBothPassSame = false;
  bool _isLoading = true;
  bool _isClicked = false;

  @override
  void initState() {
    super.initState();
    fields = FormFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LabelTextWidget(
          label: AppStrings.getPassword,
          fontColor: Colors.black,
        ),
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
                    const SizedBox(height: 30.0),

                    /// Get Password
                    _isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.purple,
                            color: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 50),
                          )
                        : LabelTextWidget(
                            label: _password ?? '00',
                            fontSize: 23,
                          ),

                    /// Navigate to login page
                    FilledButtonWidget(
                      buttonLabel: AppStrings.loginButton,
                      onPress: backToLogin,
                      isClicked: false,
                    ),
                    const SizedBox(height: 50.0),

                    /// Update Password
                    LabelTextWidget(
                      label: AppStrings.newPassword,
                      fontSize: 15,
                    ),
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
                      suffixTap: () => setState(
                        () => isPasswordVisible = !isPasswordVisible,
                      ),
                      validator: Validators.password,
                      onSaved: (password) => _newPassword = password!.trim(),
                    ),
                    const SizedBox(height: 20),

                    /// Conform Password Section
                    LabelTextWidget(
                      label: AppStrings.conformNewPassword,
                      fontSize: 15,
                    ),
                    TextFormFieldWidget(
                      controller: fields.confPasswordController,
                      hintText: AppStrings.passwordAgain,
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: fields.confPasswordNode,
                      nextFocus: fields.phoneNode,
                      isSuffixIcon: true,
                      suffixIcon: _isBothPassSame
                          ? Icons.check_circle
                          : Icons.cancel,
                      suffixIconColor: _isBothPassSame
                          ? Color(0xFF93c743)
                          : Color(0xFFFF4C4C),
                      onChanged: _onChangedConfPassword,
                      validator: (value) => Validators.confirmPassword(
                        value,
                        fields.passwordController.text,
                      ),
                    ),
                    const SizedBox(height: 50),

                    /// Update New Password
                    FilledButtonWidget(
                      buttonLabel: AppStrings.updatePassword,
                      onPress: updatePassword,
                      isClicked: _isClicked,
                    ),
                    const SizedBox(height: 50.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Get Old Password
  getOldPassword() async {
    _password = await prefService.getPrefString(
      key: SharedPrefService.kPassword,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);
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
    });
  }

  /// Navigate back to login
  void backToLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  /// Update Password
  Future<void> updatePassword() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isClicked = true);
    Future.delayed(const Duration(seconds: 2), () async {
      await prefService.setPrefString(
        key: SharedPrefService.kPassword,
        value: _newPassword,
      );
      backToLogin();
      setState(() => _isClicked = false);
    });
  }
}
