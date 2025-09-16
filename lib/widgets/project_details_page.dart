import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/data/project.dart';
import 'package:my_portfolio/theme/app_themes.dart';
import 'package:my_portfolio/widgets/tags/roles_tag.dart';
import 'package:my_portfolio/widgets/tags/tech_stack_tag.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Adaptive colors
    final closeIconColor = isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;
    final projectNameColor = isDark
        ? AppColors.darkPrimary
        : AppColors.lightPrimary;
    final summaryColor = isDark ? Colors.white70 : Colors.black87;

    final onSurface = colors.primary;
    final surface = colors.surface;

    Widget buildCarousel() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Spacing.of(6).h),
          // Divider above carousel
          Container(
            width: double.infinity,
            height: 0.5,
            color: AppColors.accentOrange,
          ),
          SizedBox(height: Spacing.of(6).h),
          Text(
            "My illustrations for this project",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: onSurface,
            ),
          ),
          SizedBox(height: Spacing.of(3).h),
          CarouselSlider(
            options: CarouselOptions(
              height: Spacing.of(75).h,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
            items: widget.project.imagePaths.map((path) {
              return Builder(
                builder: (context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(Spacing.of(3)),
                    child: Image.asset(
                      path,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: Spacing.of(5).h), // space above dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.project.imagePaths.asMap().entries.map((entry) {
              int index = entry.key;
              return Container(
                width: 6.w, // smaller dot
                height: 6.w,
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                decoration: BoxDecoration(
                  color: _currentImageIndex == index
                      ? onSurface
                      : Colors.transparent,
                  border: Border.all(color: onSurface, width: 1),
                  shape: BoxShape.circle,
                ),
              );
            }).toList(),
          ),
        ],
      );
    }

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
        if (widget.project.imagePaths.isNotEmpty) buildCarousel(),
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
                              backgroundColor: Colors.transparent,
                              textColor: colors.primary,
                            ),
                          )
                          .toList(),
                    ),
                    if (widget.project.imagePaths.isNotEmpty) buildCarousel(),
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
