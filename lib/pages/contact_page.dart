import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_themes.dart';
import '../widgets/contact_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isWide = width >= 600; // MUI sm breakpoint

    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    Widget buildSocialButton({
      required IconData icon,
      required String label,
      required String url,
      bool showCat = false,
      bool isSelected = false,
    }) {
      final isDark = theme.brightness == Brightness.dark;
      final Color textAndIcon = isDark
          ? AppColors.accentOrange
          : colors.secondary;

      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              width: isWide
                  ? null
                  : double.infinity, // fill width only on mobile
              child: ElevatedButton(
                onPressed: () async {
                  final uri = Uri.parse(
                    url.startsWith('http') ? url : 'https://$url',
                  );
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    states,
                  ) {
                    if (states.contains(WidgetState.hovered)) {
                      return isDark
                          ? colors.secondary.withOpacity(0.25)
                          : colors.secondary.withOpacity(0.25);
                    }
                    return colors.secondary.withOpacity(0.1);
                  }),
                  foregroundColor: WidgetStateProperty.all(textAndIcon),
                  side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                    if (isSelected) {
                      return BorderSide(
                        color: isDark
                            ? colors.secondary.withOpacity(0.5)
                            : colors.secondary.withOpacity(0.7),
                        width: 2.5,
                      );
                    }
                    if (states.contains(WidgetState.hovered)) {
                      return BorderSide(
                        color: isDark
                            ? colors.secondary.withOpacity(0.7)
                            : colors.secondary.withOpacity(0.7),
                        width: 2,
                      );
                    }
                    return null;
                  }),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: Spacing.of(6).w,
                      vertical: Spacing.of(5).h,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  elevation: WidgetStateProperty.all(0),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // always centered
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 20, color: textAndIcon),
                    SizedBox(width: Spacing.of(2).w),
                    Flexible(
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: textAndIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showCat)
            Positioned(
              top: -115,
              child: Lottie.asset(
                isDark
                    ? 'assets/animations/cat_typing_darkmode.json'
                    : 'assets/animations/cat_typing_lightmode.json',
                width: 150,
                height: 150,
                repeat: true,
              ),
            ),
        ],
      );
    }

    Widget buildContactFormIntro() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Me',
              style: theme.textTheme.displayMedium?.copyWith(
                fontFamily: 'MySoul',
              ),
            ),
            SizedBox(height: Spacing.of(6).h),
            Text(
              'Interested in my work, or in working with me?',
              style: theme.textTheme.bodyLarge,
            ),
            Text('Send me a message below!', style: theme.textTheme.bodyLarge),
            SizedBox(height: Spacing.of(6).h),
          ],
        ),
      );
    }

    Widget buildContactFormSection() {
      return Expanded(
        flex: isWide ? 6 : 0,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Spacing.of(6).h),
              const ContactForm(),
            ],
          ),
        ),
      );
    }

    Widget buildSocialColumn() {
      if (isWide) {
        return IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSocialButton(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                url: 'www.linkedin.com/in/wilma-paloheimo',
                showCat: true,
              ),
              SizedBox(height: Spacing.of(6).h),
              buildSocialButton(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                url: 'https://github.com/luminietos',
              ),
              SizedBox(height: Spacing.of(6).h),
              buildSocialButton(
                icon: FontAwesomeIcons.dribbble,
                label: 'Dribbble',
                url: 'https://dribbble.com/luminietos',
              ),
            ],
          ),
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Spacing.of(20).h),
            buildSocialButton(
              icon: FontAwesomeIcons.linkedin,
              label: 'LinkedIn',
              url: 'www.linkedin.com/in/wilma-paloheimo',
              showCat: true,
            ),
            SizedBox(height: Spacing.of(6).h),
            buildSocialButton(
              icon: FontAwesomeIcons.github,
              label: 'GitHub',
              url: 'https://github.com/luminietos',
            ),
            SizedBox(height: Spacing.of(6).h),
            buildSocialButton(
              icon: FontAwesomeIcons.dribbble,
              label: 'Dribbble',
              url: 'https://dribbble.com/luminietos',
            ),
            SizedBox(
              height: Spacing.of(20).h,
            ), // Extra space at bottom on mobile
          ],
        );
      }
    }

    // 🧱 Layout switch
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.of(3),
        vertical: Spacing.of(6),
      ),
      child: isWide
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContactFormIntro(),
                SizedBox(height: Spacing.of(8).h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildContactFormSection(),
                    SizedBox(width: Spacing.of(6).w),
                    buildSocialColumn(),
                  ],
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContactFormIntro(),
                // SizedBox(height: Spacing.of(3).h),
                buildContactFormSection(),
                SizedBox(height: Spacing.of(8).h),
                buildSocialColumn(),
              ],
            ),
    );
  }
}
