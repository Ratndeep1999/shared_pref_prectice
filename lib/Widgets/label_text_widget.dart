import 'package:flutter/material.dart';

/// Custom Label Widget
class LabelTextWidget extends StatelessWidget {
  const LabelTextWidget({
    super.key,
    required this.label,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
  });

  /// Parameters
  final String label;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
