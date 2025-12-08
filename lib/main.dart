import 'package:flutter/material.dart';

/// Entry point of the program
main() {
  runApp(const MyApp());
}

/// MyApp class (immutable)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SharedPreferences",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      /// Page tha appear first
      home: SplashPage(),
    );
  }
}
