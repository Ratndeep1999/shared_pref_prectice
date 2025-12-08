import 'package:flutter/material.dart';
import 'label_text_widget.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    super.key,
    required this.buttonLabel,
    required this.onPress,
    this.buttonColor,
  });

  /// Parameters
  final String buttonLabel;
  final VoidCallback onPress;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 250,
      child: FilledButton(
        onPressed: onPress,
        style: FilledButton.styleFrom(
          backgroundColor: buttonColor ?? Colors.purple,
        ),
        child: LabelTextWidget(
          label: buttonLabel,
          fontSize: 20,
          fontColor: Colors.black,
        ),
      ),
    );
  }
}
