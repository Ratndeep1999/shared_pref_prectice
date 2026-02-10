import 'package:flutter/material.dart';
import 'package:shared_pref_prectice/Pages/forget_password_page.dart';
import 'package:shared_pref_prectice/core/constants/app_strings.dart';
import '../../Pages/home_page.dart';
import '../../Pages/login_page.dart';
import '../../Pages/sign_up_page.dart';
import '../../Pages/splash_page.dart';
import '../theme/app_theme.dart';
import 'app_routes.dart';

/// Root widget of the application.
///
/// Responsibilities:
/// - Initializes MaterialApp
/// - Registers all named routes
/// - Applies global app configuration (theme, title, etc.)
///
/// This widget should NOT contain business logic.

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Application title (used by OS task switcher)
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      /// Theme
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      /// Initial route when app launches
      initialRoute: AppRoutes.splash,

      /// Named route registrations
      routes: {
        AppRoutes.splash: (_) => const SplashPage(),

        /// _ : means Context
        AppRoutes.login: (_) => const LoginPage(),
        AppRoutes.signup: (_) => const SignUpPage(),
        AppRoutes.home: (_) => const HomePage(),
        AppRoutes.forgetPassword: (_) => const ForgetPasswordPage(),
      },
    );
  }
}
