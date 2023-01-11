import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class SharedPreferencesHelper {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveTheme(bool isDark) {
    int themeIndex = 0;
    if (isDark == true) {
      themeIndex = 1;
    }
    preferences!.setInt("themeindex", themeIndex);
  }

  static int getSavedTheme() {
    final index = preferences!.getInt("themeindex");

    if (index == null) {
      return 0;
    }

    return index;
  }

  static void saveAuthPermission(bool canAuth) {
    int permissionIndex = 0;
    if (canAuth == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("permission", permissionIndex);
  }

  static bool getAuthPermission() {
    final index = preferences!.getInt("permission");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }
}
