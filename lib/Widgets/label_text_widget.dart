import 'package:flutter/material.dart';

/// Custom Label Widget
class LabelTextWidget extends StatelessWidget {
  const LabelTextWidget({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
