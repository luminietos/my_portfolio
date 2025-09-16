import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/theme/app_themes.dart';
import 'package:my_portfolio/widgets/layout/side_borders.dart';
import 'package:my_portfolio/widgets/layout/footer.dart';
import 'package:my_portfolio/widgets/layout/header.dart';

class LayoutFrame extends StatelessWidget {
  final String currentTab;
  final Function(String) onTabSelected;
  final Widget child;

  const LayoutFrame({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // ensures viewport height
              ),
              child: IntrinsicHeight(
                child: SideBorders(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Do NOT add padding to header or footer; they need to be full-width
                      Header(
                        currentTab: currentTab,
                        onTabSelected: onTabSelected,
                      ),

                      // main content (NO scroll here)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.of(5).w,
                          ),
                          child: child,
                        ),
                      ),

                      // divider + footer
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: colors.primary,
                      ),

                      const Footer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
