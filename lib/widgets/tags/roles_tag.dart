import 'package:flutter/material.dart';
import 'tag_widget.dart';

class RolesTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;

  const RolesTag({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.fontSize = 12,
    this.horizontalPadding = 12,
    this.verticalPadding = 6,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackgroundColor = backgroundColor;
    final Color resolvedTextColor = textColor;

    return TagWidget(
      text: text,
      backgroundColor: resolvedBackgroundColor,
      textColor: resolvedTextColor,
      fontSize: fontSize,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
    );
  }
}
