import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/tags/roles_tag.dart';
import 'project.dart';

final List<Project> projects = [
  Project(
    name: 'Workzep',
    date: 'March 2025',
    projectType: 'WEB PLATFORM',
    isOngoing: true,
    summary: 'A web app for tracking tasks efficiently.',
    techStack: [
      TechStack('NextJs', Colors.deepPurpleAccent),
      TechStack('AWS', Colors.orangeAccent),
      TechStack('GitHub', Colors.black),
      TechStack('Figma', Colors.pinkAccent),
    ],
    rolesStack: [Roles('Cross-Platform Developer'), Roles('UI/UX Designer')],
    imagePaths: [
      'assets/images/project1_1.png',
      'assets/images/project1_2.png',
    ],
    demoUrl: 'https://demo.projectone.com',
    repoUrl: 'https://github.com/username/projectone',
    accessibilityNotes:
        'High contrast mode supported. ARIA labels on buttons. Keyboard navigation fully functional.',
  ),
  Project(
    name: 'Meaningful',
    date: 'Septembr 2024',
    projectType: 'MOBILE APP',
    isOngoing: true,
    summary: 'A mobile app for mental well-being.',
    techStack: [
      TechStack('Flutter', Colors.blue),
      TechStack('AWS', Colors.orangeAccent),
      TechStack('GitHub', Colors.black),
      TechStack('Figma', Colors.pinkAccent),
    ],
    rolesStack: [
      Roles('Team Lead'),
      Roles('Mobile Developer'),
      Roles('UI/UX Designer'),
      Roles('Accessibility Specialist'),
      Roles('Quality Assurance'),
      Roles('Illustrator'),
    ],

    imagePaths: [
      'assets/images/pondering_lime_shadowed.png',
      'assets/images/pondering_dusk_shadowed.png',
      'assets/images/handphone_invisibg.png',
      'assets/images/astronaut.png',
    ],
    logoPath: 'assets/images/meaningfulLogo-transparentBg.png',
    demoUrl: 'https://demo.projecttwo.com',
    repoUrl: 'https://github.com/username/projecttwo',
    accessibilityNotes:
        'VoiceOver and TalkBack support. High contrast mode. All interactive elements accessible via keyboard.',
    // Add other fields as needed...
  ),
  // Add other projects...
];
