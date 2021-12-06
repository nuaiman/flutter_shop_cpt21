import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppTheme {
  static ThemeData myThemes(bool isDark, BuildContext context) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
  }
}

class ThemeNotifier with ChangeNotifier {
  late bool _isDark;

  bool get isDark => _isDark;

  ThemeNotifier() {
    _isDark = false;
    _loadFromPrefs();
    notifyListeners();
  }

  toggleTheme(bool value) {
    _isDark = value;
    notifyListeners();
    _saveToPrefs();
  }

  _loadFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isDark = preferences.getBool('theme') ?? false;
    notifyListeners();
    return _isDark;
  }

  _saveToPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('theme', _isDark);
  }
}
