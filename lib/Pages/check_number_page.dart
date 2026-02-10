import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shared_pref_prectice/core/app/app_routes.dart';
import 'package:shared_pref_prectice/data/local/shared_pref_service.dart';
import '../Widgets/filled_button_widget.dart';
import '../Widgets/label_text_widget.dart';
import '../Widgets/phone_number_field-widget..dart';
import '../core/constants/app_strings.dart';
import '../core/helpers/form_fields.dart';

class CheckNumberPage extends StatefulWidget {
  const CheckNumberPage({super.key});

  @override
  State<CheckNumberPage> createState() => CheckNumberPageState();
}

class CheckNumberPageState extends State<CheckNumberPage> {
  SharedPrefService prefService = SharedPrefService();
  final _formKey = GlobalKey<FormState>();
  late final FormFields fields;
  late String _mobileNo;
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
          label: AppStrings.checkNumber,
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

                  /// Mobile No. Section
                  LabelTextWidget(label: AppStrings.phone, fontSize: 23),
                  PhoneNumberFieldWidget(
                    controller: fields.phoneController,
                    focusNode: fields.phoneNode,
                    onSaved: (PhoneNumber? num) =>
                        _mobileNo = "${num!.countryCode} ${num.number}",
                  ),
                  const SizedBox(height: 50.0),

                  /// Check is Number Match
                  FilledButtonWidget(
                    buttonLabel: AppStrings.check,
                    onPress: checkNumber,
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

  /// Validate user mobile number
  Future<void> checkNumber() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isClicked = true);

    final savedNumber = await prefService.getPrefString(
      key: SharedPrefService.kPhoneNo,
    );

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isClicked = false);
      if (savedNumber == _mobileNo) {
        Navigator.pushNamed(context, AppRoutes.getPassword);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.purple,
            content: LabelTextWidget(
              label: AppStrings.numberNotMatched,
              fontColor: Colors.black,
            ),
          ),
        );
      }
    });
  }
}
