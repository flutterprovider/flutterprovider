import 'package:flutter/material.dart';
import '../shared_prefs/prefs_service.dart';
import '../shared_prefs/prefs_keys.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() {
    _isDarkMode =
        PrefsService.instance.getBool(PrefsKeys.isDarkMode) ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await PrefsService.instance.setBool(PrefsKeys.isDarkMode, _isDarkMode);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await PrefsService.instance.setBool(PrefsKeys.isDarkMode, value);
    notifyListeners();
  }
}
