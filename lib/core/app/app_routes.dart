/// Defines all named routes used in the application.
///
/// This class acts as a single source of truth for
/// navigation paths across the app.
///
/// Benefits:
/// - Prevents hardcoded route strings
/// - Makes refactoring safe and easy
/// - Enables route-based access control in future
///
/// Usage:
/// Navigator.pushNamed(context, AppRoutes.login);

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const forgetPassword = '/forgetPassword';
  static const checkNumber = '/checkNumber';
  static const getPassword = '/getPassword';
}
