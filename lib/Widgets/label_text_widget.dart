import 'package:flutter/material.dart';

/// Custom Label Widget
class LabelTextWidget extends StatelessWidget {
  const LabelTextWidget({
    super.key,
    required this.label,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.fontColor
  });

  /// Parameters
  final String label;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: fontColor ?? Colors.purple,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
