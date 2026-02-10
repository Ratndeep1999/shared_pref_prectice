import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/core/app/app_routes.dart';
import 'package:shared_pref_prectice/data/local/shared_pref_service.dart';
import '../Widgets/filled_button_widget.dart';
import '../Widgets/label_text_widget.dart';
import '../Widgets/text_form_field_widget.dart';
import '../core/constants/app_strings.dart';
import '../core/helpers/form_fields.dart';
import '../core/utils/validators.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => ForgetPasswordPageState();
}

class ForgetPasswordPageState extends State<ForgetPasswordPage> {
  SharedPrefService prefService = SharedPrefService();
  final _formKey = GlobalKey<FormState>();
  late final FormFields fields;
  late String _emailOrUsername;
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
          label: AppStrings.forgetPassword,
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
              child: Column(
                children: [
                  const SizedBox(height: 50.0),

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
                  const SizedBox(height: 50.0),

                  /// Check is Data Exist
                  FilledButtonWidget(
                    buttonLabel: AppStrings.check,
                    onPress: checkDetails,
                    isClicked: _isClicked,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Check is data match with saved data
  checkDetails() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isClicked = true);

    final savedEmail = await prefService.getPrefString(
      key: SharedPrefService.kEmailId,
    );

    final savedUsername = await prefService.getPrefString(
      key: SharedPrefService.kUserName,
    );

    final _isValid =
        (savedEmail == _emailOrUsername || savedUsername == _emailOrUsername);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isClicked = false);
      if (_isValid) {
        Navigator.pushNamed(context, AppRoutes.checkNumber);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.purple,
            content: LabelTextWidget(
              label: AppStrings.checkDetails,
              fontColor: Colors.black,
            ),
          ),
        );
      }
    });
  }
}
