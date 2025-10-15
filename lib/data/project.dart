import 'package:flutter/material.dart';

class Project {
  final String name;
  final String date; // e.g. "March 2025"
  final String projectType; // e.g. "Web Platform", "Mobile App"
  final bool isOngoing; // true if ongoing, false if finished
  final String summary;

  // Tags!
  final List<TechStack> techStack;
  final List<Roles> rolesStack;
  final List<String>? collaborationTools;

  // 🆕 Optional image sets
  final List<ProjectImage>? imagePaths; // e.g., general project images
  final List<ProjectImage>?
  myIllustrations; // e.g., custom artwork / illustrations
  final String? logoPath; // optional logo path

  final String? demoUrl;
  final String? repoUrl;
  final String? accessibilityNotes;

  // 🆕 New optional storytelling fields
  final String? purpose;
  final String? actionsAndProcess;
  final String? result;
  final String? projectLink;
  final String? clientOrCompany;
  final String? duration;
  final String? toolsUsed;

  final String? collaboration;

  Project({
    required this.name,
    required this.date,
    required this.projectType,
    this.isOngoing = false,
    required this.summary,
    required this.techStack,
    required this.rolesStack,
    this.collaborationTools,
    this.imagePaths,
    this.myIllustrations,
    this.logoPath,
    this.accessibilityNotes,
    this.demoUrl,
    this.repoUrl,
    this.purpose,
    this.actionsAndProcess,
    this.result,
    this.projectLink,
    this.clientOrCompany,
    this.duration,
    this.toolsUsed,
    this.collaboration,
  });
}

// 🆕 A reusable model for an image + description
class ProjectImage {
  final String path;
  final String? caption; // optional descriptive text

  ProjectImage(this.path, {this.caption});
}

class TechStack {
  final String label;
  final Color backgroundColor;

  TechStack(this.label, this.backgroundColor);
}

class Roles {
  final String label;
  final Color backgroundColor;

  Roles(this.label, {this.backgroundColor = Colors.grey});
}
