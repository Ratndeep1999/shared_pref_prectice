import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberFieldWidget extends StatelessWidget {
  const PhoneNumberFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'Enter Your Phone Number',
      ),
      initialCountryCode: 'IN',
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }
}