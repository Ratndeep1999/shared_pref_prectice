import 'package:flutter/material.dart';

class PasswordValidationResult {
  final bool isPasswordSame;
  final bool isFormValid;

  PasswordValidationResult({
    required this.isPasswordSame,
    required this.isFormValid,
  });
}

class PasswordValidatorHelper {
  static PasswordValidationResult validate({
    required String password,
    required String confirmPassword,
    required GlobalKey<FormState> formKey,
  }) {
    final bool isSame = password == confirmPassword;
    final bool isValid = formKey.currentState?.validate() ?? false;

    return PasswordValidationResult(
      isPasswordSame: isSame,
      isFormValid: isValid,
    );
  }
}
