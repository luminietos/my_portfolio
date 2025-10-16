import 'package:flutter/material.dart';
import 'project.dart';
import 'package:my_portfolio/utils.dart';

final List<Project> projects = [
  Project(
    name: 'My Portfolio',
    date: 'October 2025',
    projectType: 'CROSS-PLATFORM PORTFOLIO',
    isOngoing: false,
    summary:
        'A modern, responsive and accessible portfolio, built entirely with Flutter.',
    purpose:
        'This portfolio showcases my design philosophy, technical skills, and professional work in a cohesive, visually refined experience. It is fully responsive, accessible, and optimized for both web and mobile.',
    actionsAndProcess: '''
– Designed and developed a custom Flutter-based web portfolio from scratch.  
– Implemented light/dark themes with dynamic color palettes.  
– Created responsive layouts following Material 3 and MUI breakpoints.  
– Integrated Lottie animations and custom illustrations for a personal touch.  
– Built reusable widgets for cards, forms, and navigation transitions.  
– Ensured accessibility and performance with semantic structure and responsive typography.  
''',
    result:
        'A cohesive personal brand identity and an engaging, responsive portfolio that runs seamlessly across all devices.',
    projectLink: 'https://github.com/luminietos/my_portfolio/tree/gh-pages',
    clientOrCompany: 'Personal Project',
    duration: 'August–October 2025',
    techStack: [
      TechStack('Flutter', Colors.blue),
      TechStack('Dart', Colors.indigo),
      TechStack('Lottie', Colors.orangeAccent),
      TechStack('Figma', Colors.pinkAccent),
      TechStack('GitHub Pages', Colors.grey),
    ],
    rolesStack: [Roles('Designer'), Roles('Developer'), Roles('Illustrator')],
    imagePaths: [
      ProjectImage(
        assetPath('images/portfolio_screenshot_home.png'),
        caption: 'Landing Page of the Portfolio | Light Mode',
      ),
      ProjectImage(
        assetPath('images/portfolio_screenshot_contact.png'),
        caption: 'Responsive Contact Page | Dark Mode',
      ),
    ],
    logoPath: assetPath('images/logo_myportfolio_black.png'),
    accessibilityNotes:
        'WCAG AA-compliant typography, scalable UI, and full keyboard navigation.',
  ),

  Project(
    name: 'Meaningful',
    date: 'September 2024',
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
    projectLink: 'https://taigoa.fi/projects',
    clientOrCompany: 'Taigoa Oy',
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
    collaborationTools: ['Slack', 'Google Meet', 'Notion', 'Workzep'],
    collaboration: '''
– Followed Agile-inspired workflows with consistent sprint cadence.  
– Daily stand-up meetings to discuss progress and blockers.  
– Weekly design sessions between product lead and designer to iterate UI/UX.  
– Bi-weekly backlog grooming and sprint planning to manage development priorities.  
– Friday recaps to review weekly progress and plan the next sprint.  
– Monthly roadmap sessions to evaluate broader goals and alignment with the team’s vision.  
– Fully remote, cross-cultural collaboration in English.  
''',
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
  Project(
    name: 'Workzep',
    date: 'March 2025',
    projectType: 'WEB PLATFORM',
    isOngoing: false,
    summary: 'An AI-driven Goal Management Web Platform.',
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
    clientOrCompany: 'Taigoa Oy',
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
    collaborationTools: ['Slack', 'Google Meet', 'Notion', 'Workzep'],
    collaboration: '''
– Operated within an Agile framework emphasizing transparency and accountability.  
– Conducted daily stand-up meetings to align goals and track blockers.  
– Bi-weekly backlog refinement sessions for prioritizing development tasks.  
– Weekly sprint reviews to evaluate progress and define next goals.  
– Monthly roadmap meetings with cross-functional teams to adjust priorities and deliverables.  
– Collaborated remotely with designers and developers across multiple time zones, maintaining English as the working language.  
''',
    imagePaths: [
      ProjectImage(
        assetPath('images/screenshot_wz_commandcenter.png'),
        caption:
            'The Command Center; showcasing key metrics and project statuses. | Light mode',
      ),
    ],
    accessibilityNotes: 'WCAG AA-compliant contrast and scalable typography.',
  ),
];
