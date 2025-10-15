import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/theme/app_themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.of(6).h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hey there.',
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontFamily: 'MySoul'),
          ),
          SizedBox(height: Spacing.of(6).h),
          Text(
            'Welcome to my portfolio! Here you can explore my projects, learn more about me, and get in touch.',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: colors.primary),
          ),
          // Add more content here
        ],
      ),
    );
  }
}
