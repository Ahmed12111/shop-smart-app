import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  static const String themeStatus = "ThemeStatus";
  bool getIsDark() => _isDark;

  ThemeProvider() {
    getTheme();
  }

  Future<void> setThemeDark({required bool isDark}) async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    prefes.setBool(themeStatus, isDark);
    _isDark = isDark;
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    _isDark = prefes.getBool(themeStatus) ?? false;
    notifyListeners();
    return _isDark;
  }
}
