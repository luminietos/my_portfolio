import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_themes.dart';

class SideBorders extends StatelessWidget {
  final Widget child;

  const SideBorders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Breakpoint at 600px (MUI sm)
    final bool isSmallScreen = screenWidth < 600;

    final colors = Theme.of(context).colorScheme;

    if (isSmallScreen) {
      // No side borders, just 20px margin
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.of(5).w),
        child: child,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left margin + vertical line
        SizedBox(width: Spacing.of(5)),
        Container(width: 1, color: colors.primary),

        // Main content with horizontal padding between lines
        Expanded(child: child),

        // Right vertical line + margin
        Container(width: 1, color: colors.primary),
        SizedBox(width: Spacing.of(5)),
      ],
    );
  }
}
