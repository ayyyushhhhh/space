import 'package:flutter/material.dart';
import 'package:space/utils/pref.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isDarkMode =
      SharedPreferencesHelper.getSavedTheme() == 1 ? true : false;
  bool get isDarkMode => _isDarkMode;

  int _pageState = 0;
  int get pageState => _pageState;

  void updateTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    SharedPreferencesHelper.saveTheme(isDarkMode);
    notifyListeners();
  }

  void updatePage(int page) {
    _pageState = page;
    notifyListeners();
  }
}
