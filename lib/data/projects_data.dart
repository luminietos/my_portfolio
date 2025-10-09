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
        'Workzep is an AI-powered goal management platform designed to enhance organizational transparency, streamline workflows, and foster collaboration across teams. By intelligently tracking objectives and providing actionable insights, the platform ensures that all stakeholders remain aligned, informed, and empowered to make data-driven decisions efficiently.',
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
    purpose:
        'Meaningful is a mobile app designed to help users enhance their life satisfaction by tracking moods, reflecting on daily experiences, and engaging in positive challenges and goal-setting exercises. It encourages self-awareness and personal growth in a supportive, non-judgmental environment.',

    actionsAndProcess: '''
– Designed an intuitive mobile interface for seamless mood logging and goal tracking.
– Developed features to visualize life satisfaction trends and provide actionable insights.
– Created interactive challenges and exercises that promote happiness and mindfulness.
– Ensured accessibility and inclusivity through scalable typography, high contrast, and responsive layouts.
– Collaborated with developers to integrate AI-powered recommendations and reminders.
''',
    result:
        'Users can track their progress, gain insights into life satisfaction trends, and engage in actionable exercises that foster long-term well-being. The app provides a positive, encouraging environment that promotes reflection and self-improvement.',

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
        assetPath('images/screenshot_settings_bugreport.png'),
        caption:
            'Users can report any issues or bugs directly within the app. | Both modes, both themes',
      ),
      ProjectImage(
        assetPath('images/screenshot_profile.png'),
        caption:
            'Users can change their profile picture, view their data, log out and see the app version they\'re using. | Both modes, both themes',
      ),
    ],
    myIllustrations: [
      ProjectImage(
        assetPath('images/pondering_lime_shadowed.png'),
        caption: 'Second onboarding screen\'s illustration | Lime theme',
      ),
      ProjectImage(
        assetPath('images/pondering_dusk_shadowed.png'),
        caption: 'Second onboarding screen\'s illustration | Dusk theme',
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
