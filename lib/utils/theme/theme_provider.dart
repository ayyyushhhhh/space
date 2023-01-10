import 'package:flutter/material.dart';
import 'package:space/utils/pref.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = SharedPreferencesHelper.getSavedTheme() == 1 ? true : false;

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    SharedPreferencesHelper.saveTheme(isDarkMode);
    notifyListeners();
  }
}
