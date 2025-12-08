import 'package:flutter/material.dart';
import '../Widgets/label_text_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: LabelTextWidget(label: "SignUp Page"),
      centerTitle: true,
      backgroundColor: Colors.purple,
    ),
    body: SafeArea(child: Column(children: [])),
  );
}
