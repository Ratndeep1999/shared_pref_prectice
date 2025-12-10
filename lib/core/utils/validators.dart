import 'package:shared_pref_prectice/core/utils/app_regex.dart';

/// Centralized validation utilities.
///
/// This class contains reusable, production-ready
/// validation rules used across authentication forms.
///
/// Benefits:
/// - Prevents duplication
/// - Keeps UI clean
/// - Easy to test and maintain
/// - Consistent validation across app
///
class Validators {
  Validators._();
  /// Login

  /// Validates email or username input.
  ///
  /// Rules:
  /// - Cannot be empty
  /// - Minimum 4 characters
  static String? emailOrUsername(String? value) {
    final input = value?.trim().toLowerCase();

    if (input == null || input.isEmpty) {
      return 'Please enter email or username';
    }

    if (input.length < 4) {
      return 'Minimum 4 characters required';
    }

    return null;
  }

  /// Signup

  /// Validates email address.
  ///
  /// Rules:
  /// - Cannot be empty
  /// - Must follow valid email format
  /// - Must contain domain and TLD (example: .com, .in)
  static String? email(String? value) {
    final email = value?.trim().toLowerCase();

    if (email == null || email.isEmpty) {
      return 'Please enter email address';
    }

    if (!AppRegex.email.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates username.
  ///
  /// Rules:
  /// - Cannot be empty
  /// - Length: 4–20 characters
  /// - Must start with a letter
  /// - Allowed characters: letters, numbers, dot (.), underscore (_)
  /// - No consecutive dots or underscores
  /// - Cannot end with dot or underscore
  static String? username(String? value) {
    final username = value?.trim().toLowerCase();

    if (username == null || username.isEmpty) {
      return 'Please enter username';
    }

    if (username.length < 4 || username.length > 20) {
      return 'Username must be 4–20 characters';
    }

    /// Must start with a letter
    if (!AppRegex.usernameStartsWithLetter.hasMatch(username)) {
      return 'Username must start with a letter';
    }

    /// Allowed characters only
    if (!AppRegex.usernameAllowedChars.hasMatch(username)) {
      return 'Only letters, numbers, dot (.) and underscore (_) allowed';
    }

    /// No consecutive dots or underscores
    if (AppRegex.usernameNoRepeat.hasMatch(username)) {
      return 'No consecutive dots or underscores allowed';
    }

    /// Cannot end with dot or underscore
    if (AppRegex.usernameEndRestriction.hasMatch(username)) {
      return 'Username cannot end with dot or underscore';
    }

    return null;
  }

  /// Validates full name input.
  static String? fullName(String? value) {
    final name = value?.trim();

    if (name == null || name.isEmpty) {
      return 'Please enter full name';
    }

    if (name.length < 4) {
      return 'Name is too short';
    }

    if (!name.contains(' ')) {
      return 'Enter first and last name';
    }

    return null;
  }

  /// Password

  /// Validates password input.
  ///
  /// Rules:
  /// - Min 8 characters
  /// - At least one uppercase letter
  /// - At least one lowercase letter
  /// - At least one number
  /// - At least one special character
  static String? password(String? value) {
    final password = value?.trim();

    if (password == null || password.isEmpty) {
      return 'Please enter password';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (password.contains(' ')) {
      return 'Spaces are not allowed';
    }

    if (!AppRegex.passwordUppercase.hasMatch(password)) {
      return 'Must contain uppercase letter';
    }

    if (!AppRegex.passwordLowercase.hasMatch(password)) {
      return 'Must contain lowercase letter';
    }

    if (!AppRegex.passwordNumber.hasMatch(password)) {
      return 'Must contain a number';
    }

    if (AppRegex.passwordSpecial.hasMatch(password)) {
      return 'Must contain a special character';
    }

    return null;
  }

  /// Validates confirm password field
  static String? confirmPassword(
    String? confirmPassword,
    String originalPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please enter confirm password';
    }

    if (confirmPassword != originalPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Phone
  /// validation depends on package internals
}
