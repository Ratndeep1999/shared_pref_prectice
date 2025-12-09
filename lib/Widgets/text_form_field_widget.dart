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
    this.nextFocus,
  });

  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String?>? validator;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
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
      onFieldSubmitted: _onFieldSubmitted(context),
      decoration: InputDecoration(
        suffixIcon: isSuffixIcon ? Icon(suffixIcon) : null,
        hint: Text(hintText),
      ),
    );
  }

  /// Method to check next focus
  _onFieldSubmitted(BuildContext context) {
    nextFocus == null
        ? FocusScope.of(context).unfocus()
        : FocusScope.of(context).nextFocus();
  }
}
