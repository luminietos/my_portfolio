import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/widgets/tabrow.dart';
import '../../theme/app_themes.dart';

class Header extends StatelessWidget {
  final String currentTab;
  final Function(String) onTabSelected;

  const Header({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Breakpoint at 600px (MUI sm)
    final bool isSmallScreen = screenWidth <= 400;
    final bool isTinyScreen = screenWidth <= 250;

    final colors = Theme.of(context).colorScheme;
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark; // true if dark mode
    final txtWeight = isDarkMode ? FontWeight.w500 : FontWeight.w600;
    final titleWeight = isDarkMode ? FontWeight.w400 : FontWeight.w500;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20.h),
        Center(
          child: Column(
            children: [
              Text(
                'Wilma Paloheimo',
                style:
                    (isTinyScreen
                            ? Theme.of(context).textTheme.displaySmall
                            : isSmallScreen
                            ? Theme.of(context).textTheme.displayMedium
                            : Theme.of(context).textTheme.displayLarge)
                        ?.copyWith(
                          color: colors.primary,
                          fontFamily: 'Astloch',
                          fontWeight: titleWeight,
                        ),
              ),
              SizedBox(height: 8.h),
              // DESCRIPTION TEXT
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'CormorantUnicase',
                  ),
                  children: [
                    TextSpan(
                      text: 'Cross-Platform Developer ',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: txtWeight,
                      ),
                    ),
                    TextSpan(
                      text: '-', // ･ﾟ✧'
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: txtWeight,
                      ),
                    ),
                    TextSpan(
                      text: ' UI/UX Designer ',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: txtWeight,
                      ),
                    ),
                    TextSpan(
                      text: '-', // ･ﾟ✧'

                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: txtWeight,
                      ),
                    ),
                    TextSpan(
                      text: ' Accessibility Advocate',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: txtWeight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),

              // Full-width line
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: colors.primary,
              ),
              SizedBox(height: 8.h),
              // Tabs below
              TabRow(currentTab: currentTab, onTabSelected: onTabSelected),
            ],
          ),
        ),
        SizedBox(height: Spacing.of(6).h),
      ],
    );
  }
}
