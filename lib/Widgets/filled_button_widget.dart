import 'package:flutter/material.dart';
import 'label_text_widget.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    super.key,
    required this.buttonLabel,
    required this.onPress,
  });

  /// Parameters
  final String buttonLabel;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 250,
      child: FilledButton(
        onPressed: onPress,
        child: LabelTextWidget(label: buttonLabel, fontSize: 20),
      ),
    );
  }
}
