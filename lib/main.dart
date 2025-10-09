import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/data/project.dart';
import 'package:my_portfolio/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_themes.dart';

import 'package:my_portfolio/widgets/layout/layout_frame.dart';
import 'package:my_portfolio/pages/home_page.dart';
import 'package:my_portfolio/pages/projects_page.dart';
import 'package:my_portfolio/pages/about_page.dart';
import 'package:my_portfolio/pages/contact_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final stored = prefs.getString('themeMode');

  ThemeMode initialTheme;

  if (stored != null) {
    // user has saved preference
    initialTheme = ThemeMode.values.firstWhere(
      (m) => m.toString() == stored,
      orElse: () => ThemeMode.light,
    );
  } else {
    // resolve system theme immediately
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    initialTheme = brightness == Brightness.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  runApp(
    ProviderScope(
      overrides: [
        themeModeProvider.overrideWith(
          (ref) => ThemeModeNotifier(initialTheme),
        ),
      ],
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends ConsumerStatefulWidget {
  const PortfolioApp({super.key});

  @override
  ConsumerState<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends ConsumerState<PortfolioApp> {
  String currentTab = 'home';
  Project? selectedProject; // 👈 NEW

  void _onTabSelected(String tab) {
    setState(() {
      currentTab = tab;
      selectedProject = null; // clear selection when switching tabs
    });
  }

  void _onProjectSelected(Project? project) {
    setState(() {
      currentTab = 'projects';
      selectedProject = project; // 👈 set selected project
    });
  }

  Widget _getPage() {
    switch (currentTab) {
      case 'projects':
        return ProjectsPage(
          selectedProject: selectedProject, // pass down
          onProjectSelected: _onProjectSelected, // pass handler
        );
      case 'about':
        return const AboutPage();
      case 'contact':
        return const ContactPage();
      case 'home':
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 👇 watch the themeModeProvider
    final themeMode = ref.watch(themeModeProvider);

    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Will´s World',
          theme: lightTheme, // from app_themes.dart
          darkTheme: darkTheme, // from app_themes.dart
          themeMode: themeMode, // 👈 controlled by Riverpod
          home: LayoutFrame(
            currentTab: currentTab,
            onTabSelected: _onTabSelected,
            child: _getPage(),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
