import 'package:flutter/material.dart';

import '../core/prefs/domain/app_prefs_repository.dart';

class ThemeModeController extends ChangeNotifier {
  ThemeModeController(this._prefs);

  final AppPrefsRepository _prefs;

  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;

  Future<void> load() async {
    final raw = await _prefs.themeMode();
    _mode = switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    final raw = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      _ => 'system',
    };
    await _prefs.setThemeMode(raw);
  }
}

