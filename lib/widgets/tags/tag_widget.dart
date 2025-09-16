// BASE WIDGET FOR TAGS
import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Color? borderColor;
  final double borderWidth;

  const TagWidget({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.fontSize = 12,
    this.horizontalPadding = 12,
    this.verticalPadding = 6,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
