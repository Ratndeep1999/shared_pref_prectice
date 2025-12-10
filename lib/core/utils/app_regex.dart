/// Centralized RegExp definitions used across the app.
///
/// Benefits:
/// - Single source of truth
/// - Easy maintenance
/// - Avoids RegExp duplication
/// - Improves readability of validators
///
class AppRegex {
  AppRegex._(); // prevents instantiation

  /// Email validation regex
  static final RegExp email =
  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');

  /// Username must start with a letter
  static final RegExp usernameStartsWithLetter =
  RegExp(r'^[a-zA-Z]');

  /// Username allowed characters
  static final RegExp usernameAllowedChars =
  RegExp(r'^[a-zA-Z0-9._]+$');

  /// Prevent consecutive dots or underscores
  static final RegExp usernameNoRepeat =
  RegExp(r'[._]{2,}');

  /// Username cannot end with dot or underscore
  static final RegExp usernameEndRestriction =
  RegExp(r'[._]$');

  /// Password rules
  static final RegExp passwordUppercase = RegExp(r'[A-Z]');
  static final RegExp passwordLowercase = RegExp(r'[a-z]');
  static final RegExp passwordNumber = RegExp(r'[0-9]');
  static final RegExp passwordSpecial = RegExp(r'[!@\$&*~_]');
}
