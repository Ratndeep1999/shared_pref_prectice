import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Widgets/label_text_widget.dart';
import 'package:shared_pref_prectice/core/constants/app_strings.dart';
import 'package:shared_pref_prectice/data/local/shared_pref_service.dart';
import '../Widgets/filled_button_widget.dart';
import '../Widgets/text_form_field_widget.dart';
import '../core/app/app_routes.dart';
import '../core/helpers/form_fields.dart';
import '../core/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  SharedPrefService prefService = SharedPrefService();

  /// Parameters
  late final FormFields fields;
  late String _emailOrUsername;
  late String _password;
  bool isPasswordVisible = false;
  bool _isLoggin = false;
  bool _isFormValid = false;
  final _formKey = GlobalKey<FormState>();

  late Size _screenSize;
  late EdgeInsets _padding;
  late ThemeData _theme;

  @override
  void initState() {
    super.initState();
    fields = FormFields();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    _screenSize = mediaQuery.size;
    _padding = mediaQuery.padding;
    _theme = Theme.of(context);
  }

  @override
  void dispose() {
    fields.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LabelTextWidget(
          label: AppStrings.loginTitle,
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
                    const SizedBox(height: 100),

                    /// Username or Email Section
                    LabelTextWidget(
                      label: AppStrings.emailOrUsername,
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),

                    /// email or username input field
                    TextFormFieldWidget(
                      controller: fields.emailController,
                      hintText: AppStrings.yourDetails,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: fields.emailNode,
                      nextFocus: fields.passwordNode,
                      autoFocus: true,
                      validator: Validators.emailOrUsername,
                      onSaved: (emailOrUsername) => _emailOrUsername =
                          emailOrUsername!.trim().toLowerCase(),
                    ),
                    const SizedBox(height: 100),

                    /// Password Section
                    LabelTextWidget(
                      label: AppStrings.password,
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),

                    /// password input field
                    TextFormFieldWidget(
                      controller: fields.passwordController,
                      hintText: AppStrings.yourPassword,
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: fields.passwordNode,
                      validator: Validators.password,
                      onSaved: (password) => _password = password!.trim(),
                      onChanged: (_) => checkFormValidity(),
                      obscureText: !isPasswordVisible,
                      isSuffixIcon: true,
                      suffixIcon: isPasswordVisible
                          ? Icons.lock_open
                          : Icons.lock,
                      suffixTap: () => setState(
                        () => isPasswordVisible = !isPasswordVisible,
                      ),
                    ),
                    const SizedBox(height: 80),

                    /// Login Button
                    FilledButtonWidget(
                      buttonLabel: AppStrings.loginButton,
                      buttonColor: _isFormValid ? null : Colors.purple.shade200,
                      isClicked: _isLoggin,
                      onPress: _isFormValid ? loginPress : () {},
                    ),
                    const SizedBox(height: 30),

                    /// Signup Text Button
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.signup),
                      child: LabelTextWidget(label: AppStrings.createAccount),
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
    setState(() => _isLoggin = true);
    _checkUserValidation();
  }

  /// Method to check Form Validation
  void checkFormValidity() {
    /// If validate then return true other wise false
    final isValid = _formKey.currentState?.validate() ?? false;

    /// trigger when isValid = true
    if (isValid == _isFormValid) return;
    setState(() => _isFormValid = isValid);
  }

  /// Method to check used validation
  Future<void> _checkUserValidation() async {
    final savedEmail = await prefService.getPrefString(
      key: SharedPrefService.kEmailId,
    );
    final savedUsername = await prefService.getPrefString(
      key: SharedPrefService.kUserName,
    );
    final savedPassword = await prefService.getPrefString(
      key: SharedPrefService.kPassword,
    );

    final bool isValidUser =
        (_emailOrUsername == savedEmail || _emailOrUsername == savedUsername) &&
        _password == savedPassword;

    if (!mounted) return;
    setState(() => _isLoggin = false);
    Future.delayed(const Duration(seconds: 2), () {
      if (isValidUser) {
        prefService.setPrefBool(
          key: SharedPrefService.kIsLoggedIn,
          value: true,
        );
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
      }
    });
  }
}
