import 'package:flutter/material.dart';

class Project {
  final String name;
  final String date; // e.g. "March 2025"
  final String projectType; // e.g. "Web Platform", "Mobile App"
  final bool isOngoing; // true if ongoing, false if finished
  final String summary;
  final List<TechStack> techStack;
  final List<Roles> rolesStack; // List of roles as Tags
  final List<String> imagePaths; // local asset paths or URLs
  final String? demoUrl;
  final String? repoUrl;
  final String accessibilityNotes;
  final String? logoPath; // optional logo path

  Project({
    required this.name,
    required this.date,
    required this.projectType,
    this.isOngoing = false, // default to false (finished)
    required this.summary,
    required this.techStack,
    required this.rolesStack,
    required this.imagePaths,
    this.demoUrl,
    this.repoUrl,
    required this.accessibilityNotes,
    this.logoPath,
  });
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
