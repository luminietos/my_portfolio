// CARD BASE FOR PROJECTS
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/widgets/tags/roles_tag.dart';
import 'package:my_portfolio/widgets/tags/tech_stack_tag.dart';
import 'package:my_portfolio/widgets/tags/status_tag.dart';
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

    final Color cardBg = isDarkMode
        ? colors.primary
        : colors.surface; // always white

    final Color cardTop = isDarkMode ? colors.surface : colors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cardBg, // Card background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colors.primary, width: 2),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER STRIP
            Container(
              color: cardTop, // const Color(0xFF443842)
              padding: EdgeInsets.symmetric(
                vertical: Spacing.of(3).h,
              ), // Card's top section's padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: Spacing.of(2).w),
                      child: Text(
                        project.projectType.toUpperCase(),
                        style: texts.bodyLarge?.copyWith(
                          color: cardBg, // TEXT COLOR
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                  // STATUS TAG
                  Padding(
                    padding: EdgeInsets.only(right: Spacing.of(2).w),
                    child: StatusTag(
                      status: project.isOngoing
                          ? ProjectStatus.ongoing
                          : ProjectStatus.finished,
                    ),
                  ),
                ],
              ),
            ),

            // MAIN CONTENT
            Padding(
              padding: EdgeInsets.all(
                Spacing.of(2).w,
              ), // Padding around the main content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Let height wrap content
                children: [
                  // PROJECT NAME
                  Center(
                    child: Text(
                      project.name,
                      style: texts.headlineSmall?.copyWith(
                        color: cardTop, // Project title
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: Spacing.of(5).h),

                  // 👇 Only show logo if present
                  if (project.logoPath != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: Spacing.of(3).h),
                      child: Center(
                        child: Image.asset(
                          project.logoPath!,
                          // height: 60.h, // adjust size as needed
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                  Wrap(
                    spacing: 2.w, // horizontal spacing
                    runSpacing: 2.h, // vertical spacing
                    alignment: WrapAlignment.start,
                    children: project.rolesStack
                        .map(
                          (r) => RolesTag(
                            text: r.label,
                            onSurface: isDarkMode
                                ? colors.surface
                                : colors.onSurface,
                          ),
                        )
                        .toList(),
                  ),

                  SizedBox(height: Spacing.of(3).h),

                  // TECH STACK TAGS: same wrap properties
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 2.h,
                    alignment: WrapAlignment.start,
                    children: project.techStack
                        .map(
                          (t) => TechStackTag(
                            text: t.label,
                            backgroundColor: t.backgroundColor,
                            textColor: colors.surface,
                            borderColor: colors.surface,

                            // keep sizes same
                          ),
                        )
                        .toList(),
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
