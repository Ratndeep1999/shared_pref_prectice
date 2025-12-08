import 'package:flutter/material.dart';

/// SplashPage class (mutable/state data changeable)
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

/// State class
class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: SafeArea(child: Column()));
}
