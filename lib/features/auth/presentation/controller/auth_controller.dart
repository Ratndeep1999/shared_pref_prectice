import 'package:flutter/material.dart';

/// AuthController
///
/// Responsibility:
/// - Handle login & signup actions
/// - Trigger form validation
/// - Keep UI free from logic
///
/// This controller belongs to the PRESENTATION layer.
/// It does NOT contain UI widgets.
class AuthController {
  /// Global form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Handles login button click
  ///
  /// Steps:
  /// 1. Validate form
  /// 2. Save form state
  /// 3. Proceed with login logic
  /// 4. Navigate to Home page
  void login(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    /// Later:
    /// - Call AuthRepository
    /// - Store token / user data
    /// - API call

    Navigator.pushReplacementNamed(context, '/home');
  }

  /// Handles signup button click
  ///
  /// Steps:
  /// 1. Validate form
  /// 2. Save form state
  /// 3. Proceed with signup logic
  /// 4. Navigate to Login page
  void signup(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    /// Later:
    /// - Call Signup use case
    /// - Save user data
    /// - API call

    Navigator.pop(context);
  }
}
