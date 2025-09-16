import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => throw UnimplementedError(
    'themeModeProvider must be overridden in main.dart',
  ),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const _key = 'themeMode';

  ThemeModeNotifier(super.initial);

  /// Set concrete theme (dark or light) and save to SharedPreferences
  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.toString());
  }

  /// Toggle between dark ↔ light
  Future<void> toggle() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setTheme(newMode);
  }

  /// Always returns dark or light; never system
  ThemeMode get concreteMode => state;
}
