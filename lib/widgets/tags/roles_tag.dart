import 'package:flutter/material.dart';
import 'tag_widget.dart';

class RolesTag extends StatelessWidget {
  final String text;
  final Color onSurface;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;

  const RolesTag({
    super.key,
    required this.text,
    required this.onSurface,
    this.fontSize = 12,
    this.horizontalPadding = 12,
    this.verticalPadding = 6,
  });

  @override
  Widget build(BuildContext context) {
    return TagWidget(
      text: text,
      backgroundColor: Colors.transparent, // transparent background
      textColor: onSurface, // text colored onSurface
      borderColor: onSurface, // border also uses onSurface
      fontSize: fontSize,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
    );
  }
}
