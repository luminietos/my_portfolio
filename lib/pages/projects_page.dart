// PROJECT DETAILS PAGE: IMPLEMENTATION

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/data/project.dart';
import 'package:my_portfolio/data/projects_data.dart';
import 'package:my_portfolio/theme/app_themes.dart';
import 'package:my_portfolio/widgets/project_card.dart';
import 'package:my_portfolio/widgets/project_details_page.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with SingleTickerProviderStateMixin {
  Project? selectedProject;
  final List<Project> _projects = projects;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openProject(Project project) {
    setState(() {
      selectedProject = project;
    });
    _controller.forward(from: 0);
  }

  void _closeProject() {
    _controller.reverse().then((_) {
      if (mounted) {
        setState(() {
          selectedProject = null;
        });
      }
    });
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1280) return 4;
    if (width >= 960) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  Animation<Offset> _getSlideAnimation(double width) {
    // Mobile: slide from bottom
    if (width < 960) {
      return Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    }
    // Desktop/tablet: no offset, stays centered
    return Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = _getCrossAxisCount(width);
    final spacing = Spacing.of(1).w;
    final totalSpacing = spacing * (crossAxisCount - 1);
    final cardWidth = (width - totalSpacing - 32.w) / crossAxisCount;

    final colors = Theme.of(context).colorScheme;

    final slideAnimation = _getSlideAnimation(width);

    return Stack(
      children: [
        // GRID OF PROJECT CARDS
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
                  onTap: () => _openProject(project),
                ),
              );
            }).toList(),
          ),
        ),

        // FULL-PAGE OVERLAY WITH ANIMATION
        if (selectedProject != null)
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: Positioned.fill(
                child: Material(
                  color: colors.surface, // Overlay background color
                  child: SizedBox.expand(
                    child: ProjectDetailsPage(
                      project: selectedProject!,
                      onClose: _closeProject,
                      fullScreen: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
