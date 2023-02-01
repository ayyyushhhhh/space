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
    preferences!.setInt("authpermission", permissionIndex);
  }

  static void saveNotificationPermission(bool canNotify) {
    int permissionIndex = 0;
    if (canNotify == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("notifypermission", permissionIndex);
  }

  static void saveNotificationTime(Duration duration) {
    List<String> time = [
      duration.inHours.toString(),
      duration.inMinutes.remainder(60).toString()
    ];

    preferences!.setStringList("notifytime", time);
  }

  static void saveLocale({required bool hasLocale}) {
    preferences!.setInt("hasLocale", hasLocale ? 1 : 0);
  }

  static bool hasSavedLocale() {
    final index = preferences!.getInt("hasLocale");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static Duration getNotificationTime() {
    List<String>? time = preferences!.getStringList("notifytime");
    if (time == null) {
      return const Duration(hours: 20, minutes: 00);
    }

    return Duration(hours: int.parse(time[0]), minutes: int.parse(time[1]));
  }

  static bool getNotificationPermission() {
    final index = preferences!.getInt("authpermission");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static bool getAuthPermission() {
    final index = preferences!.getInt("authpermission");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }
}
