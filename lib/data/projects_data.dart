import 'package:flutter/material.dart';
import 'project.dart';
import 'package:my_portfolio/utils.dart';

final List<Project> projects = [
  Project(
    name: 'Workzep',
    date: 'March 2025',
    projectType: 'WEB PLATFORM',
    isOngoing: false,
    summary: 'AI-driven Goal Management Web Platform',
    purpose:
        'As part of Workzep’s product development, I implemented the company’s brand identity...',
    actionsAndProcess: '''
– Interpreted Workzep’s brand values and translated them into product design principles.
– Built a design system defining typography, color tokens, and component behavior.
– Ensured accessibility through contrast testing and responsive layouts.
– Collaborated with developers to integrate design tokens into Flutter.
''',
    result:
        'A unified, scalable digital identity that reinforced trust and usability.',
    projectLink: 'https://www.workzep.com/',
    clientOrCompany: 'Workzep Oy',
    duration: 'March–April 2025',
    techStack: [
      TechStack('Next.js', Colors.deepPurple), // Black
      TechStack('React', Colors.lightBlue), // Light blue
      TechStack('AWS', Colors.orange), // Orange
      TechStack('GitHub', Colors.blueGrey), // Black
      TechStack('Figma', Colors.pinkAccent), // Multi-colored
      TechStack('EmailJS', Colors.orangeAccent), // Orange
    ],
    rolesStack: [
      Roles('UI/UX Designer'),
      Roles('Developer'),
      Roles('Brand Implementation'),
    ],
    imagePaths: [
      ProjectImage(
        assetPath('images/pondering_lime_shadowed.png'),
        caption: 'Second onboarding screen\'s illustration | Lime theme',
      ),
    ],
    accessibilityNotes: 'WCAG AA-compliant contrast and scalable typography.',
  ),

  Project(
    name: 'Meaningful',
    date: 'Septembr 2024',
    projectType: 'MOBILE APP',
    isOngoing: true,
    summary: 'A mobile app for mental well-being.',
    techStack: [
      TechStack('Flutter', Colors.blue),
      TechStack('AWS', Colors.orange),
      TechStack('GitHub', Colors.blueGrey), // Black
      TechStack('Figma', Colors.pinkAccent),
      TechStack('Inkscape', Colors.indigo),
      TechStack('EmailJS', Colors.orangeAccent), // Orange
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
      ProjectImage(
        assetPath('images/pondering_lime_shadowed.png'),
        caption: 'Second onboarding screen\'s illustration | Lime theme',
      ),
    ],
    myIllustrations: [
      ProjectImage(
        assetPath('images/pondering_lime_shadowed.png'),
        caption: 'Second onboarding screen\'s illustration | Lime theme',
      ),
      ProjectImage(
        assetPath('images/pondering_dusk_shadowed.png'),
        caption: 'Second onboarding screen´s illustration | Dusk theme',
      ),
      ProjectImage(
        assetPath('images/handphone_invisibg.png'),
        caption: 'Illustration for a Success screen | Neutral',
      ),
      ProjectImage(
        assetPath('images/astronaut.png'),
        caption:
            'Third onboarding screen\'s astronaut illustration (& a metaphor for exploration and self-discovery) | Neutral',
      ),
    ],
    logoPath: assetPath('/images/meaningfulLogo-transparentBg.png'),
    demoUrl: 'https://demo.projecttwo.com',
    repoUrl: 'https://github.com/username/projecttwo',
    accessibilityNotes: 'WCAG AA-compliant contrast and scalable typography.',
    // Add other fields as needed...
  ),
  // Add other projects...
];
