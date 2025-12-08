import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSaved,
    this.focusNode,
    this.isSuffixIcon = false,
    this.suffixIcon,
    required this.hintText,
  });

  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String?>? validator;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? focusNode;
  final bool isSuffixIcon;
  final IconData? suffixIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      focusNode: focusNode,
      decoration: InputDecoration(
        suffixIcon: isSuffixIcon ? Icon(suffixIcon) : null,
        hint: Text(hintText),
      ),
    );
  }
}
