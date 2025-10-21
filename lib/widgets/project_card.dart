// CARD BASE FOR PROJECTS
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/project.dart';
import '../theme/app_themes.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;

    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark; // true if dark mode

    final Color cardBg = isDarkMode ? colors.primary : colors.surface;
    final Color cardTop = isDarkMode ? colors.surface : colors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colors.primary, width: 2),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 HEADER STRIP
            Container(
              color: cardTop,
              padding: EdgeInsets.symmetric(vertical: Spacing.of(3).h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Project type (left)
                  Padding(
                    padding: EdgeInsets.only(left: Spacing.of(2).w),
                    child: Text(
                      project.projectType.toUpperCase(),
                      style: texts.bodyLarge?.copyWith(
                        color: cardBg,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  // 📅 Date (right, replaces status tag)
                  Padding(
                    padding: EdgeInsets.only(right: Spacing.of(2).w),
                    child: Text(
                      project.date,
                      style: texts.bodyMedium?.copyWith(
                        color: AppColors.accentOrange,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Astloch',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 MAIN CONTENT
            Padding(
              padding: EdgeInsets.all(Spacing.of(3).w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 👇 Logo (if exists)
                  if (project.logoPath != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: Spacing.of(4).h),
                      child: Image.asset(
                        project.logoPath!,
                        height: 90.h,
                        fit: BoxFit.contain,
                      ),
                    ),

                  // 🏷️ Project Name (below logo)
                  Text(
                    project.name,
                    style: texts.headlineSmall?.copyWith(
                      color: cardTop,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: Spacing.of(4).h),

                  // 📝 Summary
                  Text(
                    project.summary,
                    style: texts.bodyMedium?.copyWith(
                      color: isDarkMode ? colors.surface : colors.onSurface,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
