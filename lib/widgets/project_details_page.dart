import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/data/project.dart';
import 'package:my_portfolio/theme/app_themes.dart';
import 'package:my_portfolio/widgets/tags/roles_tag.dart';
import 'package:my_portfolio/widgets/tags/tech_stack_tag.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    final isDark = theme.brightness == Brightness.dark;

    // Adaptive colors
    final closeIconColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final projectNameColor =
        isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final summaryColor = isDark ? Colors.white70 : Colors.black87;

    final onSurface = colors.primary;
    final surface = colors.surface;

    // Shortcuts for optional lists
    final hasImages =
        widget.project.imagePaths != null && widget.project.imagePaths!.isNotEmpty;
    final hasIllustrations = widget.project.myIllustrations != null &&
        widget.project.myIllustrations!.isNotEmpty;

    Widget content = Column(
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
        Text(
          widget.project.name,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: projectNameColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Spacing.of(4).h),
        Text(
          widget.project.summary,
          style: theme.textTheme.bodyLarge?.copyWith(color: summaryColor),
        ),
        SizedBox(height: Spacing.of(4).h),
        Wrap(
          spacing: Spacing.of(2).w,
          runSpacing: Spacing.of(2).h,
          children: widget.project.rolesStack
              .map(
                (r) => RolesTag(
                  text: r.label,
                  textColor: surface,
                  backgroundColor: onSurface,
                ),
              )
              .toList(),
        ),
        SizedBox(height: Spacing.of(4).h),
        Wrap(
          spacing: Spacing.of(2).w,
          runSpacing: Spacing.of(2).h,
          children: widget.project.techStack
              .map(
                (t) => TechStackTag(
                  text: t.label,
                  textColor: onSurface,
                  backgroundColor: surface,
                  borderColor: onSurface,
                ),
              )
              .toList(),
        ),

        // NEW: Conditional carousels (non-fullscreen)
        if (hasImages)
          AccessibleCarousel(
            imagePaths: widget.project.imagePaths!,
            sectionTitle: "Screenshots",
            onSurface: onSurface,
          ),
        if (hasIllustrations)
          AccessibleCarousel(
            imagePaths: widget.project.myIllustrations!,
            sectionTitle: "My illustrations for this project",
            onSurface: onSurface,
          ),
      ],
    );

    if (widget.fullScreen) {
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
            Text(
              widget.project.name,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: projectNameColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Spacing.of(4).h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: Spacing.of(6).h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.summary,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: summaryColor,
                      ),
                    ),
                    SizedBox(height: Spacing.of(4).h),
                    Wrap(
                      spacing: Spacing.of(2).w,
                      runSpacing: Spacing.of(2).h,
                      children: widget.project.rolesStack
                          .map(
                            (r) => RolesTag(
                              text: r.label,
                              textColor: surface,
                              backgroundColor: onSurface,
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: Spacing.of(4).h),
                    Wrap(
                      spacing: Spacing.of(2).w,
                      runSpacing: Spacing.of(2).h,
                      children: widget.project.techStack
                          .map(
                            (t) => TechStackTag(
                              text: t.label,
                              backgroundColor: t.backgroundColor,
                              textColor: colors.surface,
                            ),
                          )
                          .toList(),
                    ),

                    // CONDITIONALS
                    if (widget.project.purpose != null) ...[
                      SizedBox(height: Spacing.of(6).h),
                      Text(
                        "Purpose",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: onSurface,
                        ),
                      ),
                      SizedBox(height: Spacing.of(2).h),
                      Text(
                        widget.project.purpose!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],

                    if (widget.project.actionsAndProcess != null) ...[
                      SizedBox(height: Spacing.of(6).h),
                      Text(
                        "Actions & Process",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: onSurface,
                        ),
                      ),
                      SizedBox(height: Spacing.of(2).h),
                      Text(
                        widget.project.actionsAndProcess!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],

                    if (widget.project.result != null) ...[
                      SizedBox(height: Spacing.of(6).h),
                      Text(
                        "Result",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: onSurface,
                        ),
                      ),
                      SizedBox(height: Spacing.of(2).h),
                      Text(
                        widget.project.result!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],

                    if (widget.project.projectLink != null) ...[
                      SizedBox(height: Spacing.of(6).h),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: TextButton.icon(
                          style: ButtonStyle(
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (states) {
                                if (states.contains(WidgetState.hovered)) {
                                  return onSurface.withOpacity(0.08);
                                }
                                return null;
                              },
                            ),
                          ),
                          onPressed: () async {
                            final uri = Uri.parse(widget.project.projectLink!);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                          icon: Icon(Icons.link, color: onSurface),
                          label: Text(
                            'View Project',
                            style: TextStyle(
                              color: onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],

                    // NEW: Separate accessible carousels
                    if (hasImages)
                      AccessibleCarousel(
                        imagePaths: widget.project.imagePaths!,
                        sectionTitle: "Screenshots",
                        onSurface: onSurface,
                      ),
                    if (hasIllustrations)
                      AccessibleCarousel(
                        imagePaths: widget.project.myIllustrations!,
                        sectionTitle: "My illustrations for this project",
                        onSurface: onSurface,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(padding: EdgeInsets.all(Spacing.of(4).w), child: content);
  }
}