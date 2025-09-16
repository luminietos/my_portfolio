import 'dart:math' as math; // ADDED (used by the overlay to compute max radius)
import 'package:flutter/material.dart';
import '../../theme/app_themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart'; // ADDED (make sure the path is correct)

class TabRow extends ConsumerStatefulWidget {
  final String currentTab;
  final Function(String) onTabSelected;

  const TabRow({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  ConsumerState<TabRow> createState() => _TabRowState();
}

class _TabRowState extends ConsumerState<TabRow> {
  // Helper used to toggle the theme and show the expanding wave overlay.
  void _toggleThemeAt(Offset globalPosition, ThemeMode currentMode) {
    final overlay = Overlay.of(context);
    if (overlay == null) {
      ref.read(themeModeProvider.notifier).toggle();
      return;
    }

    // Resolve system -> concrete dark/light
    final mode = currentMode == ThemeMode.system
        ? (MediaQuery.of(context).platformBrightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light)
        : currentMode;

    final Color targetBg = mode == ThemeMode.dark
        ? lightTheme.scaffoldBackgroundColor
        : darkTheme.scaffoldBackgroundColor;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => ThemeWaveOverlay(
        center: globalPosition,
        color: targetBg,
        duration: const Duration(milliseconds: 650),
        onFinish: () {
          entry.remove();
        },
      ),
    );

    overlay.insert(entry);

    // toggle
    ref.read(themeModeProvider.notifier).state = mode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isTinyScreen = width <= 500;
    final bool isUltraTinyScreen = width <= 270;

    double fontSize;
    double horizontalPadding;

    if (width >= 960) {
      fontSize = 16;
      horizontalPadding = 20;
    } else if (width >= 600) {
      fontSize = 14;
      horizontalPadding = 16;
    } else {
      fontSize = 12;
      horizontalPadding = 12;
    }

    // List of tabs with labels + icons
    final List<Map<String, dynamic>> tabs = [
      {'icon': Icons.home, 'label': 'Home', 'key': 'home'},
      {'icon': Icons.build, 'label': 'Projects', 'key': 'projects'},
      {'icon': Icons.info, 'label': 'About', 'key': 'about'},
      {'icon': Icons.mail, 'label': 'Contact', 'key': 'contact'},
    ];

    // 👇 watch theme provider (ADDED)
    final themeMode = ref.watch(themeModeProvider);

    if (isUltraTinyScreen) {
      // Ultra tiny screens (< 270px)
      // Compute crossAxisCount safely
      int crossAxisCount = (width / 40).floor().clamp(1, tabs.length);

      double iconSize = (width / crossAxisCount * 0.6).clamp(16, 24);

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(Spacing.of(1)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...tabs.map((tab) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.of(0)),
                child: _NavButton(
                  icon: tab['icon'],
                  label: tab['label'],
                  selected: widget.currentTab == tab['key'],
                  onTap: () => widget.onTabSelected(tab['key']),
                  fontSize: fontSize,
                  horizontalPadding: horizontalPadding / 2,
                  isTinyScreen: true,
                  iconSize: iconSize, // dynamic icon size
                ),
              );
            }).toList(),

            // Theme toggle button
            Semantics(
              label: themeMode == ThemeMode.dark
                  ? 'Switch to light mode'
                  : 'Switch to dark mode',
              button: true,
              child: Tooltip(
                message: themeMode == ThemeMode.dark
                    ? 'Switch to light mode'
                    : 'Switch to dark mode',
                child: GestureDetector(
                  onTapDown: (details) {
                    _toggleThemeAt(details.globalPosition, themeMode);
                  },
                  child: IconButton(
                    icon: Icon(
                      themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: themeMode == ThemeMode.dark
                          ? AppColors.accentYellow
                          : Theme.of(context).colorScheme.primary,
                      size: iconSize,
                    ),
                    onPressed: () {
                      final center = Offset(width - 24, 24);
                      _toggleThemeAt(center, themeMode);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (isTinyScreen) {
      // Row of icon buttons for tiny screens
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.of(3)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...tabs.map((tab) {
              return _NavButton(
                icon: tab['icon'],
                label: tab['label'],
                selected: widget.currentTab == tab['key'],
                onTap: () => widget.onTabSelected(tab['key']),
                fontSize: fontSize,
                horizontalPadding: horizontalPadding,
                isTinyScreen: true,
              );
            }),
            const Spacer(),

            // Theme toggle button for tiny screens (ADDED)
            // Replace your existing GestureDetector/IconButton code for the theme toggle with this:
            Semantics(
              label: themeMode == ThemeMode.dark
                  ? 'Switch to light mode'
                  : 'Switch to dark mode',
              button: true,
              child: Tooltip(
                message: themeMode == ThemeMode.dark
                    ? 'Switch to light mode'
                    : 'Switch to dark mode',
                child: GestureDetector(
                  onTapDown: (details) {
                    _toggleThemeAt(details.globalPosition, themeMode);
                  },
                  child: IconButton(
                    icon: Icon(
                      themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: themeMode == ThemeMode.dark
                          ? AppColors
                                .accentYellow // 🌙 Moon icon color
                          : Theme.of(
                              context,
                            ).colorScheme.primary, // Sun stays primary
                    ),
                    onPressed: () {
                      // Keyboard / accessibility fallback without exact position
                      final center = Offset(
                        MediaQuery.of(context).size.width - 24,
                        24,
                      );
                      _toggleThemeAt(center, themeMode);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Default row with text labels
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.of(2)),
      child: Row(
        mainAxisSize:
            MainAxisSize.max, // changed to max so Spacer pushes toggle to right
        children: [
          ...tabs.map((tab) {
            return _NavButton(
              icon: tab['icon'],
              label: tab['label'],
              selected: widget.currentTab == tab['key'],
              onTap: () => widget.onTabSelected(tab['key']),
              fontSize: fontSize,
              horizontalPadding: horizontalPadding,
              isTinyScreen: false,
            );
          }),
          const Spacer(),

          // Theme toggle button for default layout (ADDED)
          // Replace your existing GestureDetector/IconButton code for the theme toggle with this:
          Semantics(
            label: themeMode == ThemeMode.dark
                ? 'Switch to light mode'
                : 'Switch to dark mode',
            button: true,
            child: Tooltip(
              message: themeMode == ThemeMode.dark
                  ? 'Switch to light mode'
                  : 'Switch to dark mode',
              child: GestureDetector(
                onTapDown: (details) {
                  _toggleThemeAt(details.globalPosition, themeMode);
                },
                child: IconButton(
                  icon: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: themeMode == ThemeMode.dark
                        ? AppColors
                              .accentYellow // 🌙 Moon icon color
                        : Theme.of(
                            context,
                          ).colorScheme.primary, // Sun stays primary
                  ),
                  onPressed: () {
                    // Keyboard / accessibility fallback without exact position
                    final center = Offset(
                      MediaQuery.of(context).size.width - 24,
                      24,
                    );
                    _toggleThemeAt(center, themeMode);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final double fontSize;
  final double horizontalPadding;
  final bool isTinyScreen;
  final double? iconSize; // optional icon size for ultra tiny screens

  const _NavButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.fontSize,
    required this.horizontalPadding,
    required this.isTinyScreen,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    if (isTinyScreen) {
      // ICON-ONLY buttons with Tooltip, Semantics, and focus visual
      return Tooltip(
        message: label,
        child: Semantics(
          label: label,
          button: true,
          selected: selected,
          child: Focus(
            canRequestFocus: true,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: onTap,
              focusColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                  shape: BoxShape.circle,
                  border: selected
                      ? Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        )
                      : null,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: selected
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // TEXT BUTTONS for larger screens with Semantics & focus support
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.of(3)),
      child: Semantics(
        label: label,
        button: true,
        selected: selected,
        child: Focus(
          canRequestFocus: true,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            focusColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 8,
              ),
              decoration: selected
                  ? BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                    )
                  : null,
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Small overlay widget that expands a colored circle (wave) from a center point,
/// then calls onFinish when done. This is inserted as an OverlayEntry by `_toggleThemeAt`.
class ThemeWaveOverlay extends StatefulWidget {
  final Offset center; // global screen coordinates where the animation starts
  final Color color;
  final Duration duration;
  final VoidCallback onFinish;

  const ThemeWaveOverlay({
    super.key,
    required this.center,
    required this.color,
    required this.duration,
    required this.onFinish,
  });

  @override
  State<ThemeWaveOverlay> createState() => _ThemeWaveOverlayState();
}

class _ThemeWaveOverlayState extends State<ThemeWaveOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // small delay to let the final frame settle
          Future.delayed(const Duration(milliseconds: 50), widget.onFinish);
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    // compute a radius that covers the entire screen from the starting point
    final dx = math.max(widget.center.dx, screen.width - widget.center.dx);
    final dy = math.max(widget.center.dy, screen.height - widget.center.dy);
    final maxRadius =
        math.sqrt(dx * dx + dy * dy) * 1.05; // small safety factor

    return IgnorePointer(
      ignoring: true, // allow touches to pass through the overlay
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final progress = Curves.easeInOutCubic.transform(_controller.value);

          final currentRadius = progress * maxRadius;
          final left = widget.center.dx - currentRadius;
          final top = widget.center.dy - currentRadius;

          // 🔹 Ghost wave (delayed, lower opacity)
          final ghostProgress = (progress - 0.2).clamp(
            0.0,
            1.0,
          ); // delay by 20%
          final ghostRadius = ghostProgress * maxRadius;
          final ghostLeft = widget.center.dx - ghostRadius;
          final ghostTop = widget.center.dy - ghostRadius;

          return Stack(
            children: [
              // 👻 Ghost ripple
              Positioned(
                left: ghostLeft,
                top: ghostTop,
                width: ghostRadius * 2,
                height: ghostRadius * 2,
                child: Opacity(
                  opacity: (0.3 - ghostProgress * 0.3).clamp(0.0, 0.3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              // 🌊 Main wave
              Positioned(
                left: left,
                top: top,
                width: currentRadius * 2,
                height: currentRadius * 2,
                child: Transform.scale(
                  scale: 1.05 + progress * 0.05, // tiny bounce
                  child: Opacity(
                    opacity: (1.0 - progress * 0.3).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
