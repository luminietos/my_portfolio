// lib/pages/project_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/data/project.dart';
import 'package:my_portfolio/theme/app_themes.dart';
import 'package:my_portfolio/widgets/tags/roles_tag.dart';
import 'package:my_portfolio/widgets/tags/tech_stack_tag.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_portfolio/widgets/accessible_carousel.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Project project;
  final VoidCallback onClose;
  final bool fullScreen;

  const ProjectDetailsPage({
    super.key,
    required this.project,
    required this.onClose,
    this.fullScreen = false,
  });

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final width = MediaQuery.of(context).size.width;

    double tagSpacing;
    double tagRunSpacing;

    if (width > 1200) {
      tagSpacing = 6.w;
      tagRunSpacing = 6.h;
    } else if (width > 814) {
      tagSpacing = 4.w;
      tagRunSpacing = 4.h;
    } else {
      tagSpacing = 6.w;
      tagRunSpacing = 6.h;
    }

    final isDark = theme.brightness == Brightness.dark;
    final closeIconColor = isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;
    final projectNameColor = isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;
    final summaryColor = isDark ? Colors.white70 : Colors.black87;

    final onSurface = colors.primary;
    final surface = colors.surface;

    final hasImages =
        widget.project.imagePaths != null &&
        widget.project.imagePaths!.isNotEmpty;
    final hasIllustrations =
        widget.project.myIllustrations != null &&
        widget.project.myIllustrations!.isNotEmpty;

    Widget buildProjectContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🏷️ H1: PROJECT TITLE with Close Button Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.project.name,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: projectNameColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quintessential',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: closeIconColor),
                onPressed: widget.onClose,
                tooltip: 'Close',
              ),
            ],
          ),
          SizedBox(height: Spacing.of(8).h),

          // 🏷️ H2: OVERVIEW
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text(
          //       "ˏˋ°•*⁀➷",
          //       style: theme.textTheme.displayMedium?.copyWith(
          //         color: onSurface,
          //       ),
          //     ),
          //     SizedBox(width: Spacing.of(2).w),
          //     Text(
          //       "project overview",
          //       style: theme.textTheme.displayMedium?.copyWith(
          //         color: onSurface,
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: Spacing.of(3).h),

          // Summary
          Text(
            widget.project.summary,
            style: theme.textTheme.bodyLarge?.copyWith(color: summaryColor),
          ),
          SizedBox(height: Spacing.of(10).h),

          // ROLES & TECH STACK
          Text(
            "My Roles & the Tech Stack",
            style: theme.textTheme.displaySmall?.copyWith(color: onSurface),
          ),
          SizedBox(height: Spacing.of(6).h),

          Wrap(
            spacing: tagSpacing,
            runSpacing: tagRunSpacing,
            children: widget.project.rolesStack
                .map((r) => RolesTag(text: r.label, onSurface: colors.primary))
                .toList(),
          ),

          SizedBox(height: Spacing.of(4).h),

          Wrap(
            spacing: tagSpacing,
            runSpacing: tagRunSpacing,
            children: widget.project.techStack
                .map(
                  (t) => TechStackTag(
                    text: t.label,
                    backgroundColor: t.backgroundColor,
                    textColor: surface,
                  ),
                )
                .toList(),
          ),

          // 🏷️ H2: DESIGN & DEVELOPMENT PROCESS
          if (widget.project.purpose != null ||
              widget.project.actionsAndProcess != null ||
              widget.project.result != null ||
              widget.project.collaboration != null) ...[
            SizedBox(height: Spacing.of(12).h),
            Text(
              "Design & Development Process",
              style: theme.textTheme.displayMedium?.copyWith(color: onSurface),
            ),
          ],

          // Purpose
          if (widget.project.purpose != null) ...[
            SizedBox(height: Spacing.of(6).h),
            Text(
              "Purpose",
              style: theme.textTheme.displaySmall?.copyWith(color: onSurface),
            ),
            SizedBox(height: Spacing.of(2).h),
            Text(widget.project.purpose!, style: theme.textTheme.bodyLarge),
          ],

          // 🏷️ Collaboration Section
          if (widget.project.collaboration != null ||
              (widget.project.collaborationTools != null &&
                  widget.project.collaborationTools!.isNotEmpty)) ...[
            SizedBox(height: Spacing.of(8).h),
            Text(
              "Collaboration",
              style: theme.textTheme.displaySmall?.copyWith(color: onSurface),
            ),
            SizedBox(height: Spacing.of(4).h),

            // Collaboration Tools Tags
            if (widget.project.collaborationTools != null &&
                widget.project.collaborationTools!.isNotEmpty)
              Wrap(
                spacing: tagSpacing,
                runSpacing: tagRunSpacing,
                children: widget.project.collaborationTools!
                    .map(
                      (tool) => RolesTag(text: tool, onSurface: colors.primary),
                    )
                    .toList(),
              ),

            SizedBox(height: Spacing.of(4).h),

            // Collaboration Description Text
            if (widget.project.collaboration != null)
              Text(
                widget.project.collaboration!,
                style: theme.textTheme.bodyLarge,
              ),
          ],

          // Result
          if (widget.project.result != null) ...[
            SizedBox(height: Spacing.of(6).h),
            Text(
              "Result",
              style: theme.textTheme.displaySmall?.copyWith(color: onSurface),
            ),
            SizedBox(height: Spacing.of(2).h),
            Text(widget.project.result!, style: theme.textTheme.bodyLarge),
          ],

          // View Project button
          if (widget.project.projectLink != null) ...[
            SizedBox(height: Spacing.of(10).h),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Padding(
                  // 🧠 Keeps touch area large without changing layout visually
                  padding: EdgeInsets.symmetric(vertical: Spacing.of(2).h),
                  child: TextButton.icon(
                    iconAlignment: IconAlignment.start,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(onSurface),
                      foregroundColor: WidgetStateProperty.all(surface),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (states) => states.contains(WidgetState.hovered)
                            ? surface.withOpacity(0.15)
                            : null,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        // 👇 This is the visible padding
                        EdgeInsets.symmetric(
                          horizontal: Spacing.of(2).w,
                          vertical: Spacing.of(3).h,
                        ),
                      ),
                      minimumSize: WidgetStateProperty.all(
                        // 👇 Ensures WCAG-compliant hit area
                        Size(Spacing.of(24).w, Spacing.of(12).h),
                      ),
                    ),
                    icon: Padding(
                      // 👇 Nudge icon left while keeping touch target safe
                      padding: EdgeInsets.only(left: 4.w, right: 6.w),
                      child: Icon(Icons.link, color: surface, size: 18.w),
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Text(
                        'View Project',
                        style: TextStyle(
                          color: surface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final uri = Uri.parse(widget.project.projectLink!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.platformDefault,
                          webOnlyWindowName:
                              '_blank', // opens in new tab on web
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],

          // Divider!!
          SizedBox(height: Spacing.of(10).h),
          Container(
            width: double.infinity,
            height: 0.5,
            color: colors.secondary,
          ),

          // 🏷️ H2: VISUAL GALLERY
          if (hasImages || hasIllustrations) ...[
            SizedBox(height: Spacing.of(12).h),
            Text(
              "Visual Gallery",
              style: theme.textTheme.displayMedium?.copyWith(color: onSurface),
            ),
          ],

          if (hasImages) ...[
            SizedBox(height: Spacing.of(6).h),
            AccessibleCarousel(
              imagePaths: widget.project.imagePaths!,
              sectionTitle: "Screenshots",
              onSurface: onSurface,
            ),
          ],

          if (hasIllustrations) ...[
            SizedBox(height: Spacing.of(6).h),
            AccessibleCarousel(
              imagePaths: widget.project.myIllustrations!,
              sectionTitle: "My illustrations for this project",
              onSurface: onSurface,
              isHandmadeIllustrations: true,
            ),
          ],
        ],
      );
    }

    // Layouts
    if (!widget.fullScreen) {
      return Padding(
        padding: EdgeInsets.all(Spacing.of(4).w),
        child: SingleChildScrollView(child: buildProjectContent()),
      );
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(Spacing.of(6).w),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close, color: closeIconColor),
              onPressed: widget.onClose,
              tooltip: 'Close',
            ),
          ),
          SizedBox(height: Spacing.of(3).h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: Spacing.of(6).h),
              child: buildProjectContent(),
            ),
          ),
        ],
      ),
    );
  }
}
