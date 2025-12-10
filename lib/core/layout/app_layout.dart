/// For Responsive App
import 'package:flutter/material.dart';

class AppLayout {
  final BuildContext context;
  late final MediaQueryData _mediaQuery;
  late final ThemeData _theme;

  AppLayout(this.context) {
    _mediaQuery = MediaQuery.of(context);
    _theme = Theme.of(context);
  }

  /// Screen sizes
  double get h => _mediaQuery.size.height;
  double get w => _mediaQuery.size.width;

  /// Padding (SafeArea)
  EdgeInsets get safePadding => _mediaQuery.padding;

  /// Theme
  ThemeData get theme => _theme;

  /// Text styles shortcuts
  TextTheme get text => _theme.textTheme;

  /// Responsive helpers
  double hp(double percent) => h * percent / 100;
  double wp(double percent) => w * percent / 100;
}
