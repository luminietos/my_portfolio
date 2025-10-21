// PROJECT DETAILS PAGE: IMPLEMENTATION

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/data/project.dart';
import 'package:my_portfolio/data/projects_data.dart';
import 'package:my_portfolio/theme/app_themes.dart';
import 'package:my_portfolio/widgets/project_card.dart';
import 'package:my_portfolio/widgets/project_details_page.dart';

class ProjectsPage extends StatelessWidget {
  final Project? selectedProject; // 👈 NEW
  final Function(Project?) onProjectSelected; // 👈 NEW

  const ProjectsPage({
    super.key,
    this.selectedProject,
    required this.onProjectSelected,
  });

  int _getCrossAxisCount(double width) {
    if (width >= 1280) return 4;
    if (width >= 960) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = _getCrossAxisCount(width);
    final spacing = Spacing.of(1).w;
    final totalSpacing = spacing * (crossAxisCount - 1);
    final cardWidth = (width - totalSpacing - 32.w) / crossAxisCount;

    final List<Project> _projects = projects;

    // 👇 Show project details page if a project is selected
    if (selectedProject != null) {
      return ProjectDetailsPage(
        project: selectedProject!,
        onClose: () => onProjectSelected(null),
        fullScreen: false,
      );
    }

    // ✅ Default: show grid of project cards (no internal scroll)
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.of(1),
        vertical: Spacing.of(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Projects',
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontFamily: 'MySoul'),
          ),
          SizedBox(height: Spacing.of(6).h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.of(2).w,
              vertical: Spacing.of(3).h,
            ),
            child: Wrap(
              spacing: spacing,
              runSpacing: spacing,
              alignment: WrapAlignment.start,
              children: _projects.map((project) {
                return SizedBox(
                  width: cardWidth,
                  child: ProjectCard(
                    project: project,
                    onTap: () => onProjectSelected(project),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
