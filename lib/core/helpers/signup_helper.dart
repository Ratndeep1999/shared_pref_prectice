import 'package:flutter/material.dart';

class SignUpValidationResult {
  final bool isValid;

  const SignUpValidationResult({required this.isValid});
}

class SignUpHelper {
  static SignUpValidationResult validateAndSave({
    required GlobalKey<FormState> formKey,
    required String password,
    required String confirmPassword,
  }) {
    if (!formKey.currentState!.validate()) {
      return const SignUpValidationResult(isValid: false);
    }

    if (password != confirmPassword) {
      return const SignUpValidationResult(isValid: false);
    }

    formKey.currentState!.save();

    return const SignUpValidationResult(isValid: true);
  }
}
