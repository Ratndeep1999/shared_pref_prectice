import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberFieldWidget extends StatelessWidget {
  const PhoneNumberFieldWidget({
    super.key,
    this.onSaved,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final FormFieldSetter<PhoneNumber>? onSaved;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'Enter Your Phone Number',
        labelStyle: TextStyle(fontSize: 15),
      ),
      initialCountryCode: 'IN',
      focusNode: focusNode,
      onSaved: onSaved,
      controller: controller,
      onSubmitted: (_) => _onSubmitted(context),
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }
  /// Method to check next focus
  _onSubmitted(BuildContext context) {
    nextFocus != null
        ? FocusScope.of(context).requestFocus(nextFocus)
        : FocusScope.of(context).unfocus();
  }
}
