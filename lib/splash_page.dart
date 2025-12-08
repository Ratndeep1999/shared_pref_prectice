import 'package:flutter/material.dart';

import 'Widgets/label_text_widget.dart';

/// SplashPage class (mutable/state data changeable)
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

/// State class
class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [Center(child: LabelTextWidget(label: "Splash Page"))],
      ),
    ),
  );
}
