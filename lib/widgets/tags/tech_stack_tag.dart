import 'package:flutter/material.dart';
import 'tag_widget.dart';

class TechStackTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;

  const TechStackTag({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,

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
      borderColor: borderColor,
    );
  }
}
