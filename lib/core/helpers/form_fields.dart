import 'package:flutter/material.dart';

class FormFields {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();

  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final usernameNode = FocusNode();
  final fullNameNode = FocusNode();
  final phoneNode = FocusNode();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();

    emailNode.dispose();
    passwordNode.dispose();
    usernameNode.dispose();
    fullNameNode.dispose();
    phoneNode.dispose();
  }
}
